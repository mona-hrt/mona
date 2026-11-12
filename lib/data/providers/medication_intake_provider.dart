// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Alice Lorido "yakissa" <alice@lori.do>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/calculator/hormone_simulation.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/services/repository.dart';

class MedicationIntakeProvider extends ChangeNotifier {
  List<MedicationIntake> _intakes = [];
  List<MedicationIntake> _takenIntakesSortedDesc = [];
  bool _isLoading = true;
  final Repository<MedicationIntake> repository;

  MedicationIntakeProvider({Repository<MedicationIntake>? repository})
      : repository = repository ?? _medicationIntakeRepository {
    _init();
  }

  bool get isLoading => _isLoading;

  List<MedicationIntake> get intakes => _intakes;

  List<MedicationIntake> get takenIntakesSortedDesc => _takenIntakesSortedDesc;

  Date? get firstTakenLocalDate => _takenIntakesSortedDesc.isEmpty
      ? null
      : _takenIntakesSortedDesc.last.takenLocalDate;

  List<MedicationIntake> get takenIntakes =>
      _intakes.where((intake) => intake.isTaken).toList();

  List<MedicationIntake> get notTakenIntakes =>
      _intakes.where((intake) => !intake.isTaken).toList();

  List<MedicationIntake> get plottableIntakes =>
      _intakes.where(isSimulated).toList();

  Future<void> _init() async {
    _intakes = await repository.getAll();
    _updateTakenSorted();
    _isLoading = false;
    notifyListeners();
  }

  void _updateTakenSorted() {
    _takenIntakesSortedDesc = List<MedicationIntake>.from(takenIntakes)
      ..sort((a, b) => b.takenDateTime!.compareTo(a.takenDateTime!));
  }

  List<MedicationIntake> getTakenIntakesDescForSchedule(int scheduleId) =>
      takenIntakesSortedDesc
          .where((intake) => intake.scheduleId == scheduleId)
          .toList();

  Future<void> fetchIntakes() async {
    _intakes = await repository.getAll();
    _updateTakenSorted();
    notifyListeners();
  }

  Future<void> deleteIntakeFromId(int id) async {
    await repository.delete(id);
    await fetchIntakes();
  }

  Future<void> deleteIntake(MedicationIntake intake) async {
    await repository.delete(intake.id);
    await fetchIntakes();
  }

  Future<void> add(MedicationIntake intake) async {
    await repository.insert(intake);
    await fetchIntakes();
  }

  Future<void> updateIntake(MedicationIntake intake) async {
    await repository.update(intake, intake.id);
    await fetchIntakes();
  }

  Date? getLastIntakeLocalDateFromList(List<MedicationIntake> intakes) {
    if (intakes.isEmpty) return null;

    return intakes
        .reduce((a, b) => a.takenDateTime!.isAfter(b.takenDateTime!) ? a : b)
        .takenLocalDate;
  }

  Date? getLastIntakeLocalDateForSchedule(int scheduleId) {
    final scheduleIntakes = getTakenIntakesDescForSchedule(scheduleId);
    return getLastIntakeLocalDateFromList(scheduleIntakes);
  }

  List<MedicationIntake> getTakenIntakesForScheduleOn(
      int scheduleId, Date date) {
    return getTakenIntakesDescForSchedule(scheduleId)
        .where((intake) => intake.takenLocalDate == date)
        .toList();
  }

  MedicationIntake? getLastTakenIntakeForSchedule(int scheduleId) {
    final scheduleIntakes = getTakenIntakesDescForSchedule(scheduleId);
    if (scheduleIntakes.isEmpty) return null;
    return scheduleIntakes
        .reduce((a, b) => a.takenDateTime!.isAfter(b.takenDateTime!) ? a : b);
  }

  MedicationIntake? getLastTakenIntake() {
    if (takenIntakes.isEmpty) return null;
    return takenIntakes
        .reduce((a, b) => a.takenDateTime!.isAfter(b.takenDateTime!) ? a : b);
  }

  MedicationIntake? getLastTakenInjectionIntake() {
    final injectionIntakes = takenIntakes
        .where((intake) =>
            intake.administrationRoute == AdministrationRoute.injection)
        .toList();
    if (injectionIntakes.isEmpty) return null;
    return injectionIntakes
        .reduce((a, b) => a.takenDateTime!.isAfter(b.takenDateTime!) ? a : b);
  }

  static final _medicationIntakeRepository = Repository<MedicationIntake>(
    tableName: 'medication_intakes',
    toMap: (MedicationIntake intake) => intake.toMap(),
    fromMap: (map) =>
        MedicationIntakeMapper.fromMap(Map<String, dynamic>.from(map)),
  );
}
