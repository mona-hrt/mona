import 'package:flutter/material.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

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

  List<ScheduleSlot> getSlots() {
    return _medicationScheduleProvider.schedules
        .whereType<IntervalDaysSchedule>()
        .map((schedule) => ScheduleSlot(
              schedule: schedule,
              status: schedule.statusFor(_lastTakenFor(schedule)),
              time: null,
            ))
        .toList();
  }

  ({List<ScheduleSlot> today, List<ScheduleSlot> upcoming}) splitSlotsByDay() {
    final overdueToday = <ScheduleSlot>[];
    final otherToday = <ScheduleSlot>[];
    final upcoming = <ScheduleSlot>[];

    for (final slot in getSlots()) {
      if (slot.status == ScheduleStatus.upcoming) {
        upcoming.add(slot);
      } else if (slot.status == ScheduleStatus.overdue ||
          slot.status == ScheduleStatus.todayOverdue) {
        overdueToday.add(slot);
      } else {
        otherToday.add(slot);
      }
    }

    return (today: [...overdueToday, ...otherToday], upcoming: upcoming);
  }

  Date? _lastTakenFor(IntervalDaysSchedule schedule) =>
      _medicationIntakeProvider.getLastIntakeLocalDateForSchedule(schedule.id);
}
