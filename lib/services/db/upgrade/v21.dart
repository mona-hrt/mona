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
    await _renameConcentrationToDosePerUnit(db);
    await _addRateUnitToMolecule(db);
  }

  Future<void> _renameConcentrationToDosePerUnit(Database db) async {
    await db.execute('''
      CREATE TABLE supply_items_new(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        name TEXT NOT NULL,
        totalDose TEXT,
        usedDose TEXT,
        dosePerUnit TEXT,
        molecule TEXT,
        administrationRoute TEXT,
        ester TEXT,
        amount INTEGER,
        genericSupplyType TEXT,
        deliveryForm TEXT
      );
      ''');

    await db.execute('''
      INSERT INTO supply_items_new (
        id, type, name, totalDose, usedDose, dosePerUnit,
        molecule, administrationRoute, ester, amount, genericSupplyType,
        deliveryForm
      )
      SELECT
        id, type, name, totalDose, usedDose, concentration,
        molecule, administrationRoute, ester, amount, genericSupplyType,
        deliveryForm
      FROM supply_items
      ''');

    await db.execute('DROP TABLE supply_items');
    await db.execute('ALTER TABLE supply_items_new RENAME TO supply_items');
  }

  Future<void> _addRateUnitToMolecule(Database db) async {
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
