// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Eva Tatarka <eva@tatarka.me>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV7 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await _addnotes(db);
    await _upgradeBloodTest(db);
  }

  Future<void> _addnotes(Database db) async {
    await db.execute('ALTER TABLE medication_intakes ADD COLUMN notes TEXT');
  }

  Future<void> _upgradeBloodTest(Database db) async {
    // add blood test units
    await db.execute('ALTER TABLE blood_tests ADD COLUMN estradiolUnit TEXT');
    await db
        .execute('ALTER TABLE blood_tests ADD COLUMN testosteroneUnit TEXT');
    // assume existing entries use pg/mL & ng/dL
    await db.execute(
        "UPDATE blood_tests SET estradiolUnit = 'pg/mL', testosteroneUnit = 'ng/dL'");
  }
}
