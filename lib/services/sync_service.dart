import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mona/services/crypto_service.dart';
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

  http.Client get _httpClient {
    if (_prefs.allowInsecureSync) {
      final inner = HttpClient()
        ..badCertificateCallback = (cert, host, port) => true;
      return IOClient(inner);
    }
    return http.Client();
  }

  bool get isConfigured =>
      _prefs.syncUrl != null &&
      _prefs.syncPassword != null &&
      _prefs.syncEncryptionPassphrase != null;

  String? get _token => _prefs.syncToken;

  Future<bool> login() async {
    final url = _prefs.syncUrl;
    final password = _prefs.syncPassword;

    if (url == null || password == null) return false;

    final client = _httpClient;
    try {
      final response = await client.post(
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
    } finally {
      client.close();
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

      final encryptionKey = await CryptoService.deriveKey(
        _prefs.syncEncryptionPassphrase!,
        _prefs.syncUrl!,
      );

      final collections = [
        'supply_items',
        'medication_schedules',
        'medication_intakes',
        'blood_tests',
      ];

      final lastSync = _prefs.lastSyncTime;
      final newSyncTime = DateTime.now().millisecondsSinceEpoch;

      for (final collection in collections) {
        await _syncCollection(collection, lastSync, encryptionKey);
      }

      await _syncVault(encryptionKey);

      await _prefs.setLastSyncTime(newSyncTime);
      _syncFinishedController.add(null);
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  Future<void> _syncCollection(
      String collection, int lastSync, SecretKey encryptionKey) async {
    final url = _prefs.syncUrl!;
    final client = _httpClient;

    // 1. Pull changes
    try {
      final response = await client.get(
        Uri.parse('$url/api/sync/$collection?last_sync=$lastSync'),
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> remoteItemsJson = jsonDecode(response.body);
        final remoteItems = remoteItemsJson.map((j) {
          final item = SyncItem.fromJson(j);
          return item;
        }).toList();

        // Decrypt remote items
        final decryptedItems = <SyncItem>[];
        for (final item in remoteItems) {
          final decryptedPayload =
              await CryptoService.decrypt(item.payload, encryptionKey);
          decryptedItems.add(SyncItem(
            id: item.id,
            collection: item.collection,
            payload: decryptedPayload,
            updatedAt: item.updatedAt,
            isDeleted: item.isDeleted,
          ));
        }

        await _applyRemoteChanges(collection, decryptedItems);
      } else if (response.statusCode == 401) {
        if (await login()) {
          return _syncCollection(collection, lastSync, encryptionKey);
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
        final itemsToPush = <SyncItem>[];
        for (final row in localChanges) {
          final Map<String, dynamic> payloadMap = Map.from(row);
          final id = payloadMap.remove('id') as String;
          final updatedAt = payloadMap.remove('updatedAt') as int;
          final isDeleted = (payloadMap.remove('isDeleted') as int) == 1;

          final plaintextPayload = jsonEncode(payloadMap);
          final encryptedPayload =
              await CryptoService.encrypt(plaintextPayload, encryptionKey);

          itemsToPush.add(SyncItem(
            id: id,
            collection: collection,
            payload: encryptedPayload,
            updatedAt: updatedAt,
            isDeleted: isDeleted,
          ));
        }

        final response = await client.post(
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
    } finally {
      client.close();
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

  Future<void> _syncVault(SecretKey encryptionKey) async {
    final url = _prefs.syncUrl!;
    final client = _httpClient;
    try {
      // 1. Pull vault
      final response = await client.get(
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
            final decryptedPayload = await CryptoService.decrypt(
                data['payload'] as String, encryptionKey);
            final vaultData = jsonDecode(decryptedPayload);
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

      final plaintextVault = jsonEncode(vaultData);
      final encryptedVault =
          await CryptoService.encrypt(plaintextVault, encryptionKey);

      await client.post(
        Uri.parse('$url/api/sync/vault'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          'payload': encryptedVault,
          'updatedAt': DateTime.now().millisecondsSinceEpoch,
        }),
      );
    } catch (e) {
      debugPrint('Vault sync failed: $e');
    } finally {
      client.close();
    }
  }

  @override
  void dispose() {
    _syncFinishedController.close();
    super.dispose();
  }
}
