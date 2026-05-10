import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV8 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await _dropScheduledDateTime(db);
    await _addScheduleTypeDiscriminator(db);
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

  // Adds a `type` discriminator column to medication_schedules so dart_mappable
  // can deserialize polymorphically. Existing rows are all interval-day
  // schedules, hence the default value. Also makes `intervalDays` nullable
  // (it only applies to the `intervalDays` discriminator value).
  Future<void> _addScheduleTypeDiscriminator(Database db) async {
    await db.execute('''
      CREATE TABLE medication_schedules_new(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        name TEXT NOT NULL,
        dose TEXT NOT NULL,
        intervalDays INTEGER,
        startDate TEXT NOT NULL,
        moleculeJson TEXT NOT NULL,
        administrationRouteName TEXT NOT NULL,
        esterName TEXT,
        notificationTimes TEXT NOT NULL
      )
      ''');

    await db.execute('''
      INSERT INTO medication_schedules_new (
        id, type, name, dose, intervalDays, startDate,
        moleculeJson, administrationRouteName, esterName, notificationTimes
      )
      SELECT
        id, 'intervalDays', name, dose, intervalDays, startDate,
        moleculeJson, administrationRouteName, esterName, notificationTimes
      FROM medication_schedules
      ''');

    await db.execute('DROP TABLE medication_schedules');
    await db.execute(
        'ALTER TABLE medication_schedules_new RENAME TO medication_schedules');
  }
}
