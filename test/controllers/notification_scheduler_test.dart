import 'package:clock/clock.dart';
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
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/planned_notification.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/l10n/app_localizations_en.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../util/test_clock.dart';

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

PlannedOccurrence occurrencePlan({
  MedicationSchedule? schedule,
  DateTime? dateTime,
}) =>
    PlannedOccurrence(
      schedule ?? _defaultSchedule(),
      dateTime: dateTime ?? DateTime.utc(2026, 6, 2, 9, 0),
    );

PlannedRepeating dailyPlan({
  MedicationSchedule? schedule,
  TimeOfDay time = const TimeOfDay(hour: 9, minute: 0),
  DateTime? firstFire,
}) =>
    PlannedRepeating(
      schedule ?? _defaultSchedule(),
      periodicity: Periodicity.daily,
      firstFire: firstFire ?? DateTime.utc(2026, 6, 2, 9, 0),
      time: time,
    );

PlannedRepeating weeklyPlan({
  MedicationSchedule? schedule,
  int dayOfWeek = 1,
  TimeOfDay time = const TimeOfDay(hour: 9, minute: 0),
  DateTime? firstFire,
}) =>
    PlannedRepeating(
      schedule ?? _defaultSchedule(),
      periodicity: Periodicity.weekly,
      firstFire: firstFire ?? DateTime.utc(2026, 6, 8, 9, 0),
      time: time,
      dayOfWeek: dayOfWeek,
    );

MedicationSchedule _defaultSchedule() => schedule();

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
    when(occurrences.planNotifications(days: anyNamed('days')))
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
        final sut = NotificationScheduler(occurrences, preferences);

        await sut.regenerateAll(l10n, l10n.localeName);

        verify(plugin.cancel(id: anyNamed('id'))).called(1);
      });
    });
  });

  group('regenerateAll', () {
    test('returns early when notifications are disabled', () async {
      when(preferences.notificationsEnabled).thenReturn(false);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyNever(occurrences.planNotifications(days: anyNamed('days')));
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
      final s = schedule();
      when(occurrences.planNotifications(days: 30)).thenReturn([
        occurrencePlan(schedule: s, dateTime: DateTime.utc(2026, 6, 2, 9, 0)),
        dailyPlan(
            schedule: s,
            time: const TimeOfDay(hour: 14, minute: 0),
            firstFire: DateTime.utc(2026, 6, 2, 14, 0)),
        weeklyPlan(
            schedule: s,
            dayOfWeek: 3,
            time: const TimeOfDay(hour: 20, minute: 0),
            firstFire: DateTime.utc(2026, 6, 3, 20, 0)),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(3);
    });

    test('PlannedOccurrence -> one-shot, body uses date only', () async {
      final s = schedule(name: 'My Med');
      final fire = DateTime.utc(2026, 6, 7, 8, 30);
      when(occurrences.planNotifications(days: 30))
          .thenReturn([occurrencePlan(schedule: s, dateTime: fire)]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      final expectedDate = DateFormat.MMMMd(l10n.localeName).format(fire);
      verifyScheduled(
        body: equals(l10n.notificationMedicationReminderBodyDate(expectedDate)),
        matchDateTimeComponents: isNull,
      ).called(1);
    });

    test('PlannedRepeating(daily) -> matches on time only, body uses time only',
        () async {
      final s = schedule(name: 'My Med');
      final fire = DateTime.utc(2026, 6, 2, 8, 30);
      when(occurrences.planNotifications(days: 30)).thenReturn([
        dailyPlan(
            schedule: s,
            time: const TimeOfDay(hour: 8, minute: 30),
            firstFire: fire),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      final expectedTime = DateFormat.Hm(l10n.localeName).format(fire);
      verifyScheduled(
        body: equals(l10n.notificationMedicationReminderBodyTime(expectedTime)),
        matchDateTimeComponents: equals(DateTimeComponents.time),
      ).called(1);
    });

    test(
        'PlannedRepeating(weekly) -> matches on dayOfWeek+time, body uses weekday only',
        () async {
      final s = schedule(name: 'My Med');
      // 2026-06-08 is a Monday.
      final fire = DateTime.utc(2026, 6, 8, 20, 0);
      when(occurrences.planNotifications(days: 30)).thenReturn([
        weeklyPlan(
            schedule: s,
            dayOfWeek: 1,
            time: const TimeOfDay(hour: 20, minute: 0),
            firstFire: fire),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      final expectedWeekday = DateFormat.EEEE(l10n.localeName).format(fire);
      verifyScheduled(
        body: equals(
            l10n.notificationMedicationReminderBodyWeekday(expectedWeekday)),
        matchDateTimeComponents: equals(DateTimeComponents.dayOfWeekAndTime),
      ).called(1);
    });

    test('titles notifications with the schedule name', () async {
      final s = schedule(name: 'My Med');
      when(occurrences.planNotifications(days: 30))
          .thenReturn([occurrencePlan(schedule: s)]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled(title: l10n.notificationMedicationReminderTitle('My Med'))
          .called(1);
    });

    test('two schedules each get their own notification', () async {
      final a = schedule(id: 1, name: 'A');
      final b = schedule(id: 2, name: 'B');
      when(occurrences.planNotifications(days: 30)).thenReturn([
        occurrencePlan(schedule: a),
        occurrencePlan(schedule: b),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled(title: l10n.notificationMedicationReminderTitle('A'))
          .called(1);
      verifyScheduled(title: l10n.notificationMedicationReminderTitle('B'))
          .called(1);
    });

    test('schedules at most 64 notifications', () async {
      final s = schedule();
      final plans = List.generate(
        100,
        (i) => occurrencePlan(
          schedule: s,
          dateTime: DateTime.utc(2026, 6, 2, 9, 0).add(Duration(days: i + 1)),
        ),
      );
      when(occurrences.planNotifications(days: 30)).thenReturn(plans);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(64);
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

    test('the same PlannedOccurrence yields the same id across regenerations',
        () async {
      final s = schedule(id: 7);
      final plans = [
        occurrencePlan(schedule: s, dateTime: DateTime.utc(2026, 6, 2, 9, 0)),
        occurrencePlan(schedule: s, dateTime: DateTime.utc(2026, 6, 3, 9, 0)),
        occurrencePlan(schedule: s, dateTime: DateTime.utc(2026, 6, 4, 9, 0)),
      ];
      when(occurrences.planNotifications(days: 30)).thenReturn(plans);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);
      await sut.regenerateAll(l10n, l10n.localeName);

      final ids = capturedScheduledIds();
      expect(ids.sublist(0, 3), equals(ids.sublist(3, 6)));
    });

    test('PlannedRepeating(daily): same (schedule, time) yields the same id',
        () async {
      final s = schedule(id: 7);
      final plan = dailyPlan(
        schedule: s,
        time: const TimeOfDay(hour: 8, minute: 30),
      );
      when(occurrences.planNotifications(days: 30)).thenReturn([plan]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);
      await sut.regenerateAll(l10n, l10n.localeName);

      final ids = capturedScheduledIds();
      expect(ids[0], equals(ids[1]));
    });

    test(
        'PlannedRepeating(weekly): same (schedule, dayOfWeek, time) yields the same id',
        () async {
      final s = schedule(id: 7);
      final plan = weeklyPlan(
        schedule: s,
        dayOfWeek: 3,
        time: const TimeOfDay(hour: 8, minute: 30),
      );
      when(occurrences.planNotifications(days: 30)).thenReturn([plan]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);
      await sut.regenerateAll(l10n, l10n.localeName);

      final ids = capturedScheduledIds();
      expect(ids[0], equals(ids[1]));
    });

    test('distinct plans yield distinct ids', () async {
      // Realistic mix: a schedule's `scheduling` is a single strategy, so
      // in production one schedule emits only one variant. Cross-variant
      // mixes shown here come from different schedules.
      final a = schedule(id: 1, name: 'A'); // interval-days
      final b = schedule(id: 2, name: 'B'); // daily
      final c = schedule(id: 3, name: 'C'); // weekly
      when(occurrences.planNotifications(days: 30)).thenReturn([
        occurrencePlan(schedule: a, dateTime: DateTime.utc(2026, 6, 2, 9, 0)),
        occurrencePlan(schedule: a, dateTime: DateTime.utc(2026, 6, 3, 9, 0)),
        dailyPlan(schedule: b, firstFire: DateTime.utc(2026, 6, 2, 9, 0)),
        weeklyPlan(schedule: c, firstFire: DateTime.utc(2026, 6, 8, 9, 0)),
      ]);
      final sut = NotificationScheduler(occurrences, preferences);

      await sut.regenerateAll(l10n, l10n.localeName);

      final ids = capturedScheduledIds();
      expect(ids.toSet().length, equals(ids.length));
    });
  });
}
