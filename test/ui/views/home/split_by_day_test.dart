import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/intake_slot.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/ui/views/home/split_by_day.dart';

import '../../../fixtures.dart';

IntakeSlot occurrence({
  MedicationSchedule? schedule,
  ScheduleStatus status = ScheduleStatus.today,
  TimeOfDay? time,
  Date? date,
}) =>
    IntakeSlot(
      schedule: schedule ?? aMedicationSchedule(),
      status: status,
      date: date ?? Date.today(),
      time: time,
    );

void main() {
  group('splitByDay', () {
    test('returns empty lists when there are no occurrences', () {
      final split = splitByDay([]);

      expect(split.today, isEmpty);
      expect(split.asNeeded, isEmpty);
      expect(split.upcoming, isEmpty);
    });

    test(
        'routes upcoming to `upcoming`, asNeeded to `asNeeded`, rest to `today`',
        () {
      final a = aMedicationSchedule(id: 1);
      final b = aMedicationSchedule(id: 2);
      final c = aMedicationSchedule(id: 3);
      final d = aMedicationSchedule(id: 4);
      final e = aMedicationSchedule(id: 5);

      final split = splitByDay([
        occurrence(schedule: a, status: ScheduleStatus.today),
        occurrence(schedule: b, status: ScheduleStatus.taken),
        occurrence(schedule: c, status: ScheduleStatus.upcoming),
        occurrence(schedule: d, status: ScheduleStatus.overdue),
        occurrence(schedule: e, status: ScheduleStatus.asNeeded),
      ]);

      expect(split.today.map((o) => o.schedule), [d, a, b]);
      expect(split.asNeeded.map((o) => o.schedule), [e]);
      expect(split.upcoming.map((o) => o.schedule), [c]);
    });

    test('places overdue and todayOverdue first within today, preserving order',
        () {
      final a = aMedicationSchedule(id: 1);
      final b = aMedicationSchedule(id: 2);
      final c = aMedicationSchedule(id: 3);

      final split = splitByDay([
        occurrence(schedule: a, status: ScheduleStatus.today),
        occurrence(schedule: b, status: ScheduleStatus.todayOverdue),
        occurrence(schedule: c, status: ScheduleStatus.overdue),
      ]);

      expect(split.today.map((o) => o.schedule), [b, c, a]);
    });

    test('sorts non-overdue today occurrences by time, with null times first',
        () {
      final s = aMedicationSchedule(id: 1);

      final times = splitByDay([
        occurrence(schedule: s, time: const TimeOfDay(hour: 20, minute: 30)),
        occurrence(schedule: s),
        occurrence(schedule: s, time: const TimeOfDay(hour: 8, minute: 0)),
        occurrence(schedule: s, time: const TimeOfDay(hour: 14, minute: 0)),
      ]).today.map((o) => o.time).toList();

      expect(times, [
        null,
        const TimeOfDay(hour: 8, minute: 0),
        const TimeOfDay(hour: 14, minute: 0),
        const TimeOfDay(hour: 20, minute: 30),
      ]);
    });

    test('sorts upcoming occurrences by date ascending', () {
      // Arrange
      final inOneDay = occurrence(
        status: ScheduleStatus.upcoming,
        date: Date.today().add(const Duration(days: 1)),
      );
      final inThreeDays = occurrence(
        status: ScheduleStatus.upcoming,
        date: Date.today().add(const Duration(days: 3)),
      );
      final inAWeek = occurrence(
        status: ScheduleStatus.upcoming,
        date: Date.today().add(const Duration(days: 7)),
      );

      // Act
      final upcoming = splitByDay([inAWeek, inOneDay, inThreeDays]).upcoming;

      // Assert
      expect(upcoming, [inOneDay, inThreeDays, inAWeek]);
    });

    test('sorts same-date upcoming occurrences by time, null times first', () {
      // Arrange
      final date = Date.today().add(const Duration(days: 2));
      final noTime = occurrence(status: ScheduleStatus.upcoming, date: date);
      final morning = occurrence(
        status: ScheduleStatus.upcoming,
        date: date,
        time: const TimeOfDay(hour: 8, minute: 0),
      );
      final evening = occurrence(
        status: ScheduleStatus.upcoming,
        date: date,
        time: const TimeOfDay(hour: 20, minute: 0),
      );

      // Act
      final upcoming = splitByDay([evening, morning, noTime]).upcoming;

      // Assert
      expect(upcoming, [noTime, morning, evening]);
    });

    test('breaks upcoming ties on the same date by schedule name', () {
      // Arrange
      final date = Date.today().add(const Duration(days: 2));
      final nulcac2 = occurrence(
        schedule: aMedicationSchedule(id: 1, name: 'Nulcac2'),
        status: ScheduleStatus.upcoming,
        date: date,
      );
      final bicancul = occurrence(
        schedule: aMedicationSchedule(id: 2, name: 'Bicanul'),
        status: ScheduleStatus.upcoming,
        date: date,
      );

      // Act
      final upcoming = splitByDay([nulcac2, bicancul]).upcoming;

      // Assert
      expect(upcoming, [bicancul, nulcac2]);
    });

    test('sorts overdue occurrences by date, most overdue first', () {
      // Arrange
      final yesterday = occurrence(
        status: ScheduleStatus.overdue,
        date: Date.today().subtract(const Duration(days: 1)),
      );
      final lastWeek = occurrence(
        status: ScheduleStatus.overdue,
        date: Date.today().subtract(const Duration(days: 7)),
      );
      final threeDaysAgo = occurrence(
        status: ScheduleStatus.overdue,
        date: Date.today().subtract(const Duration(days: 3)),
      );

      // Act
      final today = splitByDay([yesterday, lastWeek, threeDaysAgo]).today;

      // Assert
      expect(today, [lastWeek, threeDaysAgo, yesterday]);
    });

    test('sorts asNeeded occurrences by name', () {
      // Arrange
      final banana = occurrence(
        schedule: aMedicationSchedule(id: 1, name: 'banana'),
        status: ScheduleStatus.asNeeded,
      );
      final apple = occurrence(
        schedule: aMedicationSchedule(id: 2, name: 'Apple'),
        status: ScheduleStatus.asNeeded,
      );
      final cherry = occurrence(
        schedule: aMedicationSchedule(id: 3, name: 'Cherry'),
        status: ScheduleStatus.asNeeded,
      );

      // Act
      final asNeeded = splitByDay([banana, cherry, apple]).asNeeded;

      // Assert
      expect(asNeeded, [apple, banana, cherry]);
    });
  });
}
