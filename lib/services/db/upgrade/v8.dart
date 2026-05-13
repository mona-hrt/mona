import 'package:mona/services/db/db_tables.dart';
import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

class DbUpgradeV8 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    const uuid = Uuid();
    final now = DateTime.now().millisecondsSinceEpoch;

    Map<int, String> supplyItemMap = {};
    Map<int, String> scheduleMap = {};

    final oldSupplies = await db.query('supply_items');
    final oldSchedules = await db.query('medication_schedules');
    final oldIntakes = await db.query('medication_intakes');
    final oldTests = await db.query('blood_tests');

    await db.execute(
        createSupplyItemsTable.replaceAll('supply_items', 'supply_items_new'));
    await db.execute(createMedicationSchedulesTable.replaceAll(
        'medication_schedules', 'medication_schedules_new'));
    await db.execute(createMedicationIntakesTable
        .replaceAll('medication_intakes', 'medication_intakes_new')
        .replaceAll('supply_items(id)', 'supply_items_new(id)'));
    await db.execute(
        createBloodTestsTable.replaceAll('blood_tests', 'blood_tests_new'));

    for (var row in oldSupplies) {
      final newId = uuid.v4();
      supplyItemMap[row['id'] as int] = newId;

      var newRow = Map<String, dynamic>.from(row);
      newRow['id'] = newId;
      newRow['updatedAt'] = now;
      newRow['isDeleted'] = 0;
      await db.insert('supply_items_new', newRow);
    }

    for (var row in oldSchedules) {
      final newId = uuid.v4();
      scheduleMap[row['id'] as int] = newId;

      var newRow = Map<String, dynamic>.from(row);
      newRow['id'] = newId;
      newRow['updatedAt'] = now;
      newRow['isDeleted'] = 0;
      await db.insert('medication_schedules_new', newRow);
    }

    for (var row in oldIntakes) {
      var newRow = Map<String, dynamic>.from(row);
      newRow['id'] = uuid.v4();
      newRow['updatedAt'] = now;
      newRow['isDeleted'] = 0;

      if (row['scheduleId'] != null) {
        newRow['scheduleId'] = scheduleMap[row['scheduleId'] as int];
      }
      if (row['supplyItemId'] != null) {
        newRow['supplyItemId'] = supplyItemMap[row['supplyItemId'] as int];
      }
      await db.insert('medication_intakes_new', newRow);
    }

    for (var row in oldTests) {
      var newRow = Map<String, dynamic>.from(row);
      newRow['id'] = uuid.v4();
      newRow['updatedAt'] = now;
      newRow['isDeleted'] = 0;
      await db.insert('blood_tests_new', newRow);
    }

    await db.execute('DROP TABLE supply_items');
    await db.execute('DROP TABLE medication_schedules');
    await db.execute('DROP TABLE medication_intakes');
    await db.execute('DROP TABLE blood_tests');

    await db.execute('ALTER TABLE supply_items_new RENAME TO supply_items');
    await db.execute(
        'ALTER TABLE medication_schedules_new RENAME TO medication_schedules');
    await db.execute(
        'ALTER TABLE medication_intakes_new RENAME TO medication_intakes');
    await db.execute('ALTER TABLE blood_tests_new RENAME TO blood_tests');
  }
}
