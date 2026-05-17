import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mona/services/db/app_database.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:sqflite/sqflite.dart';

class SyncItem {
  final String id;
  final String collection;
  final String payload;
  final int updatedAt;
  final bool isDeleted;

  SyncItem({
    required this.id,
    required this.collection,
    required this.payload,
    required this.updatedAt,
    required this.isDeleted,
  });

  factory SyncItem.fromJson(Map<String, dynamic> json) {
    return SyncItem(
      id: json['id'] as String,
      collection: json['collection'] as String,
      payload: json['payload'] as String,
      updatedAt: json['updatedAt'] as int,
      isDeleted: json['isDeleted'] is bool
          ? json['isDeleted'] as bool
          : (json['isDeleted'] as int) != 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collection': collection,
      'payload': payload,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
    };
  }
}

class SyncService extends ChangeNotifier {
  final PreferencesService _prefs;
  final AppDatabase _appDb;
  bool _isSyncing = false;
  final _syncFinishedController = StreamController<void>.broadcast();

  SyncService(this._prefs, this._appDb) {
    if (isConfigured) {
      sync();
    }
  }

  Stream<void> get onSyncFinished => _syncFinishedController.stream;

  bool get isSyncing => _isSyncing;

  bool get isConfigured =>
      _prefs.syncUrl != null && _prefs.syncPassword != null;

  String? get _token => _prefs.syncToken;

  Future<bool> login() async {
    final url = _prefs.syncUrl;
    final password = _prefs.syncPassword;

    if (url == null || password == null) return false;

    try {
      final response = await http.post(
        Uri.parse('$url/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _prefs.setSyncToken(data['token']);
        return true;
      }
    } catch (e) {
      debugPrint('Login failed: $e');
    }
    return false;
  }

  Future<void> sync() async {
    if (!isConfigured || _isSyncing) return;

    _isSyncing = true;
    notifyListeners();

    try {
      if (_token == null) {
        final success = await login();
        if (!success) throw Exception('Authentication failed');
      }

      final collections = [
        'supply_items',
        'medication_schedules',
        'medication_intakes',
        'blood_tests',
      ];

      final lastSync = _prefs.lastSyncTime;
      final newSyncTime = DateTime.now().millisecondsSinceEpoch;

      for (final collection in collections) {
        await _syncCollection(collection, lastSync);
      }

      await _syncVault();

      await _prefs.setLastSyncTime(newSyncTime);
      _syncFinishedController.add(null);
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  Future<void> _syncCollection(String collection, int lastSync) async {
    final url = _prefs.syncUrl!;

    // 1. Pull changes
    try {
      final response = await http.get(
        Uri.parse('$url/api/sync/$collection?last_sync=$lastSync'),
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> remoteItemsJson = jsonDecode(response.body);
        final remoteItems =
            remoteItemsJson.map((j) => SyncItem.fromJson(j)).toList();
        await _applyRemoteChanges(collection, remoteItems);
      } else if (response.statusCode == 401) {
        if (await login()) {
          return _syncCollection(collection, lastSync);
        }
        throw Exception('Unauthorized');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Pull failed for $collection: $e');
      rethrow;
    }

    // 2. Push local changes
    try {
      final db = await _appDb.database;
      final localChanges = await db.query(
        collection,
        where: 'updatedAt > ?',
        whereArgs: [lastSync],
      );

      if (localChanges.isNotEmpty) {
        final itemsToPush = localChanges.map((row) {
          final Map<String, dynamic> payloadMap = Map.from(row);
          final id = payloadMap.remove('id') as String;
          final updatedAt = payloadMap.remove('updatedAt') as int;
          final isDeleted = (payloadMap.remove('isDeleted') as int) == 1;

          return SyncItem(
            id: id,
            collection: collection,
            payload: jsonEncode(payloadMap),
            updatedAt: updatedAt,
            isDeleted: isDeleted,
          );
        }).toList();

        final response = await http.post(
          Uri.parse('$url/api/sync/$collection'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_token',
          },
          body: jsonEncode(itemsToPush.map((i) => i.toJson()).toList()),
        );

        if (response.statusCode != 200) {
          throw Exception('Push failed: ${response.statusCode}');
        }
      }
    } catch (e) {
      debugPrint('Push failed for $collection: $e');
      rethrow;
    }
  }

  Future<void> _applyRemoteChanges(
      String collection, List<SyncItem> remoteItems) async {
    final db = await _appDb.database;
    await db.transaction((txn) async {
      for (final item in remoteItems) {
        final local =
            await txn.query(collection, where: 'id = ?', whereArgs: [item.id]);
        if (local.isNotEmpty) {
          final localUpdatedAt = local.first['updatedAt'] as int;
          if (localUpdatedAt >= item.updatedAt) {
            continue;
          }
        }

        final Map<String, dynamic> payload = jsonDecode(item.payload);
        payload['id'] = item.id;
        payload['updatedAt'] = item.updatedAt;
        payload['isDeleted'] = item.isDeleted ? 1 : 0;

        await txn.insert(
          collection,
          payload,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<void> _syncVault() async {
    final url = _prefs.syncUrl!;
    try {
      // 1. Pull vault
      final response = await http.get(
        Uri.parse('$url/api/sync/vault'),
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          final remoteUpdatedAt = data['updatedAt'] as int;
          if (remoteUpdatedAt > _prefs.lastSyncTime) {
            final vaultData = jsonDecode(data['payload']);
            // Apply vault data to preferences (carefully)
            // This is simplified. Ideally we'd have a more robust way to sync preferences.
            if (vaultData['units'] != null) {
              // ... apply units
            }
          }
        }
      }

      // 2. Push local vault
      final vaultData = {
        'units': _prefs.units.index,
        'notificationsEnabled': _prefs.notificationsEnabled,
      };

      await http.post(
        Uri.parse('$url/api/sync/vault'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          'payload': jsonEncode(vaultData),
          'updatedAt': DateTime.now().millisecondsSinceEpoch,
        }),
      );
    } catch (e) {
      debugPrint('Vault sync failed: $e');
    }
  }

  @override
  void dispose() {
    _syncFinishedController.close();
    super.dispose();
  }
}
