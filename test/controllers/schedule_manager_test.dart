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

  group('ScheduleManager - getSchedulesByStatus', () {
    late MedicationSchedule todaySchedule;
    late MedicationSchedule todayTakenSchedule;
    late MedicationSchedule todayOverdueSchedule;
    late MedicationSchedule overdueSchedule;
    late MedicationSchedule upcomingSchedule;

    setUp(() {
      final today = Date.today();

      todaySchedule = IntervalDaysSchedule(
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

      todayTakenSchedule = IntervalDaysSchedule(
        id: 5,
        name: 'TodayMed',
        dose: Decimal.one,
        intervalDays: 2,
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(5))
          .thenReturn(Date.today());

      todayOverdueSchedule = IntervalDaysSchedule(
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

      overdueSchedule = IntervalDaysSchedule(
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

      upcomingSchedule = IntervalDaysSchedule(
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

      when(mockScheduleProvider.schedules).thenReturn([
        todaySchedule,
        todayOverdueSchedule,
        overdueSchedule,
        todayTakenSchedule,
        upcomingSchedule,
      ]);
    });

    test('today returns schedules due today, not late and not taken', () {
      final today = Date.today();

      when(mockIntakeProvider.getLastIntakeLocalDateForSchedule(1))
          .thenReturn(today.subtract(const Duration(days: 2)));

      final result = manager.getSchedulesByStatus(ScheduleStatus.today);
      expect(result, [todaySchedule]);
    });

    test('upcoming return upcoming schedules', () {
      final result = manager.getSchedulesByStatus(ScheduleStatus.upcoming);
      expect(result, [upcomingSchedule]);
    });

    test('todayOverdue returns only todayOverdue schedules', () {
      final result = manager.getSchedulesByStatus(ScheduleStatus.todayOverdue);
      expect(result, [todayOverdueSchedule]);
    });

    test('overdue returns only overdue schedules', () {
      final result = manager.getSchedulesByStatus(ScheduleStatus.overdue);
      expect(result, [overdueSchedule]);
    });

    test('all schedules accounted for across statuses', () {
      final today = manager.getSchedulesByStatus(ScheduleStatus.today);
      final todayOverdue =
          manager.getSchedulesByStatus(ScheduleStatus.todayOverdue);
      final overdue = manager.getSchedulesByStatus(ScheduleStatus.overdue);
      final upcoming = manager.getSchedulesByStatus(ScheduleStatus.upcoming);
      final taken = manager.getSchedulesByStatus(ScheduleStatus.taken);

      final combined = [
        ...today,
        ...todayOverdue,
        ...overdue,
        ...upcoming,
        ...taken
      ];
      expect(combined.length, 5);
      expect(
          combined,
          containsAll([
            todaySchedule,
            todayOverdueSchedule,
            overdueSchedule,
            upcomingSchedule,
            todayTakenSchedule
          ]));
    });
  });

  group('ScheduleManager - getSlots', () {
    late IntervalDaysSchedule todaySchedule;
    late IntervalDaysSchedule todayTakenSchedule;
    late IntervalDaysSchedule todayOverdueSchedule;
    late IntervalDaysSchedule todayEarlySchedule;
    late IntervalDaysSchedule overdueSchedule;
    late IntervalDaysSchedule upcomingSchedule;

    setUp(() {
      final today = Date.today();

      todaySchedule = IntervalDaysSchedule(
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

      todayTakenSchedule = IntervalDaysSchedule(
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

      todayOverdueSchedule = IntervalDaysSchedule(
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

      todayEarlySchedule = IntervalDaysSchedule(
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

      overdueSchedule = IntervalDaysSchedule(
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

      upcomingSchedule = IntervalDaysSchedule(
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
}
