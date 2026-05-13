import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:mona/util/timezone_location.dart';
import 'package:mona/util/validators.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

class BloodTest {
  final String id;
  final DateTime dateTime;
  final String timeZone;
  final UnitValue<EstradiolUnit>? estradiolLevels;
  final UnitValue<TestosteroneUnit>? testosteroneLevels;
  final int updatedAt;
  final bool isDeleted;

  BloodTest({
    String? id,
    required this.dateTime,
    required this.timeZone,
    this.estradiolLevels,
    this.testosteroneLevels,
    int? updatedAt,
    this.isDeleted = false,
  })  : id = id ?? const Uuid().v4(),
        updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch {
    if (!dateTime.isUtc) {
      throw ArgumentError('dateTime must be UTC');
    }
  }

  factory BloodTest.fromMap(Map<String, Object?> map) {
    final estradiolLevels = (map['estradiolLevels'] as String?).toDecimalOrNull;
    final estradiolUnitName = map['estradiolUnit'] as String?;
    final estradiolUnit = estradiolUnitName != null
        ? EstradiolUnit.parse(estradiolUnitName)
        : null;
    final testosteroneLevels =
        (map['testosteroneLevels'] as String?).toDecimalOrNull;
    final testosteroneUnitName = map['testosteroneUnit'] as String?;
    final testosteroneUnit = testosteroneUnitName != null
        ? TestosteroneUnit.parse(testosteroneUnitName)
        : null;

    return BloodTest(
        id: map['id'] as String?,
        dateTime: (map['dateTime'] as String).toDateTime,
        timeZone: map['timeZone'] as String,
        estradiolLevels: estradiolLevels != null
            ? UnitValue(estradiolLevels, estradiolUnit!)
            : null,
        testosteroneLevels: testosteroneLevels != null
            ? UnitValue(testosteroneLevels, testosteroneUnit!)
            : null,
        updatedAt: map['updatedAt'] as int?,
        isDeleted: (map['isDeleted'] as int?) == 1);
  }

  DateTime get localDateTime {
    final location = timeZoneLocation(timeZone);
    return tz.TZDateTime.from(dateTime, location);
  }

  Date get localDate => localDateTime.toDate;

  BloodTest copyWith({
    String? id,
    DateTime? dateTime,
    String? timeZone,
    UnitValue<EstradiolUnit>? estradiolLevels,
    UnitValue<TestosteroneUnit>? testosteroneLevels,
    int? updatedAt,
    bool? isDeleted,
  }) {
    return BloodTest(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      timeZone: timeZone ?? this.timeZone,
      estradiolLevels: estradiolLevels ?? this.estradiolLevels,
      testosteroneLevels: testosteroneLevels ?? this.testosteroneLevels,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'timeZone': timeZone,
      'estradiolLevels': estradiolLevels?.value.toString(),
      'estradiolUnit': estradiolLevels?.unit.toString(),
      'testosteroneLevels': testosteroneLevels?.value.toString(),
      'testosteroneUnit': testosteroneLevels?.unit.toString(),
      'updatedAt': updatedAt,
      'isDeleted': isDeleted ? 1 : 0,
    };
  }

  // coverage:ignore-start
  static String? validateDate(AppLocalizations l10n, DateTime? value) =>
      requiredDateTime(l10n, value);

  static String? validateLevel(AppLocalizations l10n, String? value) =>
      positiveDecimal(l10n, value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BloodTest && (id == other.id);

  @override
  int get hashCode => id.hashCode;
// coverage:ignore-end
}
