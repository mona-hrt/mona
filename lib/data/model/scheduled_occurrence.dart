import 'package:flutter/material.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';

@immutable
class ScheduledOccurrence {
  final MedicationSchedule schedule;
  final Date date;
  final TimeOfDay? time;
  final TimeOfDay? notificationTime;
  final ScheduleStatus status;
  final MedicationIntake? intake;
  final bool notifiable;

  const ScheduledOccurrence({
    required this.schedule,
    required this.date,
    required this.status,
    required this.notifiable,
    this.time,
    this.notificationTime,
    this.intake,
  });

  DateTime? get notificationDateTime {
    final t = notificationTime;
    if (t == null) return null;
    final dt = DateTime(date.year, date.month, date.day, t.hour, t.minute);
    if (t.hour < 4) {
      return dt.add(const Duration(days: 1));
    }
    return dt;
  }
}
