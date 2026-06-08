import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';

/// A time before the [testNow] hour (noon).
const morning = TimeOfDay(hour: 9, minute: 0);

/// A time after the [testNow] hour (noon).
const afternoon = TimeOfDay(hour: 15, minute: 0);

int _nextId = 1;
int _generateId() => _nextId++;

MedicationSchedule aMedicationSchedule({
  int? id,
  String? name,
  SchedulingStrategy? scheduling,
  Date? startDate,
}) {
  final resolvedId = id ?? _generateId();
  return MedicationSchedule(
    id: resolvedId,
    name: name ?? 'Med-$resolvedId',
    dose: Decimal.one,
    scheduling: scheduling ?? aSchedulingStrategy(),
    startDate: startDate ?? Date.today(),
    molecule: KnownMolecules.estradiol,
    administrationRoute: AdministrationRoute.oral,
  );
}

SchedulingStrategy aSchedulingStrategy() => switch (Random().nextInt(3)) {
      0 => anIntervalStrategy(),
      1 => aDailyStrategy(),
      2 => aWeeklyStrategy(),
      _ => throw StateError('unreachable'),
    };

IntervalDaysSchedule anIntervalStrategy({
  int intervalDays = 7,
  List<TimeOfDay> notificationTimes = const [],
}) =>
    IntervalDaysSchedule(
      intervalDays: intervalDays,
      notificationTimes: notificationTimes,
    );

DailySchedule aDailyStrategy({
  List<TimeOfDay> intakeTimes = const [afternoon],
  bool notify = true,
}) =>
    DailySchedule(intakeTimes: intakeTimes, notify: notify);

WeeklySchedule aWeeklyStrategy({
  List<int> daysOfWeek = const [1],
  List<TimeOfDay> notificationTimes = const [],
}) =>
    WeeklySchedule(
      daysOfWeek: daysOfWeek,
      notificationTimes: notificationTimes,
    );

MedicationIntake intakeAt(
  TimeOfDay time, {
  int? id,
  int? scheduleId,
}) =>
    MedicationIntake(
      id: id ?? _generateId(),
      dose: Decimal.one,
      takenDateTime: DateTime.utc(2025, 1, 1, time.hour, time.minute),
      takenTimeZone: 'Etc/UTC',
      scheduleId: scheduleId ?? _generateId(),
      molecule: KnownMolecules.estradiol,
      administrationRoute: AdministrationRoute.oral,
      scheduledTime: time,
    );
