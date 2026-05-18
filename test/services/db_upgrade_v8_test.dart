import 'package:flutter_test/flutter_test.dart';
import 'package:mona/services/db/upgrade/v8.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('DbUpgradeV8', () {
    late Database db;

    setUp(() async {
      db = await openDatabase(inMemoryDatabasePath);

      // Create V7-like schema
      await db.execute('''
        CREATE TABLE supply_items(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type TEXT NOT NULL,
          name TEXT NOT NULL,
          totalDose TEXT,
          usedDose TEXT,
          concentration TEXT,
          moleculeJson TEXT,
          administrationRouteName TEXT,
          esterName TEXT,
          amount INTEGER
        )
      ''');

      await db.execute('''
        CREATE TABLE medication_schedules(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          dose TEXT NOT NULL,
          intervalDays INTEGER NOT NULL,
          startDate TEXT NOT NULL,
          moleculeJson TEXT NOT NULL,
          administrationRouteName TEXT NOT NULL,
          esterName TEXT,
          notificationTimes TEXT NOT NULL DEFAULT '[]'
        )
      ''');

      await db.execute('''
        CREATE TABLE medication_intakes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          scheduledDateTime TEXT NOT NULL,
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
        )
      ''');

      await db.execute('''
        CREATE TABLE blood_tests(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          dateTime TEXT NOT NULL,
          timeZone TEXT NOT NULL,
          estradiolLevels TEXT,
          testosteroneLevels TEXT,
          estradiolUnit TEXT,
          testosteroneUnit TEXT
        )
      ''');
    });

    tearDown(() async {
      await db.close();
    });

    test('migrates integer IDs to UUIDs and preserves relationships', () async {
      final uuidRegex = RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$');

      // Insert test data in V7 format
      final oldSupplyId = await db.insert('supply_items', {
        'type': 'medication',
        'name': 'Test Supply',
        'totalDose': '100',
      });

      final oldScheduleId = await db.insert('medication_schedules', {
        'name': 'Test Schedule',
        'dose': '1',
        'intervalDays': 1,
        'startDate': '2025-01-01',
        'moleculeJson': '{}',
        'administrationRouteName': 'oral',
        'notificationTimes': '[]',
      });

      await db.insert('medication_intakes', {
        'scheduledDateTime': '2025-01-01T10:00:00',
        'dose': '1',
        'scheduleId': oldScheduleId,
        'supplyItemId': oldSupplyId,
        'moleculeJson': '{}',
        'administrationRouteName': 'oral',
      });

      await db.insert('blood_tests', {
        'dateTime': '2025-01-01T10:00:00',
        'timeZone': 'UTC',
      });

      // Run upgrade
      await DbUpgradeV8().upgrade(db, 7, 8);

      // Verify supply_items
      final newSupplies = await db.query('supply_items');
      expect(newSupplies.length, 1);
      final newSupplyId = newSupplies.first['id'] as String;
      expect(uuidRegex.hasMatch(newSupplyId), true);
      expect(newSupplies.first['name'], 'Test Supply');
      expect(newSupplies.first['updatedAt'], isNotNull);
      expect(newSupplies.first['isDeleted'], 0);

      // Verify medication_schedules
      final newSchedules = await db.query('medication_schedules');
      expect(newSchedules.length, 1);
      final newScheduleId = newSchedules.first['id'] as String;
      expect(uuidRegex.hasMatch(newScheduleId), true);
      expect(newSchedules.first['name'], 'Test Schedule');

      // Verify medication_intakes and foreign keys
      final newIntakes = await db.query('medication_intakes');
      expect(newIntakes.length, 1);
      expect(uuidRegex.hasMatch(newIntakes.first['id'] as String), true);
      expect(newIntakes.first['scheduleId'], newScheduleId);
      expect(newIntakes.first['supplyItemId'], newSupplyId);

      // Verify blood_tests
      final newTests = await db.query('blood_tests');
      expect(newTests.length, 1);
      expect(uuidRegex.hasMatch(newTests.first['id'] as String), true);
    });
  });
}
