import 'package:mona/services/db/db_tables.dart';

const int oldestImportableVersion = 4;

const String _supplyItemsV4 = '''
    CREATE TABLE supply_items(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      totalDose TEXT NOT NULL,
      usedDose TEXT NOT NULL,
      concentration TEXT NOT NULL,
      name TEXT NOT NULL,
      quantity INTEGER NOT NULL,
      moleculeJson TEXT NOT NULL,
      administrationRouteName TEXT NOT NULL,
      esterName TEXT
    )
    ''';

const String _medicationIntakesV4 = '''
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
      esterName TEXT
    )
    ''';

const String _medicationSchedulesV4 = '''
    CREATE TABLE medication_schedules(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      dose TEXT NOT NULL,
      intervalDays INTEGER NOT NULL,
      startDate TEXT NOT NULL,
      moleculeJson TEXT NOT NULL,
      administrationRouteName TEXT NOT NULL,
      esterName TEXT,
      notificationTimes TEXT NOT NULL
    )
    ''';

const String _bloodTestsV4 = '''
    CREATE TABLE blood_tests(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      dateTime TEXT NOT NULL,
      timeZone TEXT NOT NULL,
      estradiolLevels TEXT,
      testosteroneLevels TEXT
    )
    ''';

const String _medicationIntakesV5 = '''
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
      FOREIGN KEY (supplyItemId) REFERENCES supply_items(id) ON DELETE SET NULL
    )
    ''';

const String _supplyItemsV6 = '''
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
    ''';

const String _medicationIntakesV7 = '''
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
    ''';

const Map<int, List<String>> _historicalSchemas = {
  4: [
    _supplyItemsV4,
    _medicationIntakesV4,
    _medicationSchedulesV4,
    _bloodTestsV4,
  ],
  5: [
    _supplyItemsV4,
    _medicationIntakesV5,
    _medicationSchedulesV4,
    _bloodTestsV4,
  ],
  6: [
    _supplyItemsV6,
    _medicationIntakesV5,
    _medicationSchedulesV4,
    _bloodTestsV4,
  ],
  7: [
    createSupplyItemsTable,
    _medicationIntakesV7,
    createMedicationSchedulesTable,
    createBloodTestsTable,
  ],
  8: [
    createSupplyItemsTable,
    createMedicationIntakesTable,
    createMedicationSchedulesTable,
    createBloodTestsTable,
  ],
};

List<String> historicalSchemaFor(int version) {
  final schema = _historicalSchemas[version];
  if (schema == null) {
    throw ArgumentError(
      'No historical schema registered for database version $version',
    );
  }
  return schema;
}
