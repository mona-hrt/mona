import 'dart:convert';
import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV8 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
      CREATE TABLE medication_schedules_new(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        dose TEXT NOT NULL,
        daysOfWeek TEXT NOT NULL,
        startDate TEXT NOT NULL,
        moleculeJson TEXT NOT NULL,
        administrationRouteName TEXT NOT NULL,
        esterName TEXT,
        notificationTimes TEXT NOT NULL
      )
      ''');

    final List<Map<String, dynamic>> schedules =
        await db.query('medication_schedules');

    for (final row in schedules) {
      final int intervalDays = row['intervalDays'] as int;
      final String startDateRaw = row['startDate'] as String;
      final DateTime startDate = DateTime.parse(startDateRaw);

      String daysOfWeekJson;
      if (intervalDays == 1) {
        daysOfWeekJson = jsonEncode([1, 2, 3, 4, 5, 6, 7]);
      } else {
        daysOfWeekJson = jsonEncode([startDate.weekday]);
      }

      await db.insert('medication_schedules_new', {
        'id': row['id'],
        'name': row['name'],
        'dose': row['dose'],
        'daysOfWeek': daysOfWeekJson,
        'startDate': row['startDate'],
        'moleculeJson': row['moleculeJson'],
        'administrationRouteName': row['administrationRouteName'],
        'esterName': row['esterName'],
        'notificationTimes': row['notificationTimes'],
      });
    }

    await db.execute('DROP TABLE medication_schedules');
    await db.execute(
        'ALTER TABLE medication_schedules_new RENAME TO medication_schedules');
  }
}
