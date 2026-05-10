import 'package:dart_mappable/dart_mappable.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/custom_mappers.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/validators.dart';

part 'medication_schedule.mapper.dart';

@MappableClass(discriminatorKey: 'type')
abstract class MedicationSchedule with MedicationScheduleMappable {
  final int id;
  final String name;
  final Decimal dose;
  final Date startDate;
  @MappableField(key: 'moleculeJson')
  final Molecule molecule;
  @MappableField(key: 'administrationRouteName')
  final AdministrationRoute administrationRoute;
  @MappableField(key: 'esterName')
  final Ester? ester;
  List<TimeOfDay> notificationTimes;

  MedicationSchedule({
    int? id,
    required this.name,
    required this.dose,
    Date? startDate,
    required this.molecule,
    required this.administrationRoute,
    this.ester,
    required this.notificationTimes,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch,
        startDate = startDate ?? Date.today();

  static String? validateName(AppLocalizations l10n, String? value) =>
      requiredString(l10n, value);

  static String? validateDose(AppLocalizations l10n, String? value) =>
      requiredStrictlyPositiveDecimal(l10n, value);

  static String? validateStartDate(AppLocalizations l10n, Date? value) =>
      requiredDate(l10n, value);

  static String? validateMolecule(AppLocalizations l10n, Molecule? value) =>
      requiredMolecule(l10n, value);

  static String? validateAdministrationRoute(
          AppLocalizations l10n, AdministrationRoute? value) =>
      requiredAdministrationRoute(l10n, value);

  static String? Function(Ester?) esterValidator(AppLocalizations l10n,
      Molecule? molecule, AdministrationRoute? administrationRoute) {
    return (Ester? value) {
      return (molecule == KnownMolecules.estradiol &&
              administrationRoute == AdministrationRoute.injection &&
              value == null)
          ? l10n.requiredField
          : null;
    };
  }
}

@MappableClass(
  discriminatorValue: 'intervalDays',
  includeCustomMappers: [
    MoleculeJsonMapper(),
    AdministrationRouteNameMapper(),
    EsterNameMapper(),
    DecimalStringMapper(),
    DateStringMapper(),
    NotificationTimesMapper(),
  ],
  generateMethods: GenerateMethods.all,
)
class IntervalDaysSchedule extends MedicationSchedule
    with IntervalDaysScheduleMappable {
  final int intervalDays;

  IntervalDaysSchedule({
    super.id,
    required super.name,
    required super.dose,
    required this.intervalDays,
    super.startDate,
    required super.molecule,
    required super.administrationRoute,
    super.ester,
    required super.notificationTimes,
  });

  /// Returns the next scheduled injection date relative to today.
  ///
  /// - If the [startDate] is in the future or today, returns [startDate].
  /// - If today falls exactly on a scheduled injection date, returns today.
  /// - Otherwise, returns the next scheduled date after today.
  Date get nextDate {
    if (!startDate.isBeforeToday) {
      return startDate;
    }

    final daysSinceStart = startDate.daysAwayFromToday;

    if (daysSinceStart % intervalDays == 0) {
      return Date.today();
    }

    return Date.today()
        .add(Duration(days: intervalDays - (daysSinceStart % intervalDays)));
  }

  /// Returns the last scheduled injection date relative to today.
  ///
  /// - If the [startDate] is in the future or today, returns null.
  /// - If today falls exactly on a scheduled injection date, returns the scheduled date before today.
  /// - Otherwise, returns the last scheduled date before today.
  Date? get previousDate {
    if (!startDate.isBeforeToday) {
      return null;
    }

    final daysSinceStart = startDate.daysAwayFromToday;

    if (daysSinceStart % intervalDays == 0) {
      return Date.today().subtract(Duration(days: intervalDays));
    }

    return Date.today().subtract(Duration(days: daysSinceStart % intervalDays));
  }

  List<Date> getNextDates(int count) {
    if (count < 0) {
      throw ArgumentError('Count must be a positive integer');
    }

    if (count == 0) {
      return [];
    }

    final dates = <Date>[];
    Date nextDate = this.nextDate;

    for (int i = 0; i < count; i++) {
      dates.add(nextDate);
      nextDate = nextDate.add(Duration(days: intervalDays));
    }
    return dates;
  }

  bool isScheduledForToday() {
    return nextDate.isToday;
  }

  bool isLate(Date? lastTakenDate) {
    if (previousDate == null) {
      return false;
    }

    return lastTakenDate == null || lastTakenDate.isBefore(previousDate!);
  }

  bool lastTakenLate(Date? lastTakenDate) {
    if (lastTakenDate == null || previousDate == null) {
      return false;
    }
    return lastTakenDate.isAfter(previousDate!);
  }

  bool isTakenTodayOrLater(Date? lastTakenDate) {
    if (lastTakenDate == null) return false;

    return lastTakenDate.isToday || lastTakenDate.isAfterToday;
  }

  static String? validateIntervalDays(AppLocalizations l10n, String? value) =>
      requiredPositiveInt(l10n, value);
}

@MappableClass(
  discriminatorValue: 'daily',
  includeCustomMappers: [
    MoleculeJsonMapper(),
    AdministrationRouteNameMapper(),
    EsterNameMapper(),
    DecimalStringMapper(),
    DateStringMapper(),
    NotificationTimesMapper(),
  ],
  generateMethods: GenerateMethods.all,
)
class DailySchedule extends MedicationSchedule with DailyScheduleMappable {
  DailySchedule({
    super.id,
    required super.name,
    required super.dose,
    super.startDate,
    required super.molecule,
    required super.administrationRoute,
    super.ester,
    required super.notificationTimes,
  });
}
