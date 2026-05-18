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

      todaySchedule = MedicationSchedule(
        id: 1,
        name: 'TodayMed',
        dose: Decimal.one,
        daysOfWeek: [today.weekday],
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeDateForSchedule(1))
          .thenReturn(today.subtract(const Duration(days: 7)));

      todayTakenSchedule = MedicationSchedule(
        id: 5,
        name: 'TodayMed',
        dose: Decimal.one,
        daysOfWeek: [today.weekday],
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeDateForSchedule(5))
          .thenReturn(Date.today());

      todayOverdueSchedule = MedicationSchedule(
        id: 4,
        name: 'TodayLateMed',
        dose: Decimal.one,
        daysOfWeek: [today.weekday],
        startDate: today.subtract(const Duration(days: 7)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeDateForSchedule(4))
          .thenReturn(today.subtract(const Duration(days: 8)));

      overdueSchedule = MedicationSchedule(
        id: 2,
        name: 'OverdueMed',
        dose: Decimal.one,
        daysOfWeek: [today.subtract(const Duration(days: 1)).weekday],
        startDate: today.subtract(const Duration(days: 8)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeDateForSchedule(2))
          .thenReturn(today.subtract(const Duration(days: 9)));

      upcomingSchedule = MedicationSchedule(
        id: 3,
        name: 'UpcomingMed',
        dose: Decimal.one,
        daysOfWeek: [today.add(const Duration(days: 1)).weekday],
        startDate: today.add(const Duration(days: 1)),
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );
      when(mockIntakeProvider.getLastIntakeDateForSchedule(3)).thenReturn(null);

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

      todaySchedule = MedicationSchedule(
        id: 1,
        name: 'TodayMed',
        dose: Decimal.one,
        daysOfWeek: [today.weekday],
        startDate: today,
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
        notificationTimes: List.empty(),
      );

      when(mockIntakeProvider.getLastIntakeDateForSchedule(1))
          .thenReturn(today.subtract(const Duration(days: 7)));

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
}
