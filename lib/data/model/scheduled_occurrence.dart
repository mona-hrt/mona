import 'package:collection/collection.dart';
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
    return DateTime(date.year, date.month, date.day, t.hour, t.minute);
  }
}

class Occurrences extends DelegatingList<ScheduledOccurrence> {
  Occurrences(super.base);

  Iterable<ScheduledOccurrence> get notifiable => where((occ) =>
      occ.notifiable &&
      occ.status != ScheduleStatus.taken &&
      occ.notificationDateTime != null);
}
