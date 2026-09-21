import 'dart:convert';

import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV21 implements DbUpgrade {
  static const _tables = [
    'supply_items',
    'medication_intakes',
    'medication_schedules',
  ];

  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    for (final table in _tables) {
      final rows = await db.query(table, columns: ['id', 'molecule']);
      for (final row in rows) {
        final raw = row['molecule'] as String?;
        if (raw == null || raw.isEmpty) continue;

        final molecule = jsonDecode(raw) as Map<String, dynamic>;
        if (molecule.containsKey('massUnit')) continue;

        molecule['massUnit'] = molecule.remove('unit') ?? 'mg';
        final name = (molecule['name'] as String?)?.trim().toLowerCase();
        if (name == 'estradiol') {
          molecule['rateUnit'] = 'µg/day';
        }

        await db.update(
          table,
          {'molecule': jsonEncode(molecule)},
          where: 'id = ?',
          whereArgs: [row['id']],
        );
      }
    }
  }
}
