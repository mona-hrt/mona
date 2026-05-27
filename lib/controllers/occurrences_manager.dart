// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:collection/collection.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduled_occurrence.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

class OccurrencesManager {
  final MedicationIntakeProvider _medicationIntakeProvider;
  final MedicationScheduleProvider _medicationScheduleProvider;

  const OccurrencesManager(
      this._medicationIntakeProvider, this._medicationScheduleProvider);

  List<ScheduledOccurrence> current() {
    final schedules = _medicationScheduleProvider.schedules;
    final occurrences = <ScheduledOccurrence>[];

    for (final schedule in schedules) {
      switch (schedule.scheduling) {
        case IntervalDaysSchedule scheduling:
          occurrences.addAll(_interval(schedule, scheduling, [Date.today()]));
        case DailySchedule scheduling:
          occurrences.addAll(_daily(schedule, scheduling, 1));
      }
    }

    return occurrences;
  }

  List<ScheduledOccurrence> upcoming({required int days}) {
    final schedules = _medicationScheduleProvider.schedules;
    final occurrences = <ScheduledOccurrence>[];

    for (final schedule in schedules) {
      switch (schedule.scheduling) {
        case IntervalDaysSchedule s:
          occurrences.addAll(
              _interval(schedule, s, s.getNextDates(schedule.startDate, days)));
        case DailySchedule s:
          occurrences.addAll(_daily(schedule, s, days));
      }
    }

    return occurrences;
  }

  List<ScheduledOccurrence> _interval(
    MedicationSchedule schedule,
    IntervalDaysSchedule scheduling,
    List<Date> dates,
  ) {
    final lastTaken = _medicationIntakeProvider
        .getLastIntakeLocalDateForSchedule(schedule.id);
    final lastIntake =
        _medicationIntakeProvider.getLastTakenIntakeForSchedule(schedule.id);
    final notifiable = scheduling.notificationTime != null;

    return [
      for (final date in dates)
        () {
          final status = scheduling.statusFor(
              startDate: schedule.startDate, date: date, lastTaken: lastTaken);
          return ScheduledOccurrence(
            schedule: schedule,
            date: date,
            notificationTime: scheduling.notificationTime,
            status: status,
            intake: status == ScheduleStatus.taken ? lastIntake : null,
            notifiable: notifiable,
          );
        }(),
    ];
  }

  List<ScheduledOccurrence> _daily(
    MedicationSchedule schedule,
    DailySchedule scheduling,
    int days,
  ) {
    final today = Date.today();
    final takenToday = _medicationIntakeProvider.getTakenIntakesForScheduleOn(
        schedule.id, today);

    return [
      for (var i = 0; i < days; i++)
        for (final time in scheduling.intakeTimes)
          () {
            final date = today.add(Duration(days: i));
            final match = date.isToday
                ? takenToday.firstWhereOrNull((it) => it.scheduledTime == time)
                : null;
            return ScheduledOccurrence(
              schedule: schedule,
              date: date,
              time: time,
              notificationTime: time,
              status: scheduling.statusFor(date: date, matchedIntake: match),
              intake: match,
              notifiable: scheduling.notify,
            );
          }(),
    ];
  }
}
