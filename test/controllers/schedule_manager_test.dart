import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/schedule_manager.dart';
import 'package:mona/controllers/schedule_occurrences.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduled_occurrence.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

@GenerateNiceMocks([
  MockSpec<MedicationScheduleProvider>(),
  MockSpec<ScheduleOccurrences>(),
])
import 'schedule_manager_test.mocks.dart';

MedicationSchedule schedule({int id = 1, SchedulingStrategy? scheduling}) =>
    MedicationSchedule(
      id: id,
      name: 'Med',
      dose: Decimal.one,
      scheduling: scheduling ?? IntervalDaysSchedule(intervalDays: 1),
      molecule: KnownMolecules.estradiol,
      administrationRoute: AdministrationRoute.oral,
    );

ScheduledOccurrence occurrence({
  ScheduleStatus status = ScheduleStatus.today,
  TimeOfDay? time,
  MedicationIntake? intake,
}) =>
    ScheduledOccurrence(
      date: Date.today(),
      status: status,
      notifiable: true,
      time: time,
      intake: intake,
    );

void main() {
  late MockMedicationScheduleProvider scheduleProvider;
  late MockScheduleOccurrences occurrences;
  late ScheduleManager manager;

  setUp(() {
    scheduleProvider = MockMedicationScheduleProvider();
    occurrences = MockScheduleOccurrences();
    manager = ScheduleManager(scheduleProvider, occurrences);
  });

  group('getSlots', () {
    test('returns empty list when there are no schedules', () {
      when(scheduleProvider.schedules).thenReturn([]);

      expect(manager.getSlots(), isEmpty);
    });

    test('maps occurrence status / time / intake onto each slot', () {
      final intake = MedicationIntake(
        id: 99,
        dose: Decimal.one,
        takenDateTime: DateTime.utc(2025, 1, 1, 8),
        takenTimeZone: 'Etc/UTC',
        molecule: KnownMolecules.estradiol,
        administrationRoute: AdministrationRoute.oral,
      );
      final s = schedule(id: 1);
      const time = TimeOfDay(hour: 8, minute: 0);

      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.currentFor(s)).thenReturn([
        occurrence(
            status: ScheduleStatus.taken, time: time, intake: intake),
      ]);

      final slot = manager.getSlots().single;

      expect(slot.schedule, s);
      expect(slot.status, ScheduleStatus.taken);
      expect(slot.time, time);
      expect(slot.intake, intake);
    });

    test('flattens multiple occurrences from a single schedule', () {
      final s = schedule(id: 1);

      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.currentFor(s)).thenReturn([
        occurrence(time: const TimeOfDay(hour: 8, minute: 0)),
        occurrence(time: const TimeOfDay(hour: 14, minute: 0)),
        occurrence(time: const TimeOfDay(hour: 20, minute: 0)),
      ]);

      expect(manager.getSlots(), hasLength(3));
    });

    test('preserves schedule order across multiple schedules', () {
      final a = schedule(id: 1);
      final b = schedule(id: 2);

      when(scheduleProvider.schedules).thenReturn([a, b]);
      when(occurrences.currentFor(a))
          .thenReturn([occurrence(status: ScheduleStatus.upcoming)]);
      when(occurrences.currentFor(b))
          .thenReturn([occurrence(status: ScheduleStatus.overdue)]);

      final slots = manager.getSlots();

      expect(slots[0].schedule, a);
      expect(slots[1].schedule, b);
    });
  });

  group('splitSlotsByDay', () {
    test('returns two empty lists when there are no schedules', () {
      when(scheduleProvider.schedules).thenReturn([]);

      final split = manager.splitSlotsByDay();

      expect(split.today, isEmpty);
      expect(split.upcoming, isEmpty);
    });

    test('routes upcoming status to `upcoming`, everything else to `today`',
        () {
      final a = schedule(id: 1);
      final b = schedule(id: 2);
      final c = schedule(id: 3);
      final d = schedule(id: 4);

      when(scheduleProvider.schedules).thenReturn([a, b, c, d]);
      when(occurrences.currentFor(a))
          .thenReturn([occurrence(status: ScheduleStatus.today)]);
      when(occurrences.currentFor(b))
          .thenReturn([occurrence(status: ScheduleStatus.taken)]);
      when(occurrences.currentFor(c))
          .thenReturn([occurrence(status: ScheduleStatus.upcoming)]);
      when(occurrences.currentFor(d))
          .thenReturn([occurrence(status: ScheduleStatus.overdue)]);

      final split = manager.splitSlotsByDay();

      expect(split.today.map((s) => s.schedule), [d, a, b]);
      expect(split.upcoming.map((s) => s.schedule), [c]);
    });

    test('places overdue and todayOverdue first within today, preserving order',
        () {
      final a = schedule(id: 1);
      final b = schedule(id: 2);
      final c = schedule(id: 3);

      when(scheduleProvider.schedules).thenReturn([a, b, c]);
      when(occurrences.currentFor(a))
          .thenReturn([occurrence(status: ScheduleStatus.today)]);
      when(occurrences.currentFor(b))
          .thenReturn([occurrence(status: ScheduleStatus.todayOverdue)]);
      when(occurrences.currentFor(c))
          .thenReturn([occurrence(status: ScheduleStatus.overdue)]);

      final split = manager.splitSlotsByDay();

      expect(split.today.map((s) => s.schedule), [b, c, a]);
    });

    test('sorts non-overdue today slots by time, with null times first', () {
      final s = schedule(id: 1);

      when(scheduleProvider.schedules).thenReturn([s]);
      when(occurrences.currentFor(s)).thenReturn([
        occurrence(time: const TimeOfDay(hour: 20, minute: 30)),
        occurrence(),
        occurrence(time: const TimeOfDay(hour: 8, minute: 0)),
        occurrence(time: const TimeOfDay(hour: 14, minute: 0)),
      ]);

      final times = manager.splitSlotsByDay().today.map((s) => s.time).toList();

      expect(times, [
        null,
        const TimeOfDay(hour: 8, minute: 0),
        const TimeOfDay(hour: 14, minute: 0),
        const TimeOfDay(hour: 20, minute: 30),
      ]);
    });
  });
}
