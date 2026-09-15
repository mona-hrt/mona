import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV21 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    // create a NOT NULL column without a default value
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
        position INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      INSERT INTO medication_schedules_new (
        id, name, dose, startDate, molecule, administrationRoute, ester,
        scheduling, position
      )
      SELECT id, name, dose, startDate, molecule, administrationRoute, ester,
        scheduling, id
      FROM medication_schedules
    ''');
    await db.execute('DROP TABLE medication_schedules');
    await db.execute(
        'ALTER TABLE medication_schedules_new RENAME TO medication_schedules');
  }
}
