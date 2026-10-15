// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV10 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await _addGenericSupplyType(db);
  }

  Future<void> _addGenericSupplyType(Database db) async {
    await db
        .execute('ALTER TABLE supply_items ADD COLUMN genericSupplyType TEXT');
  }
}
