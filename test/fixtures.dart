import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/blood_test.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/dosing_basis.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/placement.dart';
import 'package:mona/data/model/planned_notification.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/data/model/units.dart';

/// A time before the [testNow] hour (noon).
const morning = TimeOfDay(hour: 9, minute: 0);

/// A time after the [testNow] hour (noon).
const afternoon = TimeOfDay(hour: 15, minute: 0);

const evening = TimeOfDay(hour: 20, minute: 30);

int _nextId = 1;
int _generateId() => _nextId++;

Molecule aMolecule({String name = 'custom', String massUnit = 'mg'}) =>
    Molecule(name: name, massUnit: massUnit);

MedicationSchedule aMedicationSchedule({
  int? id,
  String? name,
  SchedulingStrategy? scheduling,
  Date? startDate,
  Decimal? dose,
  AdministrationRoute administrationRoute = AdministrationRoute.oral,
  Ester? ester,
  DosingBasis dosingBasis = DosingBasis.mass,
}) {
  return MedicationSchedule(
    id: id ?? _generateId(),
    name: name ?? 'nulcac2',
    dose: dose ?? Decimal.one,
    scheduling: scheduling ?? aSchedulingStrategy(),
    startDate: startDate ?? Date.today(),
    molecule: KnownMolecules.estradiol,
    administrationRoute: administrationRoute,
    ester: ester,
    dosingBasis: dosingBasis,
  );
}

SchedulingStrategy aSchedulingStrategy() => switch (Random().nextInt(6)) {
      0 => anIntervalStrategy(),
      1 => aDailyStrategy(),
      2 => aWeeklyStrategy(),
      3 => aMonthlyStrategy(),
      4 => aDynamicIntervalStrategy(),
      5 => anAsNeededStrategy(),
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

DynamicIntervalSchedule aDynamicIntervalStrategy({
  int intervalDays = 7,
  List<TimeOfDay> notificationTimes = const [],
}) =>
    DynamicIntervalSchedule(
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

MonthlySchedule aMonthlyStrategy({
  int dayOfMonth = 21,
  int intervalMonths = 1,
  List<TimeOfDay> notificationTimes = const [],
}) =>
    MonthlySchedule(
      dayOfMonth: dayOfMonth,
      intervalMonths: intervalMonths,
      notificationTimes: notificationTimes,
    );

AsNeededSchedule anAsNeededStrategy() => const AsNeededSchedule();

Placement aPlacement({PlacementPreset preset = PlacementPreset.left}) =>
    PresetPlacement(preset);

Placement aCustomPlacement([String label = 'belly']) => CustomPlacement(label);

MedicationIntake aMedicationIntake({
  TimeOfDay? time,
  int? id,
  int? scheduleId,
  Decimal? dose,
  DateTime? takenDateTime,
  bool taken = true,
  int? medicationSupplyItemId,
  List<int> genericSupplyItemIds = const [],
  Decimal? wastedAmount,
  Decimal? deadSpace,
  AdministrationRoute administrationRoute = AdministrationRoute.oral,
  Ester? ester,
  List<Placement> placements = const [],
  DosingBasis dosingBasis = DosingBasis.mass,
}) {
  final takenAt = !taken
      ? null
      : takenDateTime ??
          (time != null
              ? DateTime.utc(2025, 1, 1, time.hour, time.minute)
              : DateTime.utc(2025, 1, 1));
  return MedicationIntake(
    id: id ?? _generateId(),
    takenDose: dose ?? Decimal.one,
    takenDateTime: takenAt,
    takenTimeZone: takenAt != null ? 'Etc/UTC' : null,
    scheduleId: scheduleId ?? _generateId(),
    molecule: KnownMolecules.estradiol,
    administrationRoute: administrationRoute,
    scheduledTime: time,
    medicationSupplyItemId: medicationSupplyItemId,
    genericSupplyItemIds: genericSupplyItemIds,
    wastedAmount: wastedAmount,
    deadSpace: deadSpace,
    ester: ester,
    placements: placements,
    dosingBasis: dosingBasis,
  );
}

/// An estradiol injection intake (the only kind plotted on the graph),
/// pinned to an exact UTC [takenDateTime].
MedicationIntake anInjection({
  int? id,
  int? scheduleId,
  required DateTime takenDateTime,
  Decimal? dose,
  Ester ester = Ester.valerate,
  List<Placement> placements = const [],
  DosingBasis dosingBasis = DosingBasis.mass,
}) =>
    MedicationIntake(
      id: id ?? _generateId(),
      takenDose: dose ?? Decimal.parse('2.0'),
      takenDateTime: takenDateTime,
      takenTimeZone: 'Etc/UTC',
      scheduleId: scheduleId,
      molecule: KnownMolecules.estradiol,
      administrationRoute: AdministrationRoute.injection,
      ester: ester,
      placements: placements,
      dosingBasis: dosingBasis,
    );

BloodTest aBloodTest({
  int? id,
  required DateTime dateTime,
  Decimal? estradiolLevel,
  Decimal? testosteroneLevel,
  String? notes,
}) =>
    BloodTest(
      id: id ?? _generateId(),
      dateTime: dateTime,
      timeZone: 'Etc/UTC',
      estradiolLevels: estradiolLevel != null
          ? UnitValue(estradiolLevel, EstradiolUnit.pg_mL)
          : null,
      testosteroneLevels: testosteroneLevel != null
          ? UnitValue(testosteroneLevel, TestosteroneUnit.ng_dL)
          : null,
      notes: notes,
    );

MedicationSupplyItem aMedicationSupplyItem({
  int? id,
  String? name,
  Decimal? totalDose,
  Decimal? usedDose,
  Decimal? dosePerUnit,
  AdministrationRoute administrationRoute = AdministrationRoute.oral,
  Molecule molecule = KnownMolecules.estradiol,
  Ester? ester,
  DosingBasis dosingBasis = DosingBasis.mass,
}) {
  final resolvedId = id ?? _generateId();
  return MedicationSupplyItem(
    id: resolvedId,
    name: name ?? 'MedSupply-$resolvedId',
    totalDose: totalDose ?? Decimal.parse('10'),
    usedDose: usedDose ?? Decimal.parse('1'),
    dosePerUnit: dosePerUnit ?? Decimal.parse('1'),
    molecule: molecule,
    administrationRoute: administrationRoute,
    ester: ester,
    dosingBasis: dosingBasis,
  );
}

GenericSupply aGenericSupplyItem({
  int? id,
  String? name,
  int amount = 5,
  GenericSupplyType genericSupplyType = GenericSupplyType.syringe,
}) {
  final resolvedId = id ?? _generateId();
  return GenericSupply(
    id: resolvedId,
    name: name ?? 'Generic-$resolvedId',
    amount: amount,
    genericSupplyType: genericSupplyType,
  );
}

SupplyItem aSupplyItem({
  int? id,
  String? name,
}) =>
    switch (Random().nextInt(2)) {
      0 => aMedicationSupplyItem(id: id, name: name),
      1 => aGenericSupplyItem(id: id, name: name),
      _ => throw StateError('unreachable'),
    };

/// The day after [testNow] at 09:00 UTC.
final _tomorrowMorning = DateTime.utc(2026, 6, 2, 9, 0);

/// The next Monday after [testNow] at 09:00 UTC.
final _nextMondayMorning = DateTime.utc(2026, 6, 8, 9, 0);

PlannedOccurrence anOccurrencePlan({
  MedicationSchedule? schedule,
  DateTime? dateTime,
}) =>
    PlannedOccurrence(
      schedule ?? aMedicationSchedule(),
      dateTime: dateTime ?? _tomorrowMorning,
    );

PlannedRepeating aDailyPlan({
  MedicationSchedule? schedule,
  DateTime? firstFire,
}) =>
    PlannedRepeating(
      schedule ?? aMedicationSchedule(),
      periodicity: Periodicity.daily,
      firstFire: firstFire ?? _tomorrowMorning,
    );

PlannedRepeating aWeeklyPlan({
  MedicationSchedule? schedule,
  int dayOfWeek = 1,
  DateTime? firstFire,
}) =>
    PlannedRepeating(
      schedule ?? aMedicationSchedule(),
      periodicity: Periodicity.weekly,
      firstFire: firstFire ?? _nextMondayMorning,
      dayOfWeek: dayOfWeek,
    );
