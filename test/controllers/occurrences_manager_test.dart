import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/occurrences_manager.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

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
  late OccurrencesManager occurrences;

  setUp(() {
    intakes = MockMedicationIntakeProvider();
    schedules = MockMedicationScheduleProvider();
    when(schedules.schedules).thenReturn([]);
    occurrences = OccurrencesManager(intakes, schedules);
  });

  void withSchedules(List<MedicationSchedule> all) {
    when(schedules.schedules).thenReturn(all);
  }

  group('current - IntervalDaysSchedule', () {
    test('returns exactly one occurrence dated today', () {
      final s = schedule(scheduling: IntervalDaysSchedule(intervalDays: 7));
      withSchedules([s]);

      final result = occurrences.current();

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

      final occ = occurrences.current().single;

      expect(occ.status, ScheduleStatus.taken);
      expect(occ.intake, intake);
    });

    test('notifiable mirrors notificationTime presence', () {
      final withTime = schedule(
        id: 1,
        scheduling: IntervalDaysSchedule(
          intervalDays: 7,
          notificationTimes: [const TimeOfDay(hour: 9, minute: 0)],
        ),
      );
      final withoutTime =
          schedule(id: 2, scheduling: IntervalDaysSchedule(intervalDays: 7));
      withSchedules([withTime, withoutTime]);

      final result = occurrences.current();
      expect(
        result.singleWhere((it) => it.schedule.id == withTime.id).notifiable,
        isTrue,
      );
      expect(
        result.singleWhere((it) => it.schedule.id == withoutTime.id).notifiable,
        isFalse,
      );
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

      final result = occurrences.current();

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

      final result = occurrences.current();

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

      final result = occurrences.current();

      expect(result.map((o) => o.status), everyElement(ScheduleStatus.today));
      expect(result.map((o) => o.intake), everyElement(isNull));
    });

    test('notifiable mirrors notify flag', () {
      final loud = schedule(
          id: 1, scheduling: const DailySchedule(intakeTimes: [morning]));
      final silent = schedule(
          id: 2,
          scheduling:
              const DailySchedule(intakeTimes: [morning], notify: false));
      withSchedules([loud, silent]);
      when(intakes.getTakenIntakesForScheduleOn(any, any)).thenReturn([]);

      final result = occurrences.current();
      expect(
        result.singleWhere((it) => it.schedule.id == loud.id).notifiable,
        isTrue,
      );
      expect(
        result.singleWhere((it) => it.schedule.id == silent.id).notifiable,
        isFalse,
      );
    });
  });

  group('upcoming - IntervalDaysSchedule', () {
    test('returns `days` future scheduled dates', () {
      final start = Date.today().subtract(const Duration(days: 7));
      final s = schedule(
          scheduling: IntervalDaysSchedule(
              intervalDays: 7,
              notificationTimes: [const TimeOfDay(hour: 9, minute: 0)]),
          startDate: start);
      withSchedules([s]);

      final result = occurrences.upcoming(days: 3);

      expect(result, hasLength(3));
    });

    test('today-slot status reflects current state', () {
      final start = Date.today().subtract(const Duration(days: 7));
      final s = schedule(
          id: 7,
          scheduling: IntervalDaysSchedule(
              intervalDays: 7,
              notificationTimes: [const TimeOfDay(hour: 9, minute: 0)]),
          startDate: start);
      withSchedules([s]);
      when(intakes.getLastIntakeLocalDateForSchedule(7))
          .thenReturn(Date.today());

      final result = occurrences.upcoming(days: 2);

      expect(result.first.status, ScheduleStatus.taken);
    });

    test('notificationTime mirrors scheduling notificationTime', () {
      const t = TimeOfDay(hour: 9, minute: 30);
      final s = schedule(
          scheduling:
              IntervalDaysSchedule(intervalDays: 1, notificationTimes: [t]));
      withSchedules([s]);

      final result = occurrences.upcoming(days: 3);

      expect(result.map((o) => o.notificationTime), everyElement(t));
    });

    test('notifiable mirrors notificationTime presence', () {
      final withoutTime =
          schedule(scheduling: IntervalDaysSchedule(intervalDays: 1));
      withSchedules([withoutTime]);

      final result = occurrences.upcoming(days: 2);

      expect(result.map((o) => o.notifiable), everyElement(isFalse));
    });
  });

  group('upcoming - DailySchedule', () {
    const morning = TimeOfDay(hour: 8, minute: 0);
    const evening = TimeOfDay(hour: 20, minute: 30);

    test('emits `days * intakeTimes` occurrences', () {
      final s = schedule(
          scheduling: const DailySchedule(intakeTimes: [morning, evening]));
      withSchedules([s]);
      when(intakes.getTakenIntakesForScheduleOn(1, Date.today()))
          .thenReturn(<MedicationIntake>[]);

      final result = occurrences.upcoming(days: 3);

      expect(result, hasLength(6));
    });

    test('today slot status reflects current state', () {
      final morningIntake = intakeAt(morning, id: 1);
      final s = schedule(
          scheduling: const DailySchedule(intakeTimes: [morning, evening]));
      withSchedules([s]);
      when(intakes.getTakenIntakesForScheduleOn(1, Date.today()))
          .thenReturn([morningIntake]);

      final result = occurrences.upcoming(days: 1);

      expect(result.first.status, ScheduleStatus.taken);
      expect(result.first.intake, morningIntake);
      expect(result[1].status, ScheduleStatus.today);
    });

    test('notifiable mirrors notify flag for every occurrence', () {
      final silent = schedule(
          scheduling:
              const DailySchedule(intakeTimes: [morning], notify: false));
      withSchedules([silent]);
      when(intakes.getTakenIntakesForScheduleOn(any, any)).thenReturn([]);

      final result = occurrences.upcoming(days: 3);

      expect(result.map((o) => o.notifiable), everyElement(isFalse));
    });
  });
}
