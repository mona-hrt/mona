import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV20 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('ALTER TABLE blood_tests ADD COLUMN notes TEXT');
  }
}
