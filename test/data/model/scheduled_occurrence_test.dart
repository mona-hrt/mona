import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduled_occurrence.dart';
import 'package:mona/data/model/scheduling_strategy.dart';

void main() {
  group('ScheduledOccurrence', () {
    final schedule = MedicationSchedule(
      id: 1,
      name: 'Med',
      dose: Decimal.fromInt(10),
      scheduling: IntervalDaysSchedule(intervalDays: 1),
      molecule: KnownMolecules.estradiol,
      administrationRoute: AdministrationRoute.oral,
    );

    group('notificationDateTime', () {
      test('returns null if notificationTime is null', () {
        final occ = ScheduledOccurrence(
          schedule: schedule,
          date: Date.today(),
          status: ScheduleStatus.upcoming,
          notifiable: true,
          notificationTime: null,
        );

        expect(occ.notificationDateTime, isNull);
      });

      test('returns same day if hour is >= 4', () {
        final date = Date.fromString('2026-05-31T00:00:00.000Z');
        final time = const TimeOfDay(hour: 4, minute: 0);
        final occ = ScheduledOccurrence(
          schedule: schedule,
          date: date,
          status: ScheduleStatus.upcoming,
          notifiable: true,
          notificationTime: time,
        );

        expect(occ.notificationDateTime, DateTime(2026, 5, 31, 4, 0));
      });

      test('returns next day if hour is < 4', () {
        final date = Date.fromString('2026-05-31T00:00:00.000Z');
        final time = const TimeOfDay(hour: 3, minute: 59);
        final occ = ScheduledOccurrence(
          schedule: schedule,
          date: date,
          status: ScheduleStatus.upcoming,
          notifiable: true,
          notificationTime: time,
        );

        // May 31st logical date with 3:59am time should be June 1st 3:59am
        expect(occ.notificationDateTime, DateTime(2026, 6, 1, 3, 59));
      });

      test('midnight belongs to the next day', () {
        final date = Date.fromString('2026-05-31T00:00:00.000Z');
        final time = const TimeOfDay(hour: 0, minute: 0);
        final occ = ScheduledOccurrence(
          schedule: schedule,
          date: date,
          status: ScheduleStatus.upcoming,
          notifiable: true,
          notificationTime: time,
        );

        expect(occ.notificationDateTime, DateTime(2026, 6, 1, 0, 0));
      });

      test('noon belongs to the same day', () {
        final date = Date.fromString('2026-05-31T00:00:00.000Z');
        final time = const TimeOfDay(hour: 12, minute: 0);
        final occ = ScheduledOccurrence(
          schedule: schedule,
          date: date,
          status: ScheduleStatus.upcoming,
          notifiable: true,
          notificationTime: time,
        );

        expect(occ.notificationDateTime, DateTime(2026, 5, 31, 12, 0));
      });
    });
  });
}
