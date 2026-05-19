import 'package:flutter/material.dart';
import 'package:mona/controllers/schedule_occurrences.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
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
  final MedicationScheduleProvider _scheduleProvider;
  final ScheduleOccurrences _occurrences;

  ScheduleManager(this._scheduleProvider, this._occurrences);

  List<ScheduleSlot> getSlots() => [
        for (final schedule in _scheduleProvider.schedules)
          for (final occ in _occurrences.currentFor(schedule))
            ScheduleSlot(
              schedule: schedule,
              status: occ.status,
              time: occ.time,
              intake: occ.intake,
            ),
      ];

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
