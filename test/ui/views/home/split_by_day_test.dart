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

    test('breaks upcoming ties on the same date by the saved order', () {
      // Arrange
      final date = Date.today().add(const Duration(days: 2));
      final one = occurrence(
        schedule: aMedicationSchedule(id: 1),
        status: ScheduleStatus.upcoming,
        date: date,
      );
      final two = occurrence(
        schedule: aMedicationSchedule(id: 2),
        status: ScheduleStatus.upcoming,
        date: date,
      );

      // Act
      final upcoming = splitByDay([one, two], scheduleOrder: [2, 1]).upcoming;

      // Assert
      expect(upcoming.map((o) => o.schedule.id), [2, 1]);
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

    test('sorts asNeeded occurrences by the saved order', () {
      // Arrange
      final first = occurrence(
        schedule: aMedicationSchedule(id: 1),
        status: ScheduleStatus.asNeeded,
      );
      final second = occurrence(
        schedule: aMedicationSchedule(id: 2),
        status: ScheduleStatus.asNeeded,
      );
      final third = occurrence(
        schedule: aMedicationSchedule(id: 3),
        status: ScheduleStatus.asNeeded,
      );

      // Act
      final asNeeded =
          splitByDay([first, second, third], scheduleOrder: [3, 1, 2]).asNeeded;

      // Assert
      expect(asNeeded.map((o) => o.schedule.id), [3, 1, 2]);
    });

    test('falls back to id order for schedules missing from the saved order',
        () {
      // Arrange
      final one = occurrence(
        schedule: aMedicationSchedule(id: 1),
        status: ScheduleStatus.asNeeded,
      );
      final two = occurrence(
        schedule: aMedicationSchedule(id: 2),
        status: ScheduleStatus.asNeeded,
      );

      // Act
      final asNeeded = splitByDay([two, one], scheduleOrder: const []).asNeeded;

      // Assert
      expect(asNeeded.map((o) => o.schedule.id), [1, 2]);
    });
  });
}
