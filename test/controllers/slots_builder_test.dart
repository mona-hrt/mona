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
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

import '../util/test_clock.dart';

@GenerateNiceMocks([
  MockSpec<MedicationIntakeProvider>(),
  MockSpec<MedicationScheduleProvider>(),
])
import 'slots_builder_test.mocks.dart';

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
  late SlotsBuilder slotsBuilder;

  setUp(() {
    intakes = MockMedicationIntakeProvider();
    schedules = MockMedicationScheduleProvider();
    when(schedules.schedules).thenReturn([]);
    slotsBuilder = SlotsBuilder(intakes, schedules);
  });

  void withSchedules(List<MedicationSchedule> all) {
    when(schedules.schedules).thenReturn(all);
  }

  group('intakeSlots - IntervalDaysSchedule', () {
    test('returns exactly one slot dated today', () {
      final s = schedule(scheduling: IntervalDaysSchedule(intervalDays: 7));
      withSchedules([s]);

      final result = slotsBuilder.intakeSlots();

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

      final slot = slotsBuilder.intakeSlots().single;

      expect(slot.status, ScheduleStatus.taken);
      expect(slot.intake, intake);
    });
  });

  group('intakeSlots - DailySchedule', () {
    const morning = TimeOfDay(hour: 8, minute: 0);
    const afternoon = TimeOfDay(hour: 14, minute: 0);
    const evening = TimeOfDay(hour: 20, minute: 30);

    test('emits one slot per intakeTime, all dated today', () {
      final s = schedule(
          scheduling:
              const DailySchedule(intakeTimes: [morning, afternoon, evening]));
      withSchedules([s]);
      when(intakes.getTakenIntakesForScheduleOn(1, Date.today()))
          .thenReturn(<MedicationIntake>[]);

      final result = slotsBuilder.intakeSlots();

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

      final result = slotsBuilder.intakeSlots();

      final morningSlot = result.singleWhere((o) => o.time == morning);
      expect(morningSlot.status, ScheduleStatus.taken);
      expect(morningSlot.intake, morningIntake);
    });

    test('intake with unknown scheduledTime is ignored', () {
      final stray = intakeAt(afternoon);
      final s = schedule(
          scheduling: const DailySchedule(intakeTimes: [morning, evening]));
      withSchedules([s]);
      when(intakes.getTakenIntakesForScheduleOn(1, Date.today()))
          .thenReturn([stray]);

      final result = slotsBuilder.intakeSlots();

      expect(result.map((o) => o.status), everyElement(ScheduleStatus.today));
      expect(result.map((o) => o.intake), everyElement(isNull));
    });
  });

  // testNow (2026-06-01) is a Monday.
  group('intakeSlots - WeeklySchedule', () {
    test('returns exactly one slot dated today when today is scheduled', () {
      withFixedClock(() {
        final s = schedule(scheduling: const WeeklySchedule(daysOfWeek: [1]));
        withSchedules([s]);

        final result = slotsBuilder.intakeSlots();

        expect(result, hasLength(1));
        expect(result.single.date, Date.today());
      });
    });

    test('returns exactly one slot dated today when today is not scheduled',
        () {
      withFixedClock(() {
        final s = schedule(scheduling: const WeeklySchedule(daysOfWeek: [3]));
        withSchedules([s]);

        final result = slotsBuilder.intakeSlots();

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

        final slot = slotsBuilder.intakeSlots().single;

        expect(slot.status, ScheduleStatus.taken);
        expect(slot.intake, intake);
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

        final slot = slotsBuilder.intakeSlots().single;

        expect(slot.status, ScheduleStatus.overdue);
      });
    });

    test('current slot has no time set', () {
      withFixedClock(() {
        final s = schedule(
            scheduling: const WeeklySchedule(
          daysOfWeek: [1],
          notificationTimes: [TimeOfDay(hour: 9, minute: 0)],
        ));
        withSchedules([s]);

        final slot = slotsBuilder.intakeSlots().single;

        expect(slot.time, isNull);
      });
    });
  });
}
