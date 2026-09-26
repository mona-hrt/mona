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
    await _addDosingBasisToSchedulesAndIntakes(db);
    await _addRateUnitToMolecule(db);
  }

  Future<void> _addDosingBasisToSchedulesAndIntakes(Database db) async {
    await db.execute('''
      CREATE TABLE medication_schedules_new(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        dose TEXT NOT NULL,
        startDate TEXT NOT NULL,
        molecule TEXT NOT NULL,
        administrationRoute TEXT NOT NULL,
        ester TEXT,
        scheduling TEXT NOT NULL,
        dosingBasis TEXT NOT NULL
      );
      ''');

    await db.execute('''
      INSERT INTO medication_schedules_new (
        id, name, dose, startDate, molecule, administrationRoute, ester,
        scheduling, dosingBasis
      )
      SELECT
        id, name, dose, startDate, molecule, administrationRoute, ester,
        scheduling, 'mass'
      FROM medication_schedules
      ''');

    await db.execute('DROP TABLE medication_schedules');
    await db.execute(
      'ALTER TABLE medication_schedules_new RENAME TO medication_schedules',
    );

    await db.execute('''
      CREATE TABLE medication_intakes_new(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        scheduledTime TEXT,
        takenDateTime TEXT,
        takenTimeZone TEXT,
        takenDose TEXT NOT NULL,
        wastedAmount TEXT,
        deadSpace TEXT,
        scheduleId INTEGER,
        molecule TEXT NOT NULL,
        administrationRoute TEXT NOT NULL,
        ester TEXT,
        medicationSupplyItemId INTEGER,
        genericSupplyItemIds TEXT NOT NULL,
        notes TEXT,
        placements TEXT NOT NULL,
        dosingBasis TEXT NOT NULL,
        FOREIGN KEY (medicationSupplyItemId) REFERENCES supply_items(id) ON DELETE SET NULL,
        FOREIGN KEY (scheduleId) REFERENCES medication_schedules(id) ON DELETE SET NULL
      );
      ''');

    await db.execute('''
      INSERT INTO medication_intakes_new (
        id, scheduledTime, takenDateTime, takenTimeZone, takenDose,
        wastedAmount, deadSpace, scheduleId, molecule, administrationRoute,
        ester, medicationSupplyItemId, genericSupplyItemIds, notes, placements,
        dosingBasis
      )
      SELECT
        id, scheduledTime, takenDateTime, takenTimeZone, takenDose,
        wastedAmount, deadSpace, scheduleId, molecule, administrationRoute,
        ester, medicationSupplyItemId, genericSupplyItemIds, notes, placements,
        'mass'
      FROM medication_intakes
      ''');

    await db.execute('DROP TABLE medication_intakes');
    await db.execute(
      'ALTER TABLE medication_intakes_new RENAME TO medication_intakes',
    );
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
        deliveryForm TEXT,
        dosingBasis TEXT
      );
      ''');

    await db.execute('''
      INSERT INTO supply_items_new (
        id, type, name, totalDose, usedDose, dosePerUnit,
        molecule, administrationRoute, ester, amount, genericSupplyType,
        deliveryForm, dosingBasis
      )
      SELECT
        id, type, name, totalDose, usedDose, concentration,
        molecule, administrationRoute, ester, amount, genericSupplyType,
        deliveryForm, 'mass'
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
