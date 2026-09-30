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
  }
}
