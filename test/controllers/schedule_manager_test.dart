import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/schedule_manager.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

@GenerateNiceMocks([
  MockSpec<MedicationScheduleProvider>(),
  MockSpec<MedicationIntakeProvider>(),
])
import 'schedule_manager_test.mocks.dart';

void main() {
  late MockMedicationScheduleProvider mockScheduleProvider;
  late MockMedicationIntakeProvider mockIntakeProvider;
  late ScheduleManager manager;

  setUp(() {
    mockScheduleProvider = MockMedicationScheduleProvider();
    mockIntakeProvider = MockMedicationIntakeProvider();

    manager = ScheduleManager(
      mockScheduleProvider,
      mockIntakeProvider,
    );
  });

  group('ScheduleManager - getSlots', () {
    late MedicationSchedule todaySchedule;
    late MedicationSchedule todayTakenSchedule;
    late MedicationSchedule todayOverdueSchedule;
    late MedicationSchedule todayEarlySchedule;
    late MedicationSchedule overdueSchedule;
    late MedicationSchedule upcomingSchedule;

    setUp(() {
      final today = Date.today();

      todaySchedule = MedicationSchedule(
        id: 1,
        name: 'TodayMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(1))
          .thenReturn(today.subtract(const Duration(days: 2)));

      todayTakenSchedule = MedicationSchedule(
        id: 5,
        name: 'TodayTakenMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(5))
          .thenReturn(today);

      todayOverdueSchedule = MedicationSchedule(
        id: 4,
        name: 'TodayLateMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: today.subtract(const Duration(days: 4)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(4))
          .thenReturn(today.subtract(const Duration(days: 3)));

      todayEarlySchedule = MedicationSchedule(
        id: 6,
        name: 'TodayEarlyMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 7),
        startDate: today.subtract(const Duration(days: 14)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(6))
          .thenReturn(today.subtract(const Duration(days: 5)));

      overdueSchedule = MedicationSchedule(
        id: 2,
        name: 'OverdueMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: today.subtract(const Duration(days: 9)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(2))
          .thenReturn(today.subtract(const Duration(days: 4)));

      upcomingSchedule = MedicationSchedule(
        id: 3,
        name: 'UpcomingMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: today.add(const Duration(days: 10)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(3))
          .thenReturn(null);
    });

    test('returns empty list when there are no schedules', () {
      when(mockScheduleProvider.schedules).thenReturn([]);

      expect(manager.getSlots(), isEmpty);
    });

    test('schedule due today, not late, not taken yields today', () {
      when(mockScheduleProvider.schedules).thenReturn([todaySchedule]);

      final slot = manager.getSlots().single;

      expect(slot.schedule, todaySchedule);
      expect(slot.status, ScheduleStatus.today);
    });

    test('schedule taken today or later yields taken', () {
      when(mockScheduleProvider.schedules).thenReturn([todayTakenSchedule]);

      final slot = manager.getSlots().single;

      expect(slot.schedule, todayTakenSchedule);
      expect(slot.status, ScheduleStatus.taken);
    });

    test('taken interval slot carries the latest taken intake', () {
      final intake = MedicationIntake(
        id: 999,
        dose: Decimal.one,
        takenDateTime: DateTime.utc(2025, 9, 14, 12),
        takenTimeZone: 'Etc/UTC',
        scheduleId: 5,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockScheduleProvider.schedules).thenReturn([todayTakenSchedule]);
      when(mockIntakeProvider.getLastTakenIntakeForSchedule(5))
          .thenReturn(intake);

      final slot = manager.getSlots().single;

      expect(slot.intake, intake);
    });

    test('non-taken interval slot has no intake attached', () {
      when(mockScheduleProvider.schedules).thenReturn([todaySchedule]);

      final slot = manager.getSlots().single;

      expect(slot.status, ScheduleStatus.today);
      expect(slot.intake, isNull);
    });

    test('schedule due today and late yields todayOverdue', () {
      when(mockScheduleProvider.schedules).thenReturn([todayOverdueSchedule]);

      final slot = manager.getSlots().single;

      expect(slot.schedule, todayOverdueSchedule);
      expect(slot.status, ScheduleStatus.todayOverdue);
    });

    test(
        'schedule due today, last taken after previous scheduled date but not today, '
        'yields todayEarly', () {
      when(mockScheduleProvider.schedules).thenReturn([todayEarlySchedule]);

      final slot = manager.getSlots().single;

      expect(slot.schedule, todayEarlySchedule);
      expect(slot.status, ScheduleStatus.todayEarly);
    });

    test('schedule not due today but late yields overdue', () {
      when(mockScheduleProvider.schedules).thenReturn([overdueSchedule]);

      final slot = manager.getSlots().single;

      expect(slot.schedule, overdueSchedule);
      expect(slot.status, ScheduleStatus.overdue);
    });

    test('schedule not due today and not late yields upcoming', () {
      when(mockScheduleProvider.schedules).thenReturn([upcomingSchedule]);

      final slot = manager.getSlots().single;

      expect(slot.schedule, upcomingSchedule);
      expect(slot.status, ScheduleStatus.upcoming);
    });
  });

  group('ScheduleManager - splitSlotsByDay', () {
    late MedicationSchedule todaySchedule;
    late MedicationSchedule takenSchedule;
    late MedicationSchedule overdueSchedule;
    late MedicationSchedule upcomingSchedule;

    setUp(() {
      final today = Date.today();

      todaySchedule = MedicationSchedule(
        id: 1,
        name: 'TodayMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(1))
          .thenReturn(today.subtract(const Duration(days: 2)));

      takenSchedule = MedicationSchedule(
        id: 2,
        name: 'TakenMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(2))
          .thenReturn(today);

      overdueSchedule = MedicationSchedule(
        id: 3,
        name: 'OverdueMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: today.subtract(const Duration(days: 9)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(3))
          .thenReturn(today.subtract(const Duration(days: 4)));

      upcomingSchedule = MedicationSchedule(
        id: 4,
        name: 'UpcomingMed',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: today.add(const Duration(days: 10)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(4))
          .thenReturn(null);
    });

    test('returns two empty lists when there are no schedules', () {
      when(mockScheduleProvider.schedules).thenReturn([]);

      final split = manager.splitSlotsByDay();

      expect(split.today, isEmpty);
      expect(split.upcoming, isEmpty);
    });

    test('groups today, taken and overdue slots under today, overdue first',
        () {
      when(mockScheduleProvider.schedules)
          .thenReturn([todaySchedule, takenSchedule, overdueSchedule]);

      final split = manager.splitSlotsByDay();

      expect(
        split.today.map((slot) => slot.schedule),
        [overdueSchedule, todaySchedule, takenSchedule],
      );
      expect(split.upcoming, isEmpty);
    });

    test('puts upcoming slots under upcoming', () {
      when(mockScheduleProvider.schedules)
          .thenReturn([todaySchedule, upcomingSchedule]);

      final split = manager.splitSlotsByDay();

      expect(split.today.map((slot) => slot.schedule), [todaySchedule]);
      expect(split.upcoming.map((slot) => slot.schedule), [upcomingSchedule]);
    });
  });

  group('ScheduleManager - DailySchedule', () {
    const morning = TimeOfDay(hour: 8, minute: 0);
    const afternoon = TimeOfDay(hour: 14, minute: 0);
    const evening = TimeOfDay(hour: 20, minute: 30);

    late MedicationSchedule dailySchedule;

    MedicationIntake intakeAt(TimeOfDay time, {int id = 0}) {
      return MedicationIntake(
        id: id,
        dose: Decimal.one,
        takenDateTime: DateTime.utc(2025, 9, 14, time.hour, time.minute),
        takenTimeZone: 'Etc/UTC',
        scheduleId: 100,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        scheduledTime: time,
      );
    }

    setUp(() {
      dailySchedule = MedicationSchedule(
        id: 100,
        name: 'DailyMed',
        dose: Decimal.one,
        scheduling: const DailySchedule(
          intakeTimes: [morning, afternoon, evening],
          notify: false,
        ),
        startDate: Date.today(),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
    });

    test('emits one slot per intakeTime, all today when none taken', () {
      when(mockScheduleProvider.schedules).thenReturn([dailySchedule]);
      when(mockIntakeProvider.getTakenIntakesForScheduleOn(100, Date.today()))
          .thenReturn(<MedicationIntake>[]);

      final slots = manager.getSlots();

      expect(slots, hasLength(3));
      expect(slots.map((s) => s.time), [morning, afternoon, evening]);
      expect(
        slots.map((s) => s.status),
        everyElement(ScheduleStatus.today),
      );
      expect(slots.map((s) => s.schedule), everyElement(dailySchedule));
      expect(slots.map((s) => s.intake), everyElement(isNull));
    });

    test('marks slot as taken and attaches the matching intake', () {
      final morningIntake = intakeAt(morning, id: 1);
      final eveningIntake = intakeAt(evening, id: 2);
      when(mockScheduleProvider.schedules).thenReturn([dailySchedule]);
      when(mockIntakeProvider.getTakenIntakesForScheduleOn(100, Date.today()))
          .thenReturn([morningIntake, eveningIntake]);

      final slots = manager.getSlots();

      expect(
        {for (final s in slots) s.time: s.status},
        {
          morning: ScheduleStatus.taken,
          afternoon: ScheduleStatus.today,
          evening: ScheduleStatus.taken,
        },
      );
      expect(
        {for (final s in slots) s.time: s.intake},
        {
          morning: morningIntake,
          afternoon: null,
          evening: eveningIntake,
        },
      );
    });

    test(
        'splitSlotsByDay puts every daily slot under today, sorted by intake time',
        () {
      final unsorted = MedicationSchedule(
        id: 101,
        name: 'UnsortedDaily',
        dose: Decimal.one,
        scheduling: const DailySchedule(
          intakeTimes: [evening, morning, afternoon],
          notify: false,
        ),
        startDate: Date.today(),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockScheduleProvider.schedules).thenReturn([unsorted]);
      when(mockIntakeProvider.getTakenIntakesForScheduleOn(101, Date.today()))
          .thenReturn(<MedicationIntake>[]);

      final split = manager.splitSlotsByDay();

      expect(split.upcoming, isEmpty);
      expect(
        split.today.map((s) => s.time),
        [morning, afternoon, evening],
      );
    });

    test(
        'splitSlotsByDay keeps overdue interval slots above daily slots in today',
        () {
      final overdueInterval = MedicationSchedule(
        id: 200,
        name: 'OverdueInterval',
        dose: Decimal.one,
        scheduling: IntervalDaysSchedule(intervalDays: 2),
        startDate: Date.today().subtract(const Duration(days: 9)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(200))
          .thenReturn(Date.today().subtract(const Duration(days: 4)));
      when(mockIntakeProvider.getTakenIntakesForScheduleOn(100, Date.today()))
          .thenReturn(<MedicationIntake>[]);
      when(mockScheduleProvider.schedules)
          .thenReturn([dailySchedule, overdueInterval]);

      final split = manager.splitSlotsByDay();

      expect(split.upcoming, isEmpty);
      expect(split.today.first.schedule, overdueInterval);
      expect(
        split.today.skip(1).map((s) => s.time),
        [morning, afternoon, evening],
      );
    });
  });
}
