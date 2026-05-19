import 'package:flutter/material.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/scheduling_strategy.dart';

@immutable
class ScheduledOccurrence {
  final Date date;
  final TimeOfDay? time;
  final ScheduleStatus status;
  final MedicationIntake? intake;
  final bool notifiable;

  const ScheduledOccurrence({
    required this.date,
    required this.status,
    required this.notifiable,
    this.time,
    this.intake,
  });

  DateTime? get localDateTime {
    final t = time;
    if (t == null) return null;
    return DateTime(date.year, date.month, date.day, t.hour, t.minute);
  }
}
