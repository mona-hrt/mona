import 'package:flutter/material.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

enum ScheduleStatus {
  overdue,
  todayOverdue,
  todayEarly,
  today,
  upcoming,
  taken
}

class ScheduleSlot {
  final MedicationSchedule schedule;
  final ScheduleStatus status;
  final TimeOfDay? time;

  ScheduleSlot({
    required this.schedule,
    required this.status,
    this.time,
  });
}

class ScheduleManager {
  final MedicationScheduleProvider _medicationScheduleProvider;
  final MedicationIntakeProvider _medicationIntakeProvider;

  ScheduleManager(
      this._medicationScheduleProvider, this._medicationIntakeProvider);

  List<IntervalDaysSchedule> getSchedulesByStatus(ScheduleStatus status) {
    final List<IntervalDaysSchedule> schedules = [];
    for (final schedule in _medicationScheduleProvider.schedules) {
      if (schedule is! IntervalDaysSchedule) continue;
      final Date? lastTaken = _medicationIntakeProvider
          .getLastIntakeLocalDateForSchedule(schedule.id);

      switch (status) {
        case ScheduleStatus.today:
          if (schedule.isScheduledForToday() &&
              !schedule.isLate(lastTaken) &&
              !schedule.isTakenTodayOrLater(lastTaken)) {
            schedules.add(schedule);
          }
          break;
        case ScheduleStatus.todayOverdue:
          if (schedule.isScheduledForToday() && schedule.isLate(lastTaken)) {
            schedules.add(schedule);
          }
          break;
        case ScheduleStatus.todayEarly:
          break;
        case ScheduleStatus.overdue:
          if (!schedule.isScheduledForToday() && schedule.isLate(lastTaken)) {
            schedules.add(schedule);
          }
          break;
        case ScheduleStatus.upcoming:
          if ((!schedule.isScheduledForToday() &&
              !schedule.isLate(lastTaken))) {
            schedules.add(schedule);
          }
          break;
        case ScheduleStatus.taken:
          if (schedule.isScheduledForToday() &&
              schedule.isTakenTodayOrLater(lastTaken)) {
            schedules.add(schedule);
          }
          break;
      }
    }
    return schedules;
  }

  List<ScheduleSlot> getSlots() {
    final List<ScheduleSlot> slots = [];
    for (final schedule in _medicationScheduleProvider.schedules) {
      if (schedule is! IntervalDaysSchedule) continue;

      final Date? lastTaken = _medicationIntakeProvider
          .getLastIntakeLocalDateForSchedule(schedule.id);

      final bool isScheduledForToday = schedule.isScheduledForToday();
      final bool isLate = schedule.isLate(lastTaken);
      final bool isLastTakenLate = schedule.lastTakenLate(lastTaken);
      final bool isTaken = schedule.isTakenTodayOrLater(lastTaken);

      final ScheduleStatus status = isScheduledForToday
          ? isTaken
              ? ScheduleStatus.taken
              : isLate
                  ? ScheduleStatus.todayOverdue
                  : isLastTakenLate
                      ? ScheduleStatus.todayEarly
                      : ScheduleStatus.today
          : isLate
              ? ScheduleStatus.overdue
              : ScheduleStatus.upcoming;

      slots.add(ScheduleSlot(
        schedule: schedule,
        status: status,
        time: null,
      ));
    }
    return slots;
  }
}
