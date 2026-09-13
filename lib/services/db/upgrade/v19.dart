import 'package:mona/services/db/upgrade/db_upgrade.dart';
import 'package:sqflite/sqlite_api.dart';

class DbUpgradeV19 implements DbUpgrade {
  @override
  Future<void> upgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('ALTER TABLE supply_items ADD COLUMN deliveryForm TEXT');
    await db.execute(
      "UPDATE supply_items SET deliveryForm = 'pump' "
      "WHERE administrationRoute = 'gel'",
    );
  }
}
