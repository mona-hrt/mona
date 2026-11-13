// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV24 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await _splitConsumableSupplyItems(db);
    await _renameGenericSupplyItemIds(db);
  }

  Future<void> _splitConsumableSupplyItems(Database db) async {
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
        otherSupplyType TEXT,
        deliveryForm TEXT,
        dosingBasis TEXT
      );
      ''');

    await db.execute('''
      INSERT INTO supply_items_new (
        id, type, name, totalDose, usedDose, dosePerUnit,
        molecule, administrationRoute, ester, amount, otherSupplyType,
        deliveryForm, dosingBasis
      )
      SELECT
        id,
        CASE
          WHEN type != 'generic' THEN type
          WHEN genericSupplyType IN ('syringe', 'needle') THEN genericSupplyType
          ELSE 'other'
        END,
        name, totalDose, usedDose, dosePerUnit,
        molecule, administrationRoute, ester, amount,
        CASE
          WHEN genericSupplyType IN ('syringe', 'needle') THEN NULL
          ELSE genericSupplyType
        END,
        deliveryForm, dosingBasis
      FROM supply_items
      ''');

    await db.execute('DROP TABLE supply_items');
    await db.execute('ALTER TABLE supply_items_new RENAME TO supply_items');
  }

  Future<void> _renameGenericSupplyItemIds(Database db) async {
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
        consumableSupplyItemIds TEXT NOT NULL,
        notes TEXT,
        placements TEXT NOT NULL,
        dosingBasis TEXT NOT NULL,
        injectionType TEXT,
        FOREIGN KEY (medicationSupplyItemId) REFERENCES supply_items(id) ON DELETE SET NULL,
        FOREIGN KEY (scheduleId) REFERENCES medication_schedules(id) ON DELETE SET NULL
      );
      ''');

    await db.execute('''
      INSERT INTO medication_intakes_new (
        id, scheduledTime, takenDateTime, takenTimeZone, takenDose,
        wastedAmount, deadSpace, scheduleId, molecule, administrationRoute,
        ester, medicationSupplyItemId, consumableSupplyItemIds, notes,
        placements, dosingBasis, injectionType
      )
      SELECT
        id, scheduledTime, takenDateTime, takenTimeZone, takenDose,
        wastedAmount, deadSpace, scheduleId, molecule, administrationRoute,
        ester, medicationSupplyItemId, genericSupplyItemIds, notes,
        placements, dosingBasis, injectionType
      FROM medication_intakes
      ''');

    await db.execute('DROP TABLE medication_intakes');
    await db.execute(
      'ALTER TABLE medication_intakes_new RENAME TO medication_intakes',
    );
  }
}
