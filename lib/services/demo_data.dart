import 'dart:math';

import 'package:clock/clock.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:mona/controllers/medication_intake_manager.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/blood_test.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/delivery_form.dart';
import 'package:mona/data/model/dosing_basis.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/data/model/graph_calculator.dart';
import 'package:mona/data/model/injection_type.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/placement.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/util/time_difference.dart';

const _morning = TimeOfDay(hour: 8, minute: 0);
const _lateMorning = TimeOfDay(hour: 10, minute: 30);
const _evening = TimeOfDay(hour: 20, minute: 0);
const _night = TimeOfDay(hour: 22, minute: 0);

const _leftAbdomen = PresetPlacement(PlacementPreset.leftAbdomen);
const _rightAbdomen = PresetPlacement(PlacementPreset.rightAbdomen);
const _leftThigh = PresetPlacement(PlacementPreset.leftThigh);
const _rightThigh = PresetPlacement(PlacementPreset.rightThigh);
const _leftButtock = PresetPlacement(PlacementPreset.leftButtock);
const _rightButtock = PresetPlacement(PlacementPreset.rightButtock);
const _lowerBack = CustomPlacement('Lower back');

class DemoData {
  final List<SupplyItem> supplyItems = [];
  final List<MedicationSchedule> schedules = [];
  final List<MedicationIntake> intakes = [];
  final List<BloodTest> bloodTests = [];

  final String _timeZone;
  final DateTime _now = clock.now();
  final Date _today = Date.today();
  final Random _random = Random(42);
  int _nextId = 1;

  late final Date _hrtStart = _daysAgo(270);
  late final GenericSupply _syringes;
  late final GenericSupply _fillNeedles;
  late final GenericSupply _imNeedles;
  late final GenericSupply _scNeedles;
  late final GenericSupply _wipes;
  late final GenericSupply _bandages;

  DemoData.generate(this._timeZone) {
    _addGenericSupplies();
    final injections = [
      ..._addEstradiolValerate(),
      ..._addEstradiolEnanthate(),
    ];
    _addSpironolactone();
    _addProgesterone();
    _addEstradiolPatch();
    _addMinoxidil();
    _addFinasteride();
    _addDecapeptyl();
    _addEstradiolGel();
    _addBloodTests(injections);
  }

  void _addGenericSupplies() {
    _syringes = _generic('Syringes 1 mL', GenericSupplyType.syringe, 24);
    _fillNeedles = _generic('Fill needles 18G', GenericSupplyType.needle, 31);
    _imNeedles = _generic('Needles 23G', GenericSupplyType.needle, 6);
    _scNeedles = _generic('Needles 27G', GenericSupplyType.needle, 3);
    _wipes = _generic('Alcohol wipes', GenericSupplyType.wipe, 87);
    _bandages = _generic('Bandages', GenericSupplyType.bandage, 12);
    _generic('Nitrile gloves', GenericSupplyType.gloves, 0);
  }

  List<MedicationIntake> _addEstradiolValerate() {
    // these have no schedule
    final schedule = MedicationSchedule(
      id: _id(),
      name: 'Estradiol valerate',
      dose: Decimal.fromInt(4),
      scheduling: const IntervalDaysSchedule(intervalDays: 5),
      startDate: _hrtStart,
      molecule: KnownMolecules.estradiol,
      administrationRoute: AdministrationRoute.injection,
      ester: Ester.valerate,
      dosingBasis: DosingBasis.mass,
    );

    final taken = [
      for (var i = 0; i < 15; i++)
        _intake(
          schedule,
          _at(_hrtStart.add(Duration(days: 5 * i)), _evening, jitter: 30),
          linkSchedule: false,
          injectionType: InjectionType.intramuscular,
          placements: [i.isEven ? _leftThigh : _rightThigh],
          genericSupplyItemIds: [
            _syringes.id,
            _fillNeedles.id,
            _imNeedles.id,
            _wipes.id,
          ],
          wastedAmount: i == 4 || i == 11 ? Decimal.parse('0.1') : null,
          notes: switch (i) {
            0 => 'First injection!',
            4 || 11 => 'Air bubble, wasted some',
            _ => null,
          },
        ),
    ];
    _record(
      taken,
      supply: _medicationSupply(schedule,
          name: 'Estradiol valerate 40 mg/mL', dosePerUnit: '40', units: 2),
      fromSupply: taken.length,
    );
    return taken;
  }

  List<MedicationIntake> _addEstradiolEnanthate() {
    final schedule = _schedule(
      'Estradiol enanthate',
      dose: '5',
      molecule: KnownMolecules.estradiol,
      route: AdministrationRoute.injection,
      ester: Ester.enanthate,
      scheduling: const IntervalDaysSchedule(
          intervalDays: 7, notificationTimes: [_evening]),
      startDate: _daysAgo(196),
    );

    const scSites = [_leftAbdomen, _rightAbdomen, _leftThigh, _rightThigh];
    final taken = <MedicationIntake>[];
    for (var i = 0; i < 28; i++) {
      final subcutaneous = i >= 6;
      final day =
          schedule.startDate.add(Duration(days: 7 * i + (i == 9 ? 1 : 0)));
      taken.add(_intake(
        schedule,
        _at(day, _evening, jitter: 45),
        injectionType: subcutaneous
            ? InjectionType.subcutaneous
            : InjectionType.intramuscular,
        placements: [
          subcutaneous ? scSites[i % 4] : (i.isEven ? _leftThigh : _rightThigh)
        ],
        deadSpace: subcutaneous ? Decimal.fromInt(10) : null,
        wastedAmount: i == 20 ? Decimal.parse('0.05') : null,
        genericSupplyItemIds: [
          _syringes.id,
          _fillNeedles.id,
          subcutaneous ? _scNeedles.id : _imNeedles.id,
          _wipes.id,
          if (i % 4 == 0) _bandages.id,
        ],
        notes: switch (i) {
          6 => 'First subcutaneous injection',
          9 => 'Took it a day late',
          15 => 'Small bruise',
          20 => 'Spilled a little',
          _ => null,
        },
      ));
    }

    _record(
      taken,
      supply: _medicationSupply(schedule,
          name: 'Estradiol enanthate 40 mg/mL', dosePerUnit: '40', units: 5),
      fromSupply: 18,
    );
    supplyItems.add(_medicationSupply(schedule,
        name: 'Estradiol enanthate 40 mg/mL', dosePerUnit: '40', units: 5));
    return taken;
  }

  void _addSpironolactone() {
    final schedule = _schedule(
      'Spironolactone',
      dose: '50',
      molecule: KnownMolecules.spironolactone,
      route: AdministrationRoute.oral,
      scheduling: const DailySchedule(intakeTimes: [_morning, _evening]),
      startDate: _hrtStart,
    );

    final doseIncrease = _hrtStart.add(const Duration(days: 60));
    final taken = _daily(
      schedule,
      doseOn: (day) => day.isBefore(doseIncrease) ? Decimal.fromInt(25) : null,
    );
    final firstFullDose =
        taken.indexWhere((intake) => intake.takenDose == schedule.dose);
    taken[firstFullDose] =
        taken[firstFullDose].copyWith(notes: 'Dose increased to 50 mg');

    _record(
      taken,
      supply: _medicationSupply(schedule,
          name: 'Spironolactone 50 mg', dosePerUnit: '50', units: 60),
      fromSupply: 51,
    );
  }

  void _addProgesterone() {
    final schedule = _schedule(
      'Progesterone',
      dose: '100',
      molecule: KnownMolecules.progesterone,
      route: AdministrationRoute.oral,
      scheduling: const DailySchedule(intakeTimes: [_night], notify: false),
      startDate: _daysAgo(120),
    );

    _record(
      _daily(schedule, skipChance: 0.05),
      supply: _medicationSupply(schedule,
          name: 'Progesterone 100 mg', dosePerUnit: '100', units: 30),
      fromSupply: 12,
    );
  }

  void _addEstradiolPatch() {
    final changeDays = [_today.weekday, (_today.weekday + 3) % 7 + 1]..sort();
    final schedule = _schedule(
      'Estradiol patch',
      dose: '100',
      molecule: KnownMolecules.estradiol,
      route: AdministrationRoute.patch,
      dosingBasis: DosingBasis.releaseRate,
      scheduling:
          WeeklySchedule(daysOfWeek: changeDays, notificationTimes: [_morning]),
      startDate: _daysAgo(91),
    );

    // today and overdue
    final missed = _daysAgo(3);
    const sites = [_leftButtock, _rightButtock, _lowerBack];
    final taken = <MedicationIntake>[];
    for (var day = schedule.startDate;
        day.isBefore(_today);
        day = day.add(const Duration(days: 1))) {
      if (!changeDays.contains(day.weekday) || day == missed) continue;
      taken.add(_intake(
        schedule,
        _at(day, _morning, jitter: 60),
        placements: [sites[taken.length % sites.length]],
        notes: taken.length == 7 ? 'Patch fell off in the shower' : null,
      ));
    }

    _record(
      taken,
      supply: _medicationSupply(schedule,
          name: 'Estradiol patch 100 µg/day', dosePerUnit: '100', units: 8),
      fromSupply: 5,
    );
  }

  void _addMinoxidil() {
    final schedule = _schedule(
      'Minoxidil',
      dose: '2.5',
      molecule: KnownMolecules.minoxidil,
      route: AdministrationRoute.sublingual,
      scheduling: const DynamicIntervalSchedule(
          intervalDays: 2, notificationTimes: [_morning]),
      startDate: _daysAgo(150),
    );

    // overdue yesterday
    final days = <Date>[];
    for (var day = _daysAgo(3);
        !day.isBefore(schedule.startDate);
        day = day.subtract(Duration(days: _random.nextInt(6) == 0 ? 3 : 2))) {
      days.add(day);
    }

    _record(
      [
        for (final day in days.reversed)
          _intake(schedule, _at(day, _morning, jitter: 30)),
      ],
      supply: _medicationSupply(schedule,
          name: 'Minoxidil 2.5 mg', dosePerUnit: '2.5', units: 30),
      fromSupply: 20,
    );
  }

  void _addFinasteride() {
    // next intake tomorrow
    final schedule = _schedule(
      'Finasteride',
      dose: '1',
      molecule: KnownMolecules.finasteride,
      route: AdministrationRoute.oral,
      scheduling: const IntervalDaysSchedule(
          intervalDays: 3, notificationTimes: [_morning]),
      startDate: _daysAgo(200),
    );

    _record(
      [
        for (var day = schedule.startDate;
            !day.isAfter(_daysAgo(2));
            day = day.add(const Duration(days: 3)))
          _intake(schedule, _at(day, _morning, jitter: 30)),
      ],
      supply: _medicationSupply(schedule,
          name: 'Finasteride 1 mg', dosePerUnit: '1', units: 28),
      fromSupply: 26,
    );
  }

  void _addDecapeptyl() {
    final dayOfMonth = min(_today.day, 28);
    final dates = [
      for (var i = 0; i < 3; i++)
        Date(
            year: _today.year,
            month: _today.month - 8 + 3 * i,
            day: dayOfMonth),
    ];
    final schedule = _schedule(
      'Decapeptyl',
      dose: '11.25',
      molecule: KnownMolecules.decapeptyl,
      route: AdministrationRoute.injection,
      scheduling: MonthlySchedule(
        dayOfMonth: dayOfMonth,
        intervalMonths: 3,
        notificationTimes: const [_lateMorning],
      ),
      startDate: dates.first,
    );

    _record(
      [
        for (final (i, date) in dates.indexed)
          _intake(
            schedule,
            _at(date, _lateMorning, jitter: 20),
            injectionType: InjectionType.intramuscular,
            placements: [i.isEven ? _leftButtock : _rightButtock],
            genericSupplyItemIds: [
              _syringes.id,
              _imNeedles.id,
              _wipes.id,
              _bandages.id,
            ],
            notes: i == 0 ? 'First Decapeptyl injection' : null,
          ),
      ],
      supply: _medicationSupply(schedule,
          name: 'Decapeptyl 11.25 mg kit', dosePerUnit: '5.625', units: 2),
      fromSupply: 0,
    );
  }

  void _addEstradiolGel() {
    final schedule = _schedule(
      'Estradiol gel',
      dose: '1.5',
      molecule: KnownMolecules.estradiol,
      route: AdministrationRoute.gel,
      scheduling: const AsNeededSchedule(),
      startDate: _daysAgo(60),
    );

    final daysAgo = (List.generate(59, (i) => i + 1)..shuffle(_random))
        .take(10)
        .toList()
      ..sort((a, b) => b.compareTo(a));
    final taken = [
      for (final (i, days) in daysAgo.indexed)
        _intake(
          schedule,
          _at(_daysAgo(days), _morning, jitter: 60),
          notes: i == 4 ? 'Extra dose before a trip' : null,
        ),
    ];

    _record(
      taken,
      supply: _medicationSupply(
        schedule,
        name: 'Estradiol gel 0.06%',
        dosePerUnit: '0.75',
        units: 64,
        deliveryForm: DeliveryForm.pump,
      ),
      fromSupply: taken.length,
    );
  }

  void _addBloodTests(List<MedicationIntake> injections) {
    final origin = injections.first.takenDateTime!;
    final graphIntakes = [
      for (final intake in injections)
        GraphIntake(
          dose: intake.takenDose.toDouble(),
          ester: intake.ester!,
          time: timeDifferenceInDays(intake.takenDateTime!, origin),
        ),
    ];

    const plan = [
      (
        day: -7,
        testosterone: 512,
        pmol: false,
        nmol: false,
        notes: 'Baseline before HRT'
      ),
      (
        day: 34,
        testosterone: 214,
        pmol: false,
        nmol: false,
        notes: 'First check after starting'
      ),
      (day: 87, testosterone: 96, pmol: true, nmol: false, notes: null),
      (day: 136, testosterone: 41, pmol: false, nmol: true, notes: null),
      (
        day: 185,
        testosterone: null,
        pmol: true,
        nmol: false,
        notes: 'Estradiol only this time'
      ),
      (day: 227, testosterone: 28, pmol: false, nmol: true, notes: null),
      (
        day: 257,
        testosterone: 22,
        pmol: false,
        nmol: false,
        notes: 'Levels look stable'
      ),
    ];

    for (final (:day, :testosterone, :pmol, :nmol, :notes) in plan) {
      final dateTime = _at(_hrtStart.add(Duration(days: day)),
          const TimeOfDay(hour: 8, minute: 30),
          jitter: 15);
      final predicted = GraphCalculator().totalConcentrationAtTime(
        timeDifferenceInDays(dateTime, origin),
        graphIntakes,
        EstradiolUnit.pg_mL,
      );
      final estradiol = Decimal.parse(max(
        predicted * (0.85 + 0.3 * _random.nextDouble()),
        18 + 10 * _random.nextDouble(),
      ).toStringAsFixed(0));

      bloodTests.add(BloodTest(
        id: _id(),
        dateTime: dateTime,
        timeZone: _timeZone,
        estradiolLevels: pmol
            ? UnitValue(
                EstradiolUnit.pg_mL
                    .convert(estradiol, EstradiolUnit.pmol_L)
                    .round(),
                EstradiolUnit.pmol_L)
            : UnitValue(estradiol, EstradiolUnit.pg_mL),
        testosteroneLevels: testosterone == null
            ? null
            : nmol
                ? UnitValue(
                    TestosteroneUnit.ng_dL.convert(
                        Decimal.fromInt(testosterone), TestosteroneUnit.nmol_L),
                    TestosteroneUnit.nmol_L)
                : UnitValue(
                    Decimal.fromInt(testosterone), TestosteroneUnit.ng_dL),
        notes: notes,
      ));
    }
  }

  List<MedicationIntake> _daily(
    MedicationSchedule schedule, {
    double skipChance = 0.03,
    Decimal? Function(Date day)? doseOn,
  }) {
    final times = (schedule.scheduling as DailySchedule).intakeTimes;
    final taken = <MedicationIntake>[];
    for (var day = schedule.startDate;
        !day.isAfter(_today);
        day = day.add(const Duration(days: 1))) {
      for (final time in times) {
        final pending = day == _today &&
            day.toDateTimeAt(time).add(const Duration(hours: 1)).isAfter(_now);
        final skipped = day != _today && _random.nextDouble() < skipChance;
        if (pending || skipped) continue;
        taken.add(_intake(
          schedule,
          _at(day, time, jitter: 20),
          scheduledTime: time,
          dose: doseOn?.call(day),
        ));
      }
    }
    return taken;
  }

  void _record(
    List<MedicationIntake> taken, {
    required MedicationSupplyItem supply,
    required int fromSupply,
  }) {
    var used = Decimal.zero;
    for (var i = max(0, taken.length - fromSupply); i < taken.length; i++) {
      final intake = taken[i].copyWith(medicationSupplyItemId: supply.id);
      taken[i] = intake;
      used += intake.takenDose +
          supply.getDose(intake.wastedAmount ?? Decimal.zero) +
          supply.getDose(
              (intake.deadSpace ?? Decimal.zero) * microlitersToMilliliters);
    }

    supplyItems.add(supply.copyWith(
        usedDose: used > supply.totalDose ? supply.totalDose : used));
    intakes.addAll(taken);
  }

  MedicationSchedule _schedule(
    String name, {
    required String dose,
    required Molecule molecule,
    required AdministrationRoute route,
    Ester? ester,
    DosingBasis dosingBasis = DosingBasis.mass,
    required SchedulingStrategy scheduling,
    required Date startDate,
  }) {
    final schedule = MedicationSchedule(
      id: _id(),
      name: name,
      dose: Decimal.parse(dose),
      scheduling: scheduling,
      startDate: startDate,
      molecule: molecule,
      administrationRoute: route,
      ester: ester,
      dosingBasis: dosingBasis,
    );
    schedules.add(schedule);
    return schedule;
  }

  MedicationIntake _intake(
    MedicationSchedule schedule,
    DateTime takenDateTime, {
    bool linkSchedule = true,
    Decimal? dose,
    TimeOfDay? scheduledTime,
    InjectionType? injectionType,
    List<Placement> placements = const [],
    List<int> genericSupplyItemIds = const [],
    Decimal? deadSpace,
    Decimal? wastedAmount,
    String? notes,
  }) =>
      MedicationIntake(
        id: _id(),
        scheduledTime: scheduledTime,
        takenDose: dose ?? schedule.dose,
        takenDateTime: takenDateTime,
        takenTimeZone: _timeZone,
        scheduleId: linkSchedule ? schedule.id : null,
        molecule: schedule.molecule,
        administrationRoute: schedule.administrationRoute,
        ester: schedule.ester,
        dosingBasis: schedule.dosingBasis,
        injectionType: injectionType,
        placements: placements,
        genericSupplyItemIds: genericSupplyItemIds,
        deadSpace: deadSpace,
        wastedAmount: wastedAmount,
        notes: notes,
      );

  MedicationSupplyItem _medicationSupply(
    MedicationSchedule schedule, {
    required String name,
    required String dosePerUnit,
    required int units,
    DeliveryForm? deliveryForm,
  }) {
    final perUnit = Decimal.parse(dosePerUnit);
    return MedicationSupplyItem(
      id: _id(),
      name: name,
      totalDose: perUnit * Decimal.fromInt(units),
      dosePerUnit: perUnit,
      molecule: schedule.molecule,
      administrationRoute: schedule.administrationRoute,
      ester: schedule.ester,
      deliveryForm: deliveryForm,
      dosingBasis: schedule.dosingBasis,
    );
  }

  GenericSupply _generic(String name, GenericSupplyType type, int amount) {
    final item = GenericSupply(
        id: _id(), name: name, amount: amount, genericSupplyType: type);
    supplyItems.add(item);
    return item;
  }

  DateTime _at(Date day, TimeOfDay time, {required int jitter}) => day
      .toDateTimeAt(time)
      .add(Duration(minutes: _random.nextInt(2 * jitter + 1) - jitter))
      .toUtc();

  Date _daysAgo(int days) => _today.subtract(Duration(days: days));

  int _id() => _nextId++;
}
