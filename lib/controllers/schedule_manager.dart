import 'package:flutter/material.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

class ScheduleSlot {
  final MedicationSchedule schedule;
  final ScheduleStatus status;
  final TimeOfDay? time;
  final MedicationIntake? intake;

  ScheduleSlot({
    required this.schedule,
    required this.status,
    this.time,
    this.intake,
  });
}

class ScheduleManager {
  final MedicationScheduleProvider _medicationScheduleProvider;
  final MedicationIntakeProvider _medicationIntakeProvider;

  ScheduleManager(
      this._medicationScheduleProvider, this._medicationIntakeProvider);

  List<ScheduleSlot> getSlots() {
    final today = Date.today();
    final slots = <ScheduleSlot>[];

    for (final schedule in _medicationScheduleProvider.schedules) {
      switch (schedule.scheduling) {
        case IntervalDaysSchedule scheduling:
          slots.add(_toSlot(
            schedule,
            scheduling.slotInfoFor(
              startDate: schedule.startDate,
              lastTakenLocalDate: _medicationIntakeProvider
                  .getLastIntakeLocalDateForSchedule(schedule.id),
              lastTakenIntake: _medicationIntakeProvider
                  .getLastTakenIntakeForSchedule(schedule.id),
            ),
          ));
        case DailySchedule scheduling:
          final takenToday = _medicationIntakeProvider
              .getTakenIntakesForScheduleOn(schedule.id, today);
          for (final info
              in scheduling.slotInfosFor(takenIntakesToday: takenToday)) {
            slots.add(_toSlot(schedule, info));
          }
      }
    }

    return slots;
  }

  static ScheduleSlot _toSlot(MedicationSchedule schedule, SlotInfo info) =>
      ScheduleSlot(
        schedule: schedule,
        status: info.status,
        time: info.time,
        intake: info.intake,
      );

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

    otherToday.sort(_byTimeNullsFirst);

    return (today: [...overdueToday, ...otherToday], upcoming: upcoming);
  }

  static int _byTimeNullsFirst(ScheduleSlot a, ScheduleSlot b) {
    final at = a.time;
    final bt = b.time;
    if (at == null && bt == null) return 0;
    if (at == null) return -1;
    if (bt == null) return 1;
    final hourCompare = at.hour.compareTo(bt.hour);
    return hourCompare != 0 ? hourCompare : at.minute.compareTo(bt.minute);
  }
}
