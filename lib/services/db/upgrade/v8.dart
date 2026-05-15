import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV8 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await _dropScheduledDateTime(db);
  }

  // Rebuilds medication_intakes without the unused scheduledDateTime column.
  Future<void> _dropScheduledDateTime(Database db) async {
    await db.execute('''
      CREATE TABLE medication_intakes_new (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        takenDateTime TEXT,
        takenTimeZone TEXT,
        dose TEXT NOT NULL,
        scheduleId INTEGER,
        side TEXT,
        moleculeJson TEXT NOT NULL,
        administrationRouteName TEXT NOT NULL,
        esterName TEXT,
        supplyItemId INTEGER,
        notes TEXT,
        FOREIGN KEY (supplyItemId) REFERENCES supply_items(id) ON DELETE SET NULL
      );
      ''');

    await db.execute('''
      INSERT INTO medication_intakes_new (
        id, takenDateTime, takenTimeZone,
        dose, scheduleId, side, moleculeJson,
        administrationRouteName, esterName, supplyItemId, notes
      )
      SELECT
        id, takenDateTime, takenTimeZone,
        dose, scheduleId, side, moleculeJson,
        administrationRouteName, esterName, supplyItemId, notes
      FROM medication_intakes
      ''');

    await db.execute('DROP TABLE medication_intakes');
    await db.execute(
        'ALTER TABLE medication_intakes_new RENAME TO medication_intakes');
  }
}
