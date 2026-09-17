import 'package:flutter/material.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/services/repository.dart';

class MedicationScheduleProvider extends ChangeNotifier {
  List<MedicationSchedule> _schedules = [];
  bool _isLoading = true;
  final Repository<MedicationSchedule> repository;
  final PreferencesService preferences;

  List<MedicationSchedule> get schedules => _schedules;
  bool get isLoading => _isLoading;

  MedicationSchedule? getScheduleById(int id) {
    try {
      return _schedules.firstWhere((schedule) => schedule.id == id);
    } catch (e) {
      return null;
    }
  }

  MedicationScheduleProvider({
    required this.preferences,
    Repository<MedicationSchedule>? repository,
  }) : repository = repository ?? _defaultRepository {
    _init();
  }

  Future<void> _init() async {
    _schedules = _sortByPreferredOrder(await repository.getAll());
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSchedules() async {
    _schedules = _sortByPreferredOrder(await repository.getAll());
    notifyListeners();
  }

  List<MedicationSchedule> _sortByPreferredOrder(
    List<MedicationSchedule> schedules,
  ) {
    final order = preferences.scheduleOrder;
    final indexById = {for (var i = 0; i < order.length; i++) order[i]: i};
    return [...schedules]..sort((a, b) {
        final ai = indexById[a.id];
        final bi = indexById[b.id];
        if (ai != null && bi != null) return ai.compareTo(bi);
        if (ai != null) return -1;
        if (bi != null) return 1;
        return a.id.compareTo(b.id); // fallback to id order
      });
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex -= 1;
    final moved = _schedules.removeAt(oldIndex);
    _schedules.insert(newIndex, moved);
    notifyListeners(); // before await to avoid ui showing old state
    await preferences.setScheduleOrder(_schedules.map((s) => s.id).toList());
  }

  Future<void> deleteScheduleFromId(int id) async {
    await repository.delete(id);
    await fetchSchedules();
  }

  Future<void> deleteSchedule(MedicationSchedule schedule) async {
    await repository.delete(schedule.id);
    await fetchSchedules();
  }

  Future<void> add(MedicationSchedule schedule) async {
    await repository.insert(schedule);
    await fetchSchedules();
  }

  Future<void> updateSchedule(MedicationSchedule schedule) async {
    await repository.update(schedule, schedule.id);
    await fetchSchedules();
  }

  static final _defaultRepository = Repository<MedicationSchedule>(
    tableName: 'medication_schedules',
    toMap: (MedicationSchedule schedule) => schedule.toMap(),
    fromMap: (map) =>
        MedicationScheduleMapper.fromMap(Map<String, dynamic>.from(map)),
  );
}
