// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:convert';
import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV23 implements DbUpgrade {
  static const _tables = [
    'medication_intakes',
    'medication_schedules',
    'supply_items',
    'blood_tests',
  ];

  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    for (final table in _tables) {
      await _repairLatin1DecodedText(db, table);
    }
  }

  Future<void> _repairLatin1DecodedText(Database db, String table) async {
    final rows = await db.query(table);

    for (final row in rows) {
      final fixes = <String, Object?>{};
      for (final entry in row.entries) {
        final value = entry.value;
        if (value is! String) continue;
        final repaired = _repairText(value);
        if (repaired != value) {
          fixes[entry.key] = repaired;
        }
      }
      if (fixes.isNotEmpty) {
        await db.update(table, fixes, where: 'id = ?', whereArgs: [row['id']]);
      }
    }
  }

  static String _repairText(String value) {
    var current = value;
    // loop to repair data re-imported multiple times
    while (true) {
      final decoded = _decodeLatin1AsUtf8(current);
      if (decoded == null || decoded == current) return current;
      current = decoded;
    }
  }

  static String? _decodeLatin1AsUtf8(String value) {
    if (value.codeUnits.any((unit) => unit > 0xFF)) return null;
    try {
      return utf8.decode(latin1.encode(value));
    } on FormatException {
      return null;
    }
  }
}
