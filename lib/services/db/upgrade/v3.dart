// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Thomas "Seremptos"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV3 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute(
        "ALTER TABLE medication_schedules ADD COLUMN notificationTimes TEXT NOT NULL DEFAULT '[]'");
  }
}
