import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/notification_planner.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/planned_notification.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

import '../util/test_clock.dart';

@GenerateNiceMocks([
  MockSpec<MedicationIntakeProvider>(),
  MockSpec<MedicationScheduleProvider>(),
])
import 'notification_planner_test.mocks.dart';

MedicationSchedule schedule({
  int id = 1,
  required SchedulingStrategy scheduling,
  Date? startDate,
}) =>
    MedicationSchedule(
      id: id,
      name: 'Med',
      dose: Decimal.one,
      scheduling: scheduling,
      startDate: startDate ?? Date.today(),
      molecule: KnownMolecules.estradiol,
      administrationRoute: AdministrationRoute.oral,
    );

MedicationIntake intakeAt(TimeOfDay time, {int id = 0, int scheduleId = 1}) =>
    MedicationIntake(
      id: id,
      dose: Decimal.one,
      takenDateTime: DateTime.utc(2025, 1, 1, time.hour, time.minute),
      takenTimeZone: 'Etc/UTC',
      scheduleId: scheduleId,
      molecule: KnownMolecules.estradiol,
      administrationRoute: AdministrationRoute.oral,
      scheduledTime: time,
    );

void main() {
  late MockMedicationIntakeProvider intakes;
  late MockMedicationScheduleProvider schedules;
  late NotificationPlanner planner;

  setUp(() {
    intakes = MockMedicationIntakeProvider();
    schedules = MockMedicationScheduleProvider();
    when(schedules.schedules).thenReturn([]);
    planner = NotificationPlanner(intakes, schedules);
  });

  void withSchedules(List<MedicationSchedule> all) {
    when(schedules.schedules).thenReturn(all);
  }

  group('planNotifications - IntervalDaysSchedule', () {
    test('empty notificationTimes -> no plans', () {
      withFixedClock(() {
        final s = schedule(scheduling: IntervalDaysSchedule(intervalDays: 7));
        withSchedules([s]);

        final plans = planner.planNotifications(daysAhead: 30);

        expect(plans, isEmpty);
      });
    });

    test('emits one PlannedOccurrence per (scheduled date, notificationTime)',
        () {
      withFixedClock(() {
        final start = Date.today().subtract(const Duration(days: 7));
        final s = schedule(
            scheduling:
                IntervalDaysSchedule(intervalDays: 7, notificationTimes: const [
              TimeOfDay(hour: 9, minute: 0),
              TimeOfDay(hour: 21, minute: 0),
            ]),
            startDate: start);
        withSchedules([s]);
        // No taken intake -> today's slots not filtered as 'taken'.
        when(intakes.getLastIntakeLocalDateForSchedule(any)).thenReturn(null);

        final plans = planner.planNotifications(daysAhead: 3);

        // 3 dates x 2 times = 6, but today's 09:00 is before noon -> filtered.
        // So 5 plans (today 21:00, +7d 09:00 / 21:00, +14d 09:00 / 21:00).
        expect(plans, hasLength(5));
        expect(plans.every((p) => p is PlannedOccurrence), isTrue);
      });
    });

    test('filters dateTime <= after', () {
      withFixedClock(() {
        final start = Date.today();
        final s = schedule(
            scheduling:
                IntervalDaysSchedule(intervalDays: 7, notificationTimes: const [
              TimeOfDay(hour: 9, minute: 0), // 09:00 < noon -> filtered
              TimeOfDay(hour: 15, minute: 0), // 15:00 > noon -> kept
            ]),
            startDate: start);
        withSchedules([s]);

        final plans =
            planner.planNotifications(daysAhead: 1).cast<PlannedOccurrence>();

        expect(plans, hasLength(1));
        expect(plans.single.dateTime.hour, 15);
      });
    });

    test('skips today when status is taken', () {
      withFixedClock(() {
        final start = Date.today().subtract(const Duration(days: 7));
        final s = schedule(
            id: 7,
            scheduling: IntervalDaysSchedule(
                intervalDays: 7,
                notificationTimes: const [TimeOfDay(hour: 15, minute: 0)]),
            startDate: start);
        withSchedules([s]);
        when(intakes.getLastIntakeLocalDateForSchedule(7))
            .thenReturn(Date.today());

        final plans = planner.planNotifications(daysAhead: 1);

        // Today is scheduled and taken -> skipped entirely.
        expect(plans, isEmpty);
      });
    });

    test('dateTime equals date.toDateTimeAt(time)', () {
      withFixedClock(() {
        const time = TimeOfDay(hour: 15, minute: 30);
        final s = schedule(
            scheduling: IntervalDaysSchedule(
                intervalDays: 1, notificationTimes: const [time]));
        withSchedules([s]);

        final plan = planner
            .planNotifications(daysAhead: 1)
            .cast<PlannedOccurrence>()
            .single;

        expect(plan.dateTime, Date.today().toDateTimeAt(time));
      });
    });
  });

  group('planNotifications - DailySchedule', () {
    const morning = TimeOfDay(hour: 9, minute: 0); // before noon
    const afternoon = TimeOfDay(hour: 15, minute: 0); // after noon

    test('notify=false -> no plans', () {
      withFixedClock(() {
        final s = schedule(
            scheduling:
                const DailySchedule(intakeTimes: [afternoon], notify: false));
        withSchedules([s]);

        final plans = planner.planNotifications(daysAhead: 30);

        expect(plans, isEmpty);
      });
    });

    test('one PlannedRepeating(daily) per intake time', () {
      withFixedClock(() {
        final s = schedule(
            scheduling: const DailySchedule(intakeTimes: [morning, afternoon]));
        withSchedules([s]);

        final plans =
            planner.planNotifications(daysAhead: 30).cast<PlannedRepeating>();

        expect(plans, hasLength(2));
        expect(
            plans.map((p) => p.periodicity), everyElement(Periodicity.daily));
        expect(plans.map((p) => p.dayOfWeek), everyElement(isNull));
        expect(plans.map((p) => p.time).toSet(), {morning, afternoon});
      });
    });

    test('firstFire = today @ time when time is in the future and not taken',
        () {
      withFixedClock(() {
        final s =
            schedule(scheduling: const DailySchedule(intakeTimes: [afternoon]));
        withSchedules([s]);

        final plan = planner
            .planNotifications(daysAhead: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire, Date.today().toDateTimeAt(afternoon));
      });
    });

    test('firstFire bumps by 1 day when today @ time is already past', () {
      withFixedClock(() {
        final s =
            schedule(scheduling: const DailySchedule(intakeTimes: [morning]));
        withSchedules([s]);

        final plan = planner
            .planNotifications(daysAhead: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire,
            Date.today().add(const Duration(days: 1)).toDateTimeAt(morning));
      });
    });

    test('firstFire bumps by 1 day when this slot is already taken today', () {
      withFixedClock(() {
        final s = schedule(
            id: 7, scheduling: const DailySchedule(intakeTimes: [afternoon]));
        withSchedules([s]);
        when(intakes.getTakenIntakesForScheduleOn(7, Date.today()))
            .thenReturn([intakeAt(afternoon)]);

        final plan = planner
            .planNotifications(daysAhead: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire,
            Date.today().add(const Duration(days: 1)).toDateTimeAt(afternoon));
      });
    });

    test('taken intake for a different slot does not advance this slot', () {
      withFixedClock(() {
        final s = schedule(
            id: 7,
            scheduling: const DailySchedule(intakeTimes: [morning, afternoon]));
        withSchedules([s]);
        // Morning already taken; afternoon untouched.
        when(intakes.getTakenIntakesForScheduleOn(7, Date.today()))
            .thenReturn([intakeAt(morning)]);

        final plans =
            planner.planNotifications(daysAhead: 30).cast<PlannedRepeating>();

        final afternoonPlan = plans.singleWhere((p) => p.time == afternoon);
        // Afternoon is in the future and not taken -> today.
        expect(afternoonPlan.firstFire, Date.today().toDateTimeAt(afternoon));
      });
    });

    test('firstFire = startDate @ time when startDate is in the future', () {
      withFixedClock(() {
        final start = Date.today().add(const Duration(days: 5));
        final s = schedule(
            scheduling: const DailySchedule(intakeTimes: [morning]),
            startDate: start);
        withSchedules([s]);

        final plan = planner
            .planNotifications(daysAhead: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire, start.toDateTimeAt(morning));
      });
    });
  });

  group('daysAhead', () {
    const t1 = TimeOfDay(hour: 9, minute: 0);
    const t2 = TimeOfDay(hour: 21, minute: 0);

    test('returns 0 when there are no schedules', () {
      expect(planner.daysAhead(maxScheduled: 64), 0);
    });

    test('returns 0 when interval schedules have no notification times', () {
      withSchedules([
        schedule(scheduling: IntervalDaysSchedule(intervalDays: 7)),
      ]);

      expect(planner.daysAhead(maxScheduled: 64), 0);
    });

    test('returns 0 when only daily/weekly schedules exist (no interval)', () {
      withSchedules([
        schedule(scheduling: const DailySchedule(intakeTimes: [t1])),
        schedule(
            scheduling: const WeeklySchedule(
                daysOfWeek: [1, 3], notificationTimes: [t1])),
      ]);

      expect(planner.daysAhead(maxScheduled: 64), 0);
    });

    test('single interval schedule with one time gets the full budget', () {
      withSchedules([
        schedule(
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1])),
      ]);

      expect(planner.daysAhead(maxScheduled: 64), 64);
    });

    test('single interval schedule with two times halves the budget', () {
      withSchedules([
        schedule(
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1, t2])),
      ]);

      expect(planner.daysAhead(maxScheduled: 64), 32);
    });

    test('budget is shared across all interval schedules', () {
      withSchedules([
        schedule(
            id: 1,
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1])),
        schedule(
            id: 2,
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1, t2])),
      ]);

      // perOccurrence = 1 + 2 = 3 -> 64 ~/ 3 = 21
      expect(planner.daysAhead(maxScheduled: 64), 21);
    });

    test('daily schedules with notify reserve one slot per intake time', () {
      withSchedules([
        schedule(
            id: 1,
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1])),
        schedule(id: 2, scheduling: const DailySchedule(intakeTimes: [t1, t2])),
      ]);

      // remaining = 64 - 2 = 62, perOccurrence = 1 -> 62
      expect(planner.daysAhead(maxScheduled: 64), 62);
    });

    test('daily schedules with notify=false reserve nothing', () {
      withSchedules([
        schedule(
            id: 1,
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1])),
        schedule(
            id: 2,
            scheduling:
                const DailySchedule(intakeTimes: [t1, t2], notify: false)),
      ]);

      expect(planner.daysAhead(maxScheduled: 64), 64);
    });

    test('weekly schedules reserve daysOfWeek x notificationTimes slots', () {
      withSchedules([
        schedule(
            id: 1,
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1])),
        schedule(
            id: 2,
            scheduling: const WeeklySchedule(
                daysOfWeek: [1, 3, 5], notificationTimes: [t1, t2])),
      ]);

      // reserved = 3 * 2 = 6, remaining = 58, perOccurrence = 1 -> 58
      expect(planner.daysAhead(maxScheduled: 64), 58);
    });

    test(
        'returns 1 when daily/weekly reservations exhaust the budget but interval schedules exist',
        () {
      withSchedules([
        schedule(
            id: 1,
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1])),
        schedule(
            id: 2,
            scheduling: const WeeklySchedule(
                daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
                notificationTimes: [t1, t2])),
      ]);

      // reserved = 7 * 2 = 14, remaining = 0 -> floors to 0 but clamped to 1.
      expect(planner.daysAhead(maxScheduled: 14), 1);
      // Also true when reservations overshoot maxScheduled.
      expect(planner.daysAhead(maxScheduled: 10), 1);
    });

    test('returns 1 when remaining budget is smaller than perOccurrence', () {
      withSchedules([
        schedule(
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1, t2, t1])),
      ]);

      // perOccurrence = 3, 2 ~/ 3 = 0 -> clamped to 1.
      expect(planner.daysAhead(maxScheduled: 2), 1);
    });

    test('floors instead of rounding when budget is not a clean multiple', () {
      withSchedules([
        schedule(
            scheduling: IntervalDaysSchedule(
                intervalDays: 7, notificationTimes: const [t1, t2])),
      ]);

      // 65 ~/ 2 = 32, not 33.
      expect(planner.daysAhead(maxScheduled: 65), 32);
    });
  });

  group('planNotifications - WeeklySchedule', () {
    const morning = TimeOfDay(hour: 9, minute: 0); // before noon
    const afternoon = TimeOfDay(hour: 15, minute: 0); // after noon

    test('empty notificationTimes -> no plans', () {
      withFixedClock(() {
        final s = schedule(scheduling: const WeeklySchedule(daysOfWeek: [1]));
        withSchedules([s]);

        final plans = planner.planNotifications(daysAhead: 30);

        expect(plans, isEmpty);
      });
    });

    test('emits daysOfWeek x notificationTimes cross product', () {
      withFixedClock(() {
        final s = schedule(
            scheduling: const WeeklySchedule(
                daysOfWeek: [1, 3, 5], notificationTimes: [afternoon]));
        withSchedules([s]);

        final plans =
            planner.planNotifications(daysAhead: 30).cast<PlannedRepeating>();

        expect(plans, hasLength(3));
        expect(plans.map((p) => p.dayOfWeek).toSet(), {1, 3, 5});
        expect(
            plans.map((p) => p.periodicity), everyElement(Periodicity.weekly));
      });
    });

    test('firstFire on today when today matches and time is in the future', () {
      withFixedClock(() {
        // testNow Mon. daysOfWeek=[Mon=1], afternoon=15:00.
        final s = schedule(
            scheduling: const WeeklySchedule(
                daysOfWeek: [1], notificationTimes: [afternoon]));
        withSchedules([s]);

        final plan = planner
            .planNotifications(daysAhead: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire, Date.today().toDateTimeAt(afternoon));
      });
    });

    test('firstFire bumps by 7 days when today matches but time is past', () {
      withFixedClock(() {
        // testNow Mon noon. daysOfWeek=[Mon], morning=09:00 (past).
        final s = schedule(
            scheduling: const WeeklySchedule(
                daysOfWeek: [1], notificationTimes: [morning]));
        withSchedules([s]);

        final plan = planner
            .planNotifications(daysAhead: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire,
            Date.today().add(const Duration(days: 7)).toDateTimeAt(morning));
      });
    });

    test(
        'firstFire bumps by 7 days when any taken intake exists today (date-level skip)',
        () {
      withFixedClock(() {
        final s = schedule(
            id: 7,
            scheduling: const WeeklySchedule(
                daysOfWeek: [1], notificationTimes: [afternoon]));
        withSchedules([s]);
        when(intakes.getTakenIntakesForScheduleOn(7, Date.today()))
            .thenReturn([intakeAt(const TimeOfDay(hour: 8, minute: 0))]);

        final plan = planner
            .planNotifications(daysAhead: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire,
            Date.today().add(const Duration(days: 7)).toDateTimeAt(afternoon));
      });
    });

    test(
        'firstFire walks to the next matching weekday when today does not match',
        () {
      withFixedClock(() {
        // testNow Mon. daysOfWeek=[Wed=3], afternoon=15:00.
        final s = schedule(
            scheduling: const WeeklySchedule(
                daysOfWeek: [3], notificationTimes: [afternoon]));
        withSchedules([s]);

        final plan = planner
            .planNotifications(daysAhead: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire,
            Date.today().add(const Duration(days: 2)).toDateTimeAt(afternoon));
      });
    });

    test('firstFire from startDate when startDate is in the future', () {
      withFixedClock(() {
        // testNow Mon. startDate next Wed. daysOfWeek=[Wed=3], afternoon.
        final start = Date.today().add(const Duration(days: 2));
        final s = schedule(
            scheduling: const WeeklySchedule(
                daysOfWeek: [3], notificationTimes: [afternoon]),
            startDate: start);
        withSchedules([s]);

        final plan = planner
            .planNotifications(daysAhead: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire, start.toDateTimeAt(afternoon));
      });
    });
  });
}
