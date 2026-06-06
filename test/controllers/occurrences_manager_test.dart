import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/slots_builder.dart';
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
import 'occurrences_manager_test.mocks.dart';

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
  late SlotsBuilder occurrences;

  setUp(() {
    intakes = MockMedicationIntakeProvider();
    schedules = MockMedicationScheduleProvider();
    when(schedules.schedules).thenReturn([]);
    occurrences = SlotsBuilder(intakes, schedules);
  });

  void withSchedules(List<MedicationSchedule> all) {
    when(schedules.schedules).thenReturn(all);
  }

  group('current - IntervalDaysSchedule', () {
    test('returns exactly one occurrence dated today', () {
      final s = schedule(scheduling: IntervalDaysSchedule(intervalDays: 7));
      withSchedules([s]);

      final result = occurrences.intakeSlots();

      expect(result, hasLength(1));
      expect(result.single.date, Date.today());
    });

    test('scheduled today, taken today -> taken with last intake attached', () {
      final start = Date.today().subtract(const Duration(days: 14));
      final intake = intakeAt(const TimeOfDay(hour: 8, minute: 0), id: 42);
      final s = schedule(
          id: 7,
          scheduling: IntervalDaysSchedule(intervalDays: 7),
          startDate: start);
      withSchedules([s]);
      when(intakes.getLastIntakeLocalDateForSchedule(7))
          .thenReturn(Date.today());
      when(intakes.getLastTakenIntakeForSchedule(7)).thenReturn(intake);

      final occ = occurrences.intakeSlots().single;

      expect(occ.status, ScheduleStatus.taken);
      expect(occ.intake, intake);
    });
  });

  group('current - DailySchedule', () {
    const morning = TimeOfDay(hour: 8, minute: 0);
    const afternoon = TimeOfDay(hour: 14, minute: 0);
    const evening = TimeOfDay(hour: 20, minute: 30);

    test('emits one occurrence per intakeTime, all dated today', () {
      final s = schedule(
          scheduling:
              const DailySchedule(intakeTimes: [morning, afternoon, evening]));
      withSchedules([s]);
      when(intakes.getTakenIntakesForScheduleOn(1, Date.today()))
          .thenReturn(<MedicationIntake>[]);

      final result = occurrences.intakeSlots();

      expect(result.map((o) => o.time), [morning, afternoon, evening]);
      expect(result.map((o) => o.date), everyElement(Date.today()));
    });

    test('matched intake -> taken with intake attached', () {
      final morningIntake = intakeAt(morning, id: 1);
      final s = schedule(
          scheduling: const DailySchedule(intakeTimes: [morning, afternoon]));
      withSchedules([s]);
      when(intakes.getTakenIntakesForScheduleOn(1, Date.today()))
          .thenReturn([morningIntake]);

      final result = occurrences.intakeSlots();

      final morningOcc = result.singleWhere((o) => o.time == morning);
      expect(morningOcc.status, ScheduleStatus.taken);
      expect(morningOcc.intake, morningIntake);
    });

    test('intake with unknown scheduledTime is ignored', () {
      final stray = intakeAt(afternoon);
      final s = schedule(
          scheduling: const DailySchedule(intakeTimes: [morning, evening]));
      withSchedules([s]);
      when(intakes.getTakenIntakesForScheduleOn(1, Date.today()))
          .thenReturn([stray]);

      final result = occurrences.intakeSlots();

      expect(result.map((o) => o.status), everyElement(ScheduleStatus.today));
      expect(result.map((o) => o.intake), everyElement(isNull));
    });
  });

  // testNow (2026-06-01) is a Monday.
  group('current - WeeklySchedule', () {
    test('returns exactly one occurrence dated today when today is scheduled',
        () {
      withFixedClock(() {
        final s = schedule(scheduling: const WeeklySchedule(daysOfWeek: [1]));
        withSchedules([s]);

        final result = occurrences.intakeSlots();

        expect(result, hasLength(1));
        expect(result.single.date, Date.today());
      });
    });

    test(
        'returns exactly one occurrence dated today when today is not scheduled',
        () {
      withFixedClock(() {
        final s = schedule(scheduling: const WeeklySchedule(daysOfWeek: [3]));
        withSchedules([s]);

        final result = occurrences.intakeSlots();

        expect(result, hasLength(1));
        expect(result.single.date, Date.today());
      });
    });

    test('scheduled today, taken today -> taken with last intake attached', () {
      withFixedClock(() {
        final start = Date.today().subtract(const Duration(days: 14));
        final intake = intakeAt(const TimeOfDay(hour: 8, minute: 0), id: 42);
        final s = schedule(
            id: 7,
            scheduling: const WeeklySchedule(daysOfWeek: [1]),
            startDate: start);
        withSchedules([s]);
        when(intakes.getLastIntakeLocalDateForSchedule(7))
            .thenReturn(Date.today());
        when(intakes.getLastTakenIntakeForSchedule(7)).thenReturn(intake);

        final occ = occurrences.intakeSlots().single;

        expect(occ.status, ScheduleStatus.taken);
        expect(occ.intake, intake);
      });
    });

    test('not scheduled today, never taken on a past scheduled day -> overdue',
        () {
      withFixedClock(() {
        // Fri schedule. Today is Mon. Last Fri was -3 days ago, never taken.
        final start = Date.today().subtract(const Duration(days: 14));
        final s = schedule(
            id: 7,
            scheduling: const WeeklySchedule(daysOfWeek: [5]),
            startDate: start);
        withSchedules([s]);

        final occ = occurrences.intakeSlots().single;

        expect(occ.status, ScheduleStatus.overdue);
      });
    });

    test('current occurrence has no slot time set', () {
      withFixedClock(() {
        final s = schedule(
            scheduling: const WeeklySchedule(
          daysOfWeek: [1],
          notificationTimes: [TimeOfDay(hour: 9, minute: 0)],
        ));
        withSchedules([s]);

        final occ = occurrences.intakeSlots().single;

        expect(occ.time, isNull);
      });
    });
  });

  group('planNotifications - IntervalDaysSchedule', () {
    test('empty notificationTimes -> no plans', () {
      withFixedClock(() {
        final s = schedule(scheduling: IntervalDaysSchedule(intervalDays: 7));
        withSchedules([s]);

        final plans = occurrences.planNotifications(days: 30);

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

        final plans = occurrences.planNotifications(days: 3);

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
            occurrences.planNotifications(days: 1).cast<PlannedOccurrence>();

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

        final plans = occurrences.planNotifications(days: 1);

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

        final plan = occurrences
            .planNotifications(days: 1)
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

        final plans = occurrences.planNotifications(days: 30);

        expect(plans, isEmpty);
      });
    });

    test('one PlannedRepeating(daily) per intake time', () {
      withFixedClock(() {
        final s = schedule(
            scheduling: const DailySchedule(intakeTimes: [morning, afternoon]));
        withSchedules([s]);

        final plans =
            occurrences.planNotifications(days: 30).cast<PlannedRepeating>();

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

        final plan = occurrences
            .planNotifications(days: 30)
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

        final plan = occurrences
            .planNotifications(days: 30)
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

        final plan = occurrences
            .planNotifications(days: 30)
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
            occurrences.planNotifications(days: 30).cast<PlannedRepeating>();

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

        final plan = occurrences
            .planNotifications(days: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire, start.toDateTimeAt(morning));
      });
    });
  });

  group('planNotifications - WeeklySchedule', () {
    const morning = TimeOfDay(hour: 9, minute: 0); // before noon
    const afternoon = TimeOfDay(hour: 15, minute: 0); // after noon

    test('empty notificationTimes -> no plans', () {
      withFixedClock(() {
        final s = schedule(scheduling: const WeeklySchedule(daysOfWeek: [1]));
        withSchedules([s]);

        final plans = occurrences.planNotifications(days: 30);

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
            occurrences.planNotifications(days: 30).cast<PlannedRepeating>();

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

        final plan = occurrences
            .planNotifications(days: 30)
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

        final plan = occurrences
            .planNotifications(days: 30)
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

        final plan = occurrences
            .planNotifications(days: 30)
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

        final plan = occurrences
            .planNotifications(days: 30)
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

        final plan = occurrences
            .planNotifications(days: 30)
            .cast<PlannedRepeating>()
            .single;

        expect(plan.firstFire, start.toDateTimeAt(afternoon));
      });
    });
  });
}
