import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/units.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier {
  static const _notificationsEnabledKey = 'notifications_enabled';
  static const _customMoleculesKey = 'custom_molecules';
  static const _languageTagKey = 'language_tag';
  static const _unitsTagKey = "units";

  static const _syncUrlKey = 'sync_url';
  static const _syncPasswordKey = 'sync_password';
  static const _syncTokenKey = 'sync_token';
  static const _lastSyncTimeKey = 'last_sync_time';
  static const _allowInsecureSyncKey = 'allow_insecure_sync';
  static const _syncEncryptionPassphraseKey = 'sync_encryption_passphrase';

  static const bool defaultNotificationsEnabled = false;

  static const _autoCheckUpdatesKey = 'auto_check_updates';
  static const bool defaultAutoCheckUpdates = false;

  late final SharedPreferences _prefs;

  PreferencesService._(this._prefs);

  String? get syncUrl => _prefs.getString(_syncUrlKey);
  Future<void> setSyncUrl(String? url) async {
    if (url == null) {
      await _prefs.remove(_syncUrlKey);
    } else {
      await _prefs.setString(_syncUrlKey, url);
    }
    notifyListeners();
  }

  String? get syncPassword => _prefs.getString(_syncPasswordKey);
  Future<void> setSyncPassword(String? password) async {
    if (password == null) {
      await _prefs.remove(_syncPasswordKey);
    } else {
      await _prefs.setString(_syncPasswordKey, password);
    }
    notifyListeners();
  }

  String? get syncToken => _prefs.getString(_syncTokenKey);
  Future<void> setSyncToken(String? token) async {
    if (token == null) {
      await _prefs.remove(_syncTokenKey);
    } else {
      await _prefs.setString(_syncTokenKey, token);
    }
    notifyListeners();
  }

  int get lastSyncTime => _prefs.getInt(_lastSyncTimeKey) ?? 0;
  Future<void> setLastSyncTime(int time) async {
    await _prefs.setInt(_lastSyncTimeKey, time);
    notifyListeners();
  }

  bool get allowInsecureSync => _prefs.getBool(_allowInsecureSyncKey) ?? false;
  Future<void> setAllowInsecureSync(bool value) async {
    await _prefs.setBool(_allowInsecureSyncKey, value);
    notifyListeners();
  }

  String? get syncEncryptionPassphrase =>
      _prefs.getString(_syncEncryptionPassphraseKey);
  Future<void> setSyncEncryptionPassphrase(String? passphrase) async {
    if (passphrase == null) {
      await _prefs.remove(_syncEncryptionPassphraseKey);
    } else {
      await _prefs.setString(_syncEncryptionPassphraseKey, passphrase);
    }
    notifyListeners();
  }

  Future<void> clearSyncSettings() async {
    await _prefs.remove(_syncUrlKey);
    await _prefs.remove(_syncPasswordKey);
    await _prefs.remove(_syncTokenKey);
    await _prefs.remove(_lastSyncTimeKey);
    await _prefs.remove(_allowInsecureSyncKey);
    await _prefs.remove(_syncEncryptionPassphraseKey);
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

  Future<void> setUnits(Units units) async {
    await _prefs.setInt(_unitsTagKey, units.index);
    notifyListeners();
  }

  List<Molecule> get customMolecules {
    final jsonString = _prefs.getString(_customMoleculesKey);
    if (jsonString == null) return [];

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((e) => Molecule.fromJson(Map<String, dynamic>.from(e)))
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
    final jsonString = jsonEncode(updated.map((m) => m.toJson()).toList());

    await _prefs.setString(_customMoleculesKey, jsonString);
    notifyListeners();
  }

  Future<void> removeCustomMolecule(String name) async {
    final updated = customMolecules
        .where((m) => m.normalizedName != name.trim().toLowerCase())
        .toList();

    final jsonString = jsonEncode(updated.map((m) => m.toJson()).toList());

    await _prefs.setString(_customMoleculesKey, jsonString);
    notifyListeners();
  }

  static Future<PreferencesService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferencesService._(prefs);
  }
}
