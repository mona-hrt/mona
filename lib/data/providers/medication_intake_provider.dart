import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/services/repository.dart';
import 'package:mona/services/sync_service.dart';

class GraphIntake {
  final double dose;
  final Ester ester;

  GraphIntake(this.dose, this.ester);
}

class MedicationIntakeProvider extends ChangeNotifier {
  List<MedicationIntake> _intakes = [];
  List<MedicationIntake> _takenIntakesSortedDesc = [];
  bool _isLoading = true;
  final Repository<MedicationIntake> repository;

  MedicationIntakeProvider(
      {Repository<MedicationIntake>? repository, SyncService? syncService})
      : repository = repository ?? _medicationIntakeRepository {
    _init();
    syncService?.onSyncFinished.listen((_) => fetchIntakes());
  }

  bool get isLoading => _isLoading;

  List<MedicationIntake> get intakes => _intakes;

  List<MedicationIntake> get takenIntakesSortedDesc => _takenIntakesSortedDesc;

  List<MedicationIntake> get takenIntakes =>
      _intakes.where((intake) => intake.isTaken).toList();

  List<MedicationIntake> get notTakenIntakes =>
      _intakes.where((intake) => !intake.isTaken).toList();

  List<MedicationIntake> get graphIntakes => takenIntakes
      .where((intake) =>
          intake.molecule == KnownMolecules.estradiol &&
          intake.administrationRoute == AdministrationRoute.injection &&
          intake.ester != null)
      .toList();

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

  List<MedicationIntake> getTakenIntakesForSchedule(String scheduleId) =>
      takenIntakes.where((intake) => intake.scheduleId == scheduleId).toList();

  Future<void> fetchIntakes() async {
    _intakes = await repository.getAll();
    _updateTakenSorted();
    notifyListeners();
  }

  Future<void> deleteIntakeFromId(String id) async {
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

  Map<int, GraphIntake> getDaysAndIntakes() {
    if (graphIntakes.isEmpty) return {};

    final startDate = getFirstGraphIntakeLocalDate()!;
    return Map.fromEntries(
      graphIntakes.map(
        (intake) => MapEntry(
          intake.takenLocalDate!.differenceInDays(startDate),
          GraphIntake(intake.dose.toDouble(), intake.ester!),
        ),
      ),
    );
  }

  Date? getFirstGraphIntakeLocalDate() {
    if (graphIntakes.isEmpty) return null;

    return graphIntakes
        .reduce((a, b) => a.takenDateTime!.isBefore(b.takenDateTime!) ? a : b)
        .takenLocalDate;
  }

  Date? getLastIntakeLocalDateFromList(List<MedicationIntake> intakes) {
    if (intakes.isEmpty) return null;

    return intakes
        .reduce((a, b) => a.takenDateTime!.isAfter(b.takenDateTime!) ? a : b)
        .takenLocalDate;
  }

  Date? getLastGraphIntakeDate() {
    return getLastIntakeLocalDateFromList(graphIntakes);
  }

  Date? getLastIntakeLocalDateForSchedule(String scheduleId) {
    final scheduleIntakes = getTakenIntakesForSchedule(scheduleId);
    return getLastIntakeLocalDateFromList(scheduleIntakes);
  }

  MedicationIntake? getLastTakenIntake() {
    if (takenIntakes.isEmpty) return null;
    return takenIntakes
        .reduce((a, b) => a.takenDateTime!.isAfter(b.takenDateTime!) ? a : b);
  }

  static final _medicationIntakeRepository = Repository<MedicationIntake>(
    tableName: 'medication_intakes',
    toMap: (MedicationIntake intake) => intake.toMap(),
    fromMap: (map) =>
        MedicationIntakeMapper.fromMap(Map<String, dynamic>.from(map)),
  );
}
