import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:mona/data/providers/blood_test_provider.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import 'package:mona/services/db/app_database.dart';
import 'package:mona/services/demo_data.dart';

class DemoModeService {
  final SupplyItemProvider supplyItemProvider;
  final MedicationScheduleProvider medicationScheduleProvider;
  final MedicationIntakeProvider medicationIntakeProvider;
  final BloodTestProvider bloodTestProvider;

  DemoModeService({
    required this.supplyItemProvider,
    required this.medicationScheduleProvider,
    required this.medicationIntakeProvider,
    required this.bloodTestProvider,
  });

  Future<void> load() async {
    final timeZone = await FlutterTimezone.getLocalTimezone();
    final data = DemoData.generate(timeZone.identifier);

    final db = await AppDatabase.getInstance().database;
    await db.transaction((txn) async {
      final batch = txn.batch();
      for (final table in [
        'medication_intakes',
        'medication_schedules',
        'supply_items',
        'blood_tests',
      ]) {
        batch.delete(table);
      }
      for (final item in data.supplyItems) {
        batch.insert('supply_items', item.toMap());
      }
      for (final schedule in data.schedules) {
        batch.insert('medication_schedules', schedule.toMap());
      }
      for (final intake in data.intakes) {
        batch.insert('medication_intakes', intake.toMap());
      }
      for (final bloodTest in data.bloodTests) {
        batch.insert('blood_tests', bloodTest.toMap());
      }
      await batch.commit(noResult: true);
    });

    await supplyItemProvider.fetchItems();
    await bloodTestProvider.fetchBloodTests();
    await medicationScheduleProvider.fetchSchedules();
    await medicationIntakeProvider.fetchIntakes();
  }
}
