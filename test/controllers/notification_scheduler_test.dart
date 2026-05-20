import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/notification_scheduler.dart';
import 'package:mona/controllers/schedule_occurrences.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduled_occurrence.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/l10n/app_localizations_en.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@GenerateNiceMocks([
  MockSpec<MedicationScheduleProvider>(),
  MockSpec<ScheduleOccurrences>(),
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

ScheduledOccurrence occurrence({
  Date? date,
  TimeOfDay? time = const TimeOfDay(hour: 12, minute: 0),
  ScheduleStatus status = ScheduleStatus.upcoming,
  bool notifiable = true,
}) =>
    ScheduledOccurrence(
      date: date ?? Date.today().add(const Duration(days: 1)),
      time: time,
      status: status,
      notifiable: notifiable,
    );

void main() {
  final l10n = AppLocalizationsEn();

  late MockMedicationScheduleProvider scheduleProvider;
  late MockScheduleOccurrences occurrences;
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
    scheduleProvider = MockMedicationScheduleProvider();
    occurrences = MockScheduleOccurrences();
    preferences = MockPreferencesService();
    plugin = MockFlutterLocalNotificationsPlugin();

    origPlatformCheck = NotificationService.isPlatformSupported;
    origCreatePlugin = NotificationService.createPlugin;
    NotificationService.isPlatformSupported = () => true;
    NotificationService.createPlugin = () => plugin;

    when(preferences.notificationsEnabled).thenReturn(true);
    when(scheduleProvider.schedules).thenReturn([]);
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

  NotificationScheduler buildScheduler() => NotificationScheduler(
        scheduleProvider,
        occurrences,
        preferences,
      );

  VerificationResult verifyScheduled({String? title}) =>
      verify(plugin.zonedSchedule(
        id: anyNamed('id'),
        title: title != null
            ? argThat(equals(title), named: 'title')
            : anyNamed('title'),
        body: anyNamed('body'),
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

      await buildScheduler().regenerateAll(l10n, 'en');

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

      await buildScheduler().regenerateAll(l10n, l10n.localeName);

      verify(plugin.cancel(id: anyNamed('id'))).called(1);
    });
  });

  group('regenerateAll', () {
    test('returns early when notifications are disabled', () async {
      when(preferences.notificationsEnabled).thenReturn(false);
      final s = schedule();
      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.upcomingFor(any, days: anyNamed('days')))
          .thenReturn([occurrence()]);

      await buildScheduler().regenerateAll(l10n, l10n.localeName);

      verifyNever(occurrences.upcomingFor(any, days: anyNamed('days')));
    });

    test('schedules one notification per emitted future occurrence', () async {
      final s = schedule();
      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.upcomingFor(s, days: 5)).thenReturn([
        occurrence(date: Date.today().add(const Duration(days: 1))),
        occurrence(date: Date.today().add(const Duration(days: 2))),
        occurrence(date: Date.today().add(const Duration(days: 3))),
      ]);

      await buildScheduler().regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(3);
    });

    test('skips occurrences with status taken', () async {
      final s = schedule();
      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.upcomingFor(s, days: 5)).thenReturn([
        occurrence(
            date: Date.today().add(const Duration(days: 1)),
            status: ScheduleStatus.taken),
        occurrence(date: Date.today().add(const Duration(days: 2))),
      ]);

      await buildScheduler().regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(1);
    });

    test('skips occurrences flagged as not notifiable', () async {
      final s = schedule();
      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.upcomingFor(s, days: 5)).thenReturn([
        occurrence(
            date: Date.today().add(const Duration(days: 1)), notifiable: false),
        occurrence(date: Date.today().add(const Duration(days: 2))),
      ]);

      await buildScheduler().regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(1);
    });

    test('skips occurrences with no time-of-day (null dateTime)', () async {
      final s = schedule();
      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.upcomingFor(s, days: 5)).thenReturn([
        occurrence(date: Date.today().add(const Duration(days: 1)), time: null),
        occurrence(date: Date.today().add(const Duration(days: 2))),
      ]);

      await buildScheduler().regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(1);
    });

    test('skips occurrences whose dateTime is in the past', () async {
      final s = schedule();
      final now = DateTime.now();
      final pastTime =
          TimeOfDay.fromDateTime(now.subtract(const Duration(hours: 1)));
      final futureTime =
          TimeOfDay.fromDateTime(now.add(const Duration(hours: 1)));

      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.upcomingFor(s, days: 5)).thenReturn([
        occurrence(date: Date.today(), time: pastTime),
        occurrence(date: Date.today(), time: futureTime),
      ]);

      await buildScheduler().regenerateAll(l10n, l10n.localeName);

      verifyScheduled().called(1);
    });

    test('titles notifications with the schedule name', () async {
      final s = schedule(name: 'My Med');
      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.upcomingFor(s, days: 5)).thenReturn([occurrence()]);

      await buildScheduler().regenerateAll(l10n, l10n.localeName);

      verifyScheduled(title: l10n.notificationMedicationReminderTitle('My Med'))
          .called(1);
    });

    test('two schedules at the same time both get scheduled', () async {
      final a = schedule(id: 1, name: 'A');
      final b = schedule(id: 2, name: 'B');
      final sameOccurrence = occurrence();

      when(scheduleProvider.schedules).thenReturn([a, b]);
      when(occurrences.upcomingFor(a, days: 5)).thenReturn([sameOccurrence]);
      when(occurrences.upcomingFor(b, days: 5)).thenReturn([sameOccurrence]);

      await buildScheduler().regenerateAll(l10n, l10n.localeName);

      verifyScheduled(title: l10n.notificationMedicationReminderTitle('A'))
          .called(1);
      verifyScheduled(title: l10n.notificationMedicationReminderTitle('B'))
          .called(1);
    });
  });
}
