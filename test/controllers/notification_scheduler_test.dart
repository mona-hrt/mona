// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/notification_scheduler.dart';
import 'package:mona/controllers/occurrences_manager.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduled_occurrence.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/l10n/app_localizations_en.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@GenerateNiceMocks([
  MockSpec<OccurrencesManager>(),
  MockSpec<PreferencesService>(),
  MockSpec<FlutterLocalNotificationsPlugin>(),
])
import 'notification_scheduler_test.mocks.dart';

MedicationSchedule schedule({int id = 1, String name = 'Med'}) =>
    MedicationSchedule(
      id: id,
      name: name,
      dose: Decimal.fromInt(10),
      scheduling: IntervalDaysSchedule(intervalDays: 1),
      molecule: KnownMolecules.estradiol,
      administrationRoute: AdministrationRoute.oral,
    );

const _unset = Object();

ScheduledOccurrence occurrence({
  MedicationSchedule? schedule,
  Date? date,
  TimeOfDay? time = const TimeOfDay(hour: 12, minute: 0),
  Object? notificationTime = _unset,
  ScheduleStatus status = ScheduleStatus.upcoming,
  bool notifiable = true,
}) {
  final notifTime = identical(notificationTime, _unset)
      ? time
      : notificationTime as TimeOfDay?;
  return ScheduledOccurrence(
    schedule: schedule ??
        MedicationSchedule(
          id: 0,
          name: 'Med',
          dose: Decimal.fromInt(10),
          scheduling: IntervalDaysSchedule(intervalDays: 1),
          molecule: KnownMolecules.estradiol,
          administrationRoute: AdministrationRoute.oral,
        ),
    date: date ?? Date.today().add(const Duration(days: 1)),
    time: time,
    notificationTime: notifTime,
    status: status,
    notifiable: notifiable,
  );
}

void main() {
  final l10n = AppLocalizationsEn();

  late MockOccurrencesManager occurrences;
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
    occurrences = MockOccurrencesManager();
    preferences = MockPreferencesService();
    plugin = MockFlutterLocalNotificationsPlugin();

    origPlatformCheck = NotificationService.isPlatformSupported;
    origCreatePlugin = NotificationService.createPlugin;
    NotificationService.isPlatformSupported = () => true;
    NotificationService.createPlugin = () => plugin;

    when(preferences.notificationsEnabled).thenReturn(true);
    when(plugin.zonedSchedule(
      id: anyNamed('id'),
      title: anyNamed('title'),
      body: anyNamed('body'),
      scheduledDate: anyNamed('scheduledDate'),
      notificationDetails: anyNamed('notificationDetails'),
      androidScheduleMode: anyNamed('androidScheduleMode'),
      payload: anyNamed('payload'),
    )).thenAnswer((_) async {});
  });

  tearDown(() {
    NotificationService.isPlatformSupported = origPlatformCheck;
    NotificationService.createPlugin = origCreatePlugin;
  });

  VerificationResult verifyScheduled({String? title, Matcher? body}) =>
      verify(plugin.zonedSchedule(
        id: anyNamed('id'),
        title: title != null
            ? argThat(equals(title), named: 'title')
            : anyNamed('title'),
        body: body != null ? argThat(body, named: 'body') : anyNamed('body'),
        scheduledDate: anyNamed('scheduledDate'),
        notificationDetails: anyNamed('notificationDetails'),
        androidScheduleMode: anyNamed('androidScheduleMode'),
        payload: anyNamed('payload'),
      ));

  group('pending notifications', () {
    test('regenerateAll triggers past pending notifications', () async {
      final pending = PendingNotificationRequest(
        1,
        'title',
        'body',
        '{"scheduledTime":"${DateTime.now().subtract(const Duration(days: 1)).toIso8601String()}"}',
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
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, 'en');

      verify(plugin.show(
        id: anyNamed('id'),
        title: argThat(equals('title'), named: 'title'),
        body: argThat(equals('body'), named: 'body'),
        notificationDetails: anyNamed('notificationDetails'),
        payload: anyNamed('payload'),
      )).called(1);
    });

    test('regenerateAll cancels pending notifications', () async {
      final pending = PendingNotificationRequest(
        1,
        'title',
        'body',
        '{"scheduledTime":"${DateTime.now().add(const Duration(days: 1)).toIso8601String()}"}',
      );
      when(plugin.pendingNotificationRequests())
          .thenAnswer((_) async => [pending]);
      when(plugin.cancel(id: anyNamed('id'))).thenAnswer((_) async {});
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verify(plugin.cancel(id: anyNamed('id'))).called(1);
    });
  });

  group('regenerateAll', () {
    test('returns early when notifications are disabled', () async {
      when(preferences.notificationsEnabled).thenReturn(false);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyNever(occurrences.upcoming(days: anyNamed('days')));
      verifyNever(plugin.zonedSchedule(
        id: anyNamed('id'),
        title: anyNamed('title'),
        body: anyNamed('body'),
        scheduledDate: anyNamed('scheduledDate'),
        notificationDetails: anyNamed('notificationDetails'),
        androidScheduleMode: anyNamed('androidScheduleMode'),
        payload: anyNamed('payload'),
      ));
    });

    test('schedules one notification per emitted future occurrence', () async {
      final s = schedule();
      when(occurrences.upcoming(days: 5)).thenReturn([
        occurrence(
            schedule: s, date: Date.today().add(const Duration(days: 1))),
        occurrence(
            schedule: s, date: Date.today().add(const Duration(days: 2))),
        occurrence(
            schedule: s, date: Date.today().add(const Duration(days: 3))),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(3);
    });

    test('skips occurrences with status taken', () async {
      final s = schedule();
      when(occurrences.upcoming(days: 5)).thenReturn([
        occurrence(
            schedule: s,
            date: Date.today().add(const Duration(days: 1)),
            status: ScheduleStatus.taken),
        occurrence(
            schedule: s, date: Date.today().add(const Duration(days: 2))),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(1);
    });

    test('skips occurrences flagged as not notifiable', () async {
      final s = schedule();
      when(occurrences.upcoming(days: 5)).thenReturn([
        occurrence(
            schedule: s,
            date: Date.today().add(const Duration(days: 1)),
            notifiable: false),
        occurrence(
            schedule: s, date: Date.today().add(const Duration(days: 2))),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(1);
    });

    test('skips occurrences with no notification time', () async {
      final s = schedule();
      when(occurrences.upcoming(days: 5)).thenReturn([
        occurrence(
            schedule: s,
            date: Date.today().add(const Duration(days: 1)),
            notificationTime: null),
        occurrence(
            schedule: s, date: Date.today().add(const Duration(days: 2))),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(1);
    });

    test(
        'schedules occurrences with a notification time but no time-of-day, using a date-only body',
        () async {
      final s = schedule(name: 'My Med');
      final date = Date.today().add(const Duration(days: 1));
      when(occurrences.upcoming(days: 5)).thenReturn([
        occurrence(
          schedule: s,
          date: date,
          time: null,
          notificationTime: const TimeOfDay(hour: 8, minute: 30),
        ),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      final expectedDate = DateFormat.MMMMd(l10n.localeName)
          .format(DateTime(date.year, date.month, date.day));
      verifyScheduled(
        body: equals(l10n.notificationMedicationReminderBody(expectedDate)),
      ).called(1);
    });

    test(
        'schedules occurrences with a notification time and time-of-day, using a date-time body',
        () async {
      final s = schedule(name: 'My Med');
      final date = Date.today().add(const Duration(days: 1));
      when(occurrences.upcoming(days: 5)).thenReturn([
        occurrence(
            schedule: s,
            date: date,
            time: const TimeOfDay(hour: 8, minute: 30),
            notificationTime: const TimeOfDay(hour: 8, minute: 30)),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      final expectedDate = DateFormat.MMMMd(l10n.localeName)
          .addPattern(DateFormat.Hm(l10n.localeName).pattern)
          .format(DateTime(date.year, date.month, date.day, 8, 30));
      verifyScheduled(
        body: equals(l10n.notificationMedicationReminderBody(expectedDate)),
      ).called(1);
    });

    test('skips occurrences whose dateTime is in the past', () async {
      final s = schedule();
      final now = DateTime.now();
      final pastTime =
          TimeOfDay.fromDateTime(now.subtract(const Duration(hours: 1)));
      final futureTime =
          TimeOfDay.fromDateTime(now.add(const Duration(hours: 1)));

      when(occurrences.upcoming(days: 5)).thenReturn([
        occurrence(schedule: s, date: Date.today(), time: pastTime),
        occurrence(schedule: s, date: Date.today(), time: futureTime),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(1);
    });

    test('titles notifications with the schedule name', () async {
      final s = schedule(name: 'My Med');
      when(occurrences.upcoming(days: 5)).thenReturn([occurrence(schedule: s)]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled(title: l10n.notificationMedicationReminderTitle('My Med'))
          .called(1);
    });

    test('two schedules at the same time both get scheduled', () async {
      final a = schedule(id: 1, name: 'A');
      final b = schedule(id: 2, name: 'B');
      when(occurrences.upcoming(days: 5)).thenReturn([
        occurrence(schedule: a),
        occurrence(schedule: b),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled(title: l10n.notificationMedicationReminderTitle('A'))
          .called(1);
      verifyScheduled(title: l10n.notificationMedicationReminderTitle('B'))
          .called(1);
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
          payload: anyNamed('payload'),
        )).captured.cast<int>();

    test(
        'the same (schedule, occurrence) pair yields the same id across regenerations',
        () async {
      final s = schedule(id: 7);
      final occurrences3Days = [
        occurrence(
            schedule: s, date: Date.today().add(const Duration(days: 1))),
        occurrence(
            schedule: s, date: Date.today().add(const Duration(days: 2))),
        occurrence(
            schedule: s, date: Date.today().add(const Duration(days: 3))),
      ];
      when(occurrences.upcoming(days: 5)).thenReturn(occurrences3Days);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);
      await sut.regenerateAll(l10n, l10n.localeName);

      final ids = capturedScheduledIds();
      expect(ids.sublist(0, 3), equals(ids.sublist(3, 6)));
    });

    test('distinct (schedule, occurrence) pairs yield distinct ids', () async {
      final a = schedule(id: 1, name: 'A');
      final b = schedule(id: 2, name: 'B');
      when(occurrences.upcoming(days: 5)).thenReturn([
        occurrence(
            schedule: a, date: Date.today().add(const Duration(days: 1))),
        occurrence(
            schedule: a, date: Date.today().add(const Duration(days: 2))),
        occurrence(
            schedule: b, date: Date.today().add(const Duration(days: 1))),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      final ids = capturedScheduledIds();
      expect(ids[0], isNot(equals(ids[1])));
    });
  });
}
