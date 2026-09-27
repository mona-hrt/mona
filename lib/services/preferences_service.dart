import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/placement.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/theme/custom_theme_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier {
  static const _notificationsEnabledKey = 'notifications_enabled';
  static const _customMoleculesKey = 'custom_molecules';
  static const _languageTagKey = 'language_tag';
  static const _unitsTagKey = "units"; // TODO: deprecated, remove in future
  static const _estradiolUnitKey = "estradiol_unit";
  static const _testosteroneUnitKey = "testosterone_unit";
  static const _autoCheckUpdatesKey = 'auto_check_updates';
  static const _placementsListKey = 'placements_list';
  static const _scheduleOrderKey = 'schedule_order';
  static const _placementSuggestionPerScheduleKey =
      'placement_suggestion_per_schedule';
  static const _hrtCounterEnabledKey = 'intake_counter_enabled';
  static const _logicalDayStartMinutesKey = 'logical_day_start_minutes';
  static const _slimeModeEnabledKey = 'slime_mode_enabled';

  static const bool defaultNotificationsEnabled = false;
  static const bool defaultAutoCheckUpdates = false;
  static const bool defaultHrtCounterEnabled = true;
  static const int defaultLogicalDayStartMinutes = 240;
  static const bool defaultSlimeModeEnabled = false;
  static const List<Placement> defaultPlacementsList = [
    PresetPlacement(PlacementPreset.left),
    PresetPlacement(PlacementPreset.right),
  ];
  static const bool defaultPlacementSuggestionPerSchedule = false;

  static const _customThemeEnabledKey = 'custom_theme_enabled';
  static const _customThemeSettingsKey = 'custom_theme_settings';
  static const bool defaultCustomThemeEnabled = false;

  late final SharedPreferences _prefs;

  PreferencesService._(this._prefs);

  bool get customThemeEnabled =>
      _prefs.getBool(_customThemeEnabledKey) ?? defaultCustomThemeEnabled;

  Future<void> setCustomThemeEnabled(bool isEnabled) async {
    await _prefs.setBool(_customThemeEnabledKey, isEnabled);
    notifyListeners();
  }

  CustomThemeSettings get customTheme {
    final jsonString = _prefs.getString(_customThemeSettingsKey);
    if (jsonString == null || jsonString.isEmpty) {
      return const CustomThemeSettings();
    }
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is! Map<String, dynamic>) {
        return const CustomThemeSettings();
      }
      return CustomThemeSettings.fromJson(decoded);
    } catch (_) {
      return const CustomThemeSettings();
    }
  }

  Future<void> setCustomTheme(CustomThemeSettings value) async {
    await _prefs.setString(
      _customThemeSettingsKey,
      jsonEncode(value.toJson()),
    );
    notifyListeners();
  }

  bool get autoCheckUpdatesEnabled =>
      _prefs.getBool(_autoCheckUpdatesKey) ?? defaultAutoCheckUpdates;

  Future<void> setAutoCheckUpdatesEnabled(bool isEnabled) async {
    await _prefs.setBool(_autoCheckUpdatesKey, isEnabled);
    notifyListeners();
  }

  bool get notificationsEnabled =>
      _prefs.getBool(_notificationsEnabledKey) ?? defaultNotificationsEnabled;

  String? get savedLanguageTag {
    final tag = _prefs.getString(_languageTagKey);
    if (tag == null || tag.isEmpty) return null;
    return tag;
  }

  Future<void> setNotificationsEnabled(bool isEnabled) async {
    await _prefs.setBool(_notificationsEnabledKey, isEnabled);
    notifyListeners();
  }

  Future<void> setSavedLanguageTag(String? code) async {
    if (code == null || code.isEmpty) {
      await _prefs.remove(_languageTagKey);
    } else {
      await _prefs.setString(_languageTagKey, code);
    }
    notifyListeners();
  }

  Units get units => Units.values[_prefs.getInt(_unitsTagKey) ?? 0];

  // hormone-specific getters
  EstradiolUnit get estradiolUnit => EstradiolUnit
      .values[_prefs.getInt(_estradiolUnitKey) ?? units.estradiol.index];
  TestosteroneUnit get testosteroneUnit => TestosteroneUnit
      .values[_prefs.getInt(_testosteroneUnitKey) ?? units.testosterone.index];

  Future<void> setEstradiolUnit(EstradiolUnit unit) async {
    await _prefs.setInt(_estradiolUnitKey, unit.index);
    notifyListeners();
  }

  Future<void> setTestosteroneUnit(TestosteroneUnit unit) async {
    await _prefs.setInt(_testosteroneUnitKey, unit.index);
    notifyListeners();
  }

  List<Molecule> get customMolecules {
    final jsonString = _prefs.getString(_customMoleculesKey);
    if (jsonString == null) return [];

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((e) => MoleculeMapper.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  List<Molecule> get allMolecules {
    const builtIn = KnownMolecules.all;
    final custom = customMolecules;
    final Map<String, Molecule> map = {};

    for (final m in [...builtIn, ...custom]) {
      map[m.normalizedName] = m; // remove duplicates
    }

    return map.values.toList();
  }

  Future<void> addCustomMolecule(Molecule molecule) async {
    final existing = customMolecules;

    if (allMolecules.any((m) => m.normalizedName == molecule.normalizedName)) {
      return;
    }

    final updated = [...existing, molecule];
    final jsonString = jsonEncode(updated.map((m) => m.toMap()).toList());

    await _prefs.setString(_customMoleculesKey, jsonString);
    notifyListeners();
  }

  Future<void> removeCustomMolecule(String name) async {
    final updated = customMolecules
        .where((m) => m.normalizedName != name.trim().toLowerCase())
        .toList();

    final jsonString = jsonEncode(updated.map((m) => m.toMap()).toList());

    await _prefs.setString(_customMoleculesKey, jsonString);
    notifyListeners();
  }

  List<Placement> get placementsList {
    final jsonString = _prefs.getString(_placementsListKey);
    if (jsonString == null) return defaultPlacementsList;

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((e) => PlacementMapper.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> setPlacementsList(List<Placement> placements) async {
    final jsonString = jsonEncode(placements.map((p) => p.toMap()).toList());
    final write = _prefs.setString(_placementsListKey, jsonString);
    notifyListeners(); // before await to avoid ui showing old state
    await write;
  }

  List<int> get scheduleOrder {
    final jsonString = _prefs.getString(_scheduleOrderKey);
    if (jsonString == null) return [];

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.cast<int>();
  }

  Future<void> setScheduleOrder(List<int> order) async {
    final jsonString = jsonEncode(order);
    final write = _prefs.setString(_scheduleOrderKey, jsonString);
    notifyListeners(); // before await to avoid ui showing old state
    await write;
  }

  bool get placementSuggestionPerSchedule =>
      _prefs.getBool(_placementSuggestionPerScheduleKey) ??
      defaultPlacementSuggestionPerSchedule;

  Future<void> setPlacementSuggestionPerSchedule(bool isEnabled) async {
    await _prefs.setBool(_placementSuggestionPerScheduleKey, isEnabled);
    notifyListeners();
  }

  bool get hrtCounterEnabled =>
      _prefs.getBool(_hrtCounterEnabledKey) ?? defaultHrtCounterEnabled;

  Future<void> setHrtCounterEnabled(bool isEnabled) async {
    await _prefs.setBool(_hrtCounterEnabledKey, isEnabled);
    notifyListeners();
  }

  bool get slimeModeEnabled =>
      _prefs.getBool(_slimeModeEnabledKey) ?? defaultSlimeModeEnabled;

  Future<void> setSlimeModeEnabled(bool isEnabled) async {
    await _prefs.setBool(_slimeModeEnabledKey, isEnabled);
    notifyListeners();
  }

  int get logicalDayStartMinutesRaw =>
      _prefs.getInt(_logicalDayStartMinutesKey) ??
      defaultLogicalDayStartMinutes;

  TimeOfDay get logicalDayStart {
    final minutes = logicalDayStartMinutesRaw;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }

  Future<void> setLogicalDayStart(TimeOfDay time) async {
    final minutes = time.hour * 60 + time.minute;
    await _prefs.setInt(_logicalDayStartMinutesKey, minutes);
    logicalDayStartMinutes = minutes; // keep the Date global in sync
    notifyListeners();
  }

  static Future<PreferencesService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferencesService._(prefs);
  }
}
