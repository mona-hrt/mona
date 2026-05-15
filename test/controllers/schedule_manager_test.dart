import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/schedule_manager.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
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
        intervalDays: 2,
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(1))
          .thenReturn(today.subtract(const Duration(days: 2)));

      todayTakenSchedule = MedicationSchedule(
        id: 5,
        name: 'TodayTakenMed',
        dose: Decimal.one,
        intervalDays: 2,
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(5))
          .thenReturn(today);

      todayOverdueSchedule = MedicationSchedule(
        id: 4,
        name: 'TodayLateMed',
        dose: Decimal.one,
        intervalDays: 2,
        startDate: today.subtract(const Duration(days: 4)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(4))
          .thenReturn(today.subtract(const Duration(days: 3)));

      todayEarlySchedule = MedicationSchedule(
        id: 6,
        name: 'TodayEarlyMed',
        dose: Decimal.one,
        intervalDays: 7,
        startDate: today.subtract(const Duration(days: 14)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(6))
          .thenReturn(today.subtract(const Duration(days: 5)));

      overdueSchedule = MedicationSchedule(
        id: 2,
        name: 'OverdueMed',
        dose: Decimal.one,
        intervalDays: 2,
        startDate: today.subtract(const Duration(days: 9)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(2))
          .thenReturn(today.subtract(const Duration(days: 4)));

      upcomingSchedule = MedicationSchedule(
        id: 3,
        name: 'UpcomingMed',
        dose: Decimal.one,
        intervalDays: 2,
        startDate: today.add(const Duration(days: 10)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
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
        intervalDays: 2,
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(1))
          .thenReturn(today.subtract(const Duration(days: 2)));

      takenSchedule = MedicationSchedule(
        id: 2,
        name: 'TakenMed',
        dose: Decimal.one,
        intervalDays: 2,
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(2))
          .thenReturn(today);

      overdueSchedule = MedicationSchedule(
        id: 3,
        name: 'OverdueMed',
        dose: Decimal.one,
        intervalDays: 2,
        startDate: today.subtract(const Duration(days: 9)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(3))
          .thenReturn(today.subtract(const Duration(days: 4)));

      upcomingSchedule = MedicationSchedule(
        id: 4,
        name: 'UpcomingMed',
        dose: Decimal.one,
        intervalDays: 2,
        startDate: today.add(const Duration(days: 10)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
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
}
