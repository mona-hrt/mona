// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:mona/services/db/upgrade/db_upgrade.dart';

import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV22 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
      ALTER TABLE medication_intakes
      ADD COLUMN injectionType TEXT
    ''');

    await db.execute('''
      UPDATE medication_intakes
      SET injectionType = 'intramuscular'
      WHERE administrationRoute = 'injection'
    ''');

    await _repairDoubleWrappedLevels(db);
  }

  // repair v18 being ran on already-wrapped entries
  Future<void> _repairDoubleWrappedLevels(Database db) async {
    const columns = ['estradiolLevels', 'testosteroneLevels'];
    final rows = await db.query('blood_tests', columns: ['id', ...columns]);

    for (final row in rows) {
      final fixes = <String, Object?>{};
      for (final column in columns) {
        final value = row[column] as String?;
        final unwrapped = _unwrapLevel(value);
        if (unwrapped != value) {
          fixes[column] = unwrapped;
        }
      }
      if (fixes.isNotEmpty) {
        await db.update('blood_tests', fixes,
            where: 'id = ?', whereArgs: [row['id']]);
      }
    }
  }

  static String? _unwrapLevel(String? value) {
    if (value == null || !value.startsWith('{"value":"{')) return value;

    final innerStart = value.indexOf('{', 1);
    var depth = 0;
    for (var i = innerStart; i < value.length; i++) {
      final char = value[i];
      if (char == '{') {
        depth++;
      } else if (char == '}') {
        depth--;
        if (depth == 0) return value.substring(innerStart, i + 1);
      }
    }
    return value;
  }
}
