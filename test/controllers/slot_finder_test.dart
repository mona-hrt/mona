// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/controllers/slot_finder.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/intake_slot.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';

import '../fixtures.dart';

void main() {
  DateTime aScheduledTime({TimeOfDay? at}) =>
      DateTime(2026, 2, 8, at?.hour ?? 0, at?.minute ?? 0);

  IntakeSlot aSlot(
    MedicationSchedule schedule, {
    TimeOfDay? time,
    bool taken = false,
  }) =>
      IntakeSlot(
        schedule: schedule,
        status: taken ? ScheduleStatus.taken : ScheduleStatus.upcoming,
        date: Date.today(),
        time: time,
        intake: taken ? aMedicationIntake(scheduleId: schedule.id) : null,
      );

  group('findSlot', () {
    test('finds the correct target for a non-taken slot', () {
      // Arrange
      final schedule = aMedicationSchedule();
      final slots = [aSlot(schedule)];

      // Act
      final target = findSlot(schedule.id, aScheduledTime(), slots);

      // Assert
      expect(target, slots.single);
    });

    test('returns null when the matching slot is already taken', () {
      // Arrange
      final schedule = aMedicationSchedule();
      final slots = [aSlot(schedule, taken: true)];

      // Act
      final target = findSlot(schedule.id, aScheduledTime(), slots);

      // Assert
      expect(target, isNull);
    });

    test('returns null when no slot matches the schedule id', () {
      // Arrange
      final tapped = aMedicationSchedule();
      final other = aMedicationSchedule();
      final slots = [aSlot(other)];

      // Act
      final target = findSlot(tapped.id, aScheduledTime(), slots);

      // Assert
      expect(target, isNull);
    });

    test('matches the daily slot whose time of day equals the scheduled time',
        () {
      // Arrange
      final schedule = aMedicationSchedule();
      final slots = [
        aSlot(schedule, time: morning),
        aSlot(schedule, time: afternoon),
      ];

      // Act
      final target =
          findSlot(schedule.id, aScheduledTime(at: afternoon), slots);

      // Assert
      expect(target, slots.last);
    });

    test('returns null when no daily slot matches the scheduled time', () {
      // Arrange
      final schedule = aMedicationSchedule();
      final slots = [
        aSlot(schedule, time: morning),
        aSlot(schedule, time: afternoon),
      ];

      // Act
      final target = findSlot(schedule.id, aScheduledTime(at: evening), slots);

      // Assert
      expect(target, isNull);
    });
  });
}
