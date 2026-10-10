// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileCopyrightText: 2026 Thomas "Seremptos"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV11 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await db
        .execute('ALTER TABLE medication_intakes ADD COLUMN wastedAmount TEXT');
  }
}
