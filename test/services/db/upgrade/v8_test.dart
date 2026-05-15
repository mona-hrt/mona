import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mona/services/db/historical_schemas.dart';
import 'package:mona/services/db/upgrade/v8.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('DbUpgradeV8.medication_schedules', () {
    late Database db;

    setUp(() async {
      db = await openDatabase(inMemoryDatabasePath, version: 7);
      for (final stmt in historicalSchemaFor(7)) {
        await db.execute(stmt);
      }
    });

    tearDown(() async {
      await db.close();
    });

    Future<int> insertSchedule({
      required int intervalDays,
      required String notificationTimesJson,
      String name = 'Med',
    }) async {
      return db.insert('medication_schedules', {
        'name': name,
        'dose': '5',
        'intervalDays': intervalDays,
        'startDate': '2025-01-01T00:00:00.000Z',
        'moleculeJson': '{"name":"estradiol","unit":"mg"}',
        'administrationRouteName': 'oral',
        'notificationTimes': notificationTimesJson,
      });
    }

    Future<Map<String, Object?>> readSchedule(int id) async {
      final rows = await db.query(
        'medication_schedules',
        where: 'id = ?',
        whereArgs: [id],
      );
      return rows.single;
    }

    test(
        'intervalDays > 1 -> IntervalDaysSchedule with first notificationTime',
        () async {
      final id = await insertSchedule(
        intervalDays: 7,
        notificationTimesJson: '["8:30","20:0"]',
        name: 'Weekly',
      );

      await DbUpgradeV8().upgrade(db, 7, 8);

      final row = await readSchedule(id);
      final strategy =
          jsonDecode(row['schedulingStrategy'] as String) as Map<String, Object?>;
      expect(strategy, {
        'type': 'intervalDays',
        'intervalDays': 7,
        'notificationTime': '8:30',
      });
    });

    test(
        'intervalDays > 1 with no notification times -> IntervalDaysSchedule, notificationTime null',
        () async {
      final id = await insertSchedule(
        intervalDays: 3,
        notificationTimesJson: '[]',
        name: 'Every 3 days',
      );

      await DbUpgradeV8().upgrade(db, 7, 8);

      final row = await readSchedule(id);
      final strategy =
          jsonDecode(row['schedulingStrategy'] as String) as Map<String, Object?>;
      expect(strategy, {
        'type': 'intervalDays',
        'intervalDays': 3,
        'notificationTime': null,
      });
    });

    test(
        'intervalDays == 1 with no notification times -> IntervalDaysSchedule(1), notificationTime null',
        () async {
      final id = await insertSchedule(
        intervalDays: 1,
        notificationTimesJson: '[]',
        name: 'Daily silent',
      );

      await DbUpgradeV8().upgrade(db, 7, 8);

      final row = await readSchedule(id);
      final strategy =
          jsonDecode(row['schedulingStrategy'] as String) as Map<String, Object?>;
      expect(strategy, {
        'type': 'intervalDays',
        'intervalDays': 1,
        'notificationTime': null,
      });
    });

    test(
        'intervalDays == 1 with notification times -> DailySchedule with all times, notify true',
        () async {
      final id = await insertSchedule(
        intervalDays: 1,
        notificationTimesJson: '["8:0","20:30"]',
        name: 'Daily multi',
      );

      await DbUpgradeV8().upgrade(db, 7, 8);

      final row = await readSchedule(id);
      final strategy =
          jsonDecode(row['schedulingStrategy'] as String) as Map<String, Object?>;
      expect(strategy, {
        'type': 'daily',
        'intakeTimes': ['8:0', '20:30'],
        'notify': true,
      });
    });

    test('migrated table has the new shape (no intervalDays/notificationTimes)',
        () async {
      await insertSchedule(intervalDays: 7, notificationTimesJson: '[]');

      await DbUpgradeV8().upgrade(db, 7, 8);

      final columns = await db.rawQuery(
          "PRAGMA table_info('medication_schedules')");
      final names = columns.map((c) => c['name'] as String).toSet();
      expect(names, contains('schedulingStrategy'));
      expect(names, isNot(contains('intervalDays')));
      expect(names, isNot(contains('notificationTimes')));
    });

    test('preserves the row id and other columns', () async {
      final id = await insertSchedule(
        intervalDays: 2,
        notificationTimesJson: '[]',
        name: 'Preservation Test',
      );

      await DbUpgradeV8().upgrade(db, 7, 8);

      final row = await readSchedule(id);
      expect(row['id'], id);
      expect(row['name'], 'Preservation Test');
      expect(row['dose'], '5');
      expect(row['administrationRouteName'], 'oral');
    });
  });
}
