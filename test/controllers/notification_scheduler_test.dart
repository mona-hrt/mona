// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Frozzie "Frozzie89"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/notification_planner.dart';
import 'package:mona/controllers/notification_scheduler.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../fixtures.dart';
import '../util/test_clock.dart';

@GenerateNiceMocks([
  MockSpec<NotificationPlanner>(),
  MockSpec<PreferencesService>(),
  MockSpec<FlutterLocalNotificationsPlugin>(),
])
import 'notification_scheduler_test.mocks.dart';

void main() {
  late MockNotificationPlanner planner;
  late MockPreferencesService preferences;
  late MockFlutterLocalNotificationsPlugin plugin;
  late bool Function()? origPlatformCheck;
  late FlutterLocalNotificationsPlugin Function()? origCreatePlugin;

  setUpAll(() async {
    await initializeDateFormatting('en');
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Etc/UTC'));
  });

  setUp(() {
    planner = MockNotificationPlanner();
    preferences = MockPreferencesService();
    plugin = MockFlutterLocalNotificationsPlugin();

    origPlatformCheck = NotificationService.isPlatformSupported;
    origCreatePlugin = NotificationService.createPlugin;
    NotificationService.isPlatformSupported = () => true;
    NotificationService.createPlugin = () => plugin;

    when(preferences.notificationsEnabled).thenReturn(true);
    when(planner.planNotifications(maxScheduled: anyNamed('maxScheduled')))
        .thenReturn(const []);
    when(plugin.zonedSchedule(
      id: anyNamed('id'),
      title: anyNamed('title'),
      body: anyNamed('body'),
      scheduledDate: anyNamed('scheduledDate'),
      notificationDetails: anyNamed('notificationDetails'),
      androidScheduleMode: anyNamed('androidScheduleMode'),
      matchDateTimeComponents: anyNamed('matchDateTimeComponents'),
      payload: anyNamed('payload'),
    )).thenAnswer((_) async {});
  });

  tearDown(() {
    NotificationService.isPlatformSupported = origPlatformCheck;
    NotificationService.createPlugin = origCreatePlugin;
  });

  VerificationResult verifyScheduled({
    String? title,
    Matcher? body,
    Matcher? matchDateTimeComponents,
  }) =>
      verify(plugin.zonedSchedule(
        id: anyNamed('id'),
        title: title != null
            ? argThat(equals(title), named: 'title')
            : anyNamed('title'),
        body: body != null ? argThat(body, named: 'body') : anyNamed('body'),
        scheduledDate: anyNamed('scheduledDate'),
        notificationDetails: anyNamed('notificationDetails'),
        androidScheduleMode: anyNamed('androidScheduleMode'),
        matchDateTimeComponents: matchDateTimeComponents != null
            ? argThat(matchDateTimeComponents, named: 'matchDateTimeComponents')
            : anyNamed('matchDateTimeComponents'),
        payload: anyNamed('payload'),
      ));

  group('pending notifications', () {
    test('regenerateAll triggers past pending notifications', () async {
      await withFixedClockAsync(() async {
        final pending = PendingNotificationRequest(
          1,
          'title',
          'body',
          '{"scheduledTime":"${clock.now().subtract(const Duration(days: 1)).toIso8601String()}"}',
        );
        when(plugin.pendingNotificationRequests())
            .thenAnswer((_) async => [pending]);
        when(plugin.show(
          id: anyNamed('id'),
          title: anyNamed('title'),
          body: anyNamed('body'),
          notificationDetails: anyNamed('notificationDetails'),
          payload: anyNamed('payload'),
        )).thenAnswer((_) async {});
        final sut = NotificationScheduler(planner, preferences);

        await sut.regenerateAll('en');

        verify(plugin.show(
          id: anyNamed('id'),
          title: argThat(equals('title'), named: 'title'),
          body: argThat(equals('body'), named: 'body'),
          notificationDetails: anyNamed('notificationDetails'),
          payload: anyNamed('payload'),
        )).called(1);
      });
    });

    test('regenerateAll cancels pending notifications', () async {
      await withFixedClockAsync(() async {
        final pending = PendingNotificationRequest(
          1,
          'title',
          'body',
          '{"scheduledTime":"${clock.now().add(const Duration(days: 1)).toIso8601String()}"}',
        );
        when(plugin.pendingNotificationRequests())
            .thenAnswer((_) async => [pending]);
        when(plugin.cancel(id: anyNamed('id'))).thenAnswer((_) async {});
        final sut = NotificationScheduler(planner, preferences);

        await sut.regenerateAll('en');

        verify(plugin.cancel(id: anyNamed('id'))).called(1);
      });
    });
  });

  group('regenerateAll', () {
    test('returns early when notifications are disabled', () async {
      when(preferences.notificationsEnabled).thenReturn(false);
      final sut = NotificationScheduler(planner, preferences);

      await sut.regenerateAll('en');

      verifyNever(
          planner.planNotifications(maxScheduled: anyNamed('maxScheduled')));
      verifyNever(plugin.zonedSchedule(
        id: anyNamed('id'),
        title: anyNamed('title'),
        body: anyNamed('body'),
        scheduledDate: anyNamed('scheduledDate'),
        notificationDetails: anyNamed('notificationDetails'),
        androidScheduleMode: anyNamed('androidScheduleMode'),
        matchDateTimeComponents: anyNamed('matchDateTimeComponents'),
        payload: anyNamed('payload'),
      ));
    });

    test('schedules one zonedSchedule call per plan', () async {
      // Arrange
      final s = aMedicationSchedule();
      when(planner.planNotifications(maxScheduled: anyNamed('maxScheduled')))
          .thenReturn([
        anOccurrencePlan(schedule: s, dateTime: DateTime.utc(2026, 6, 2, 9, 0)),
        anOccurrencePlan(
            schedule: s, dateTime: DateTime.utc(2026, 6, 2, 14, 0)),
        anOccurrencePlan(
            schedule: s, dateTime: DateTime.utc(2026, 6, 3, 20, 0)),
      ]);
      final sut = NotificationScheduler(planner, preferences);

      // Act
      await sut.regenerateAll('en');

      // Assert
      verifyScheduled().called(3);
    });

    test('PlannedOccurrence -> one-shot', () async {
      // Arrange
      when(planner.planNotifications(maxScheduled: anyNamed('maxScheduled')))
          .thenReturn([anOccurrencePlan(schedule: aMedicationSchedule())]);
      final sut = NotificationScheduler(planner, preferences);

      // Act
      await sut.regenerateAll('en');

      // Assert
      verifyScheduled(
        matchDateTimeComponents: isNull,
      ).called(1);
    });
  });

  group('body', () {
    final cases = [
      (
        'daily schedule -> shows the time',
        aDailyStrategy(),
        'Scheduled for 09:00'
      ),
      (
        'weekly schedule -> shows the weekday',
        aWeeklyStrategy(),
        'Scheduled for Tuesday'
      ),
      (
        'interval schedule -> shows the date',
        anIntervalStrategy(),
        'Scheduled for June 2'
      ),
      (
        'dynamic interval schedule -> shows the date',
        aDynamicIntervalStrategy(),
        'Scheduled for June 2'
      ),
      (
        'monthly schedule -> shows the date',
        aMonthlyStrategy(),
        'Scheduled for June 2'
      ),
    ];

    for (final (name, scheduling, body) in cases) {
      test(name, () async {
        // Arrange
        when(planner.planNotifications(maxScheduled: anyNamed('maxScheduled')))
            .thenReturn([
          anOccurrencePlan(
              schedule: aMedicationSchedule(scheduling: scheduling))
        ]);
        final sut = NotificationScheduler(planner, preferences);

        // Act
        await sut.regenerateAll('en');

        // Assert
        verifyScheduled(body: equals(body)).called(1);
      });
    }
  });

  group('payload', () {
    String capturedScheduledPayload() => verify(plugin.zonedSchedule(
          id: anyNamed('id'),
          title: anyNamed('title'),
          body: anyNamed('body'),
          scheduledDate: anyNamed('scheduledDate'),
          notificationDetails: anyNamed('notificationDetails'),
          androidScheduleMode: anyNamed('androidScheduleMode'),
          matchDateTimeComponents: anyNamed('matchDateTimeComponents'),
          payload: captureAnyNamed('payload'),
        )).captured.single as String;

    test('embeds the schedule id in the scheduled payload', () async {
      // Arrange
      when(planner.planNotifications(maxScheduled: anyNamed('maxScheduled')))
          .thenReturn(
              [anOccurrencePlan(schedule: aMedicationSchedule(id: 42))]);
      final sut = NotificationScheduler(planner, preferences);

      // Act
      await sut.regenerateAll('en');

      // Assert
      final payload =
          jsonDecode(capturedScheduledPayload()) as Map<String, Object?>;
      expect(payload['scheduleId'], 42);
    });
  });

  group('notification ids', () {
    List<int> capturedScheduledIds() => verify(plugin.zonedSchedule(
          id: captureAnyNamed('id'),
          title: anyNamed('title'),
          body: anyNamed('body'),
          scheduledDate: anyNamed('scheduledDate'),
          notificationDetails: anyNamed('notificationDetails'),
          androidScheduleMode: anyNamed('androidScheduleMode'),
          matchDateTimeComponents: anyNamed('matchDateTimeComponents'),
          payload: anyNamed('payload'),
        )).captured.cast<int>();

    test('distinct plans yield distinct ids', () async {
      // Arrange
      final a = aMedicationSchedule();
      final b = aMedicationSchedule();
      final c = aMedicationSchedule();
      when(planner.planNotifications(maxScheduled: anyNamed('maxScheduled')))
          .thenReturn([
        anOccurrencePlan(schedule: a, dateTime: DateTime.utc(2026, 6, 2, 9, 0)),
        anOccurrencePlan(schedule: a, dateTime: DateTime.utc(2026, 6, 3, 9, 0)),
        anOccurrencePlan(schedule: b, dateTime: DateTime.utc(2026, 6, 2, 9, 0)),
        anOccurrencePlan(schedule: c, dateTime: DateTime.utc(2026, 6, 2, 9, 0)),
      ]);
      final sut = NotificationScheduler(planner, preferences);

      // Act
      await sut.regenerateAll('en');

      // Assert
      final ids = capturedScheduledIds();
      expect(ids.toSet().length, equals(ids.length));
    });
  });
}
