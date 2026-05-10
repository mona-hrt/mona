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

  List<IntervalDaysSchedule> getSchedulesByStatus(ScheduleStatus status) {
    return _medicationScheduleProvider.schedules
        .whereType<IntervalDaysSchedule>()
        .where(
            (schedule) => schedule.statusFor(_lastTakenFor(schedule)) == status)
        .toList();
  }

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

  Date? _lastTakenFor(IntervalDaysSchedule schedule) =>
      _medicationIntakeProvider.getLastIntakeLocalDateForSchedule(schedule.id);
}
