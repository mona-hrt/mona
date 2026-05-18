import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:mona/util/validators.dart';

class MedicationSchedule {
  final int id;
  final String name;
  final Decimal dose;
  final List<int> daysOfWeek;
  final Date startDate;
  final Molecule molecule;
  final AdministrationRoute administrationRoute;
  final Ester? ester;
  List<TimeOfDay> notificationTimes;

  MedicationSchedule({
    int? id,
    required this.name,
    required this.dose,
    required this.daysOfWeek,
    Date? startDate,
    required this.molecule,
    required this.administrationRoute,
    this.ester,
    required this.notificationTimes,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch,
        startDate = startDate ?? Date.today();

  factory MedicationSchedule.fromMap(Map<String, Object?> map) {
    return MedicationSchedule(
      id: map['id'] as int,
      name: map['name'] as String,
      dose: (map['dose'] as String).toDecimal,
      daysOfWeek: List<int>.from(jsonDecode(map['daysOfWeek'] as String)),
      startDate: (map['startDate'] as String).toDate,
      molecule: Molecule.fromJson(jsonDecode(map['moleculeJson'] as String)),
      administrationRoute: AdministrationRoute.fromName(
          map['administrationRouteName'] as String),
      ester: Ester.fromName(map['esterName'] as String?),
      notificationTimes: _decodeTimes(map['notificationTimes'] as String),
    );
  }

  /// Returns the next scheduled injection date relative to [referenceDate] (or today if null).
  ///
  /// - If the [startDate] is in the future or today, returns [startDate].
  /// - If today falls exactly on a scheduled injection date, returns today.
  /// - Otherwise, returns the next scheduled date after today.
  Date get nextDate {
    if (daysOfWeek.isEmpty) return startDate;

    DateTime current =
        startDate.isAfterToday ? startDate.toDateTime() : DateTime.now();

    while (!daysOfWeek.contains(current.weekday)) {
      current = current.add(const Duration(days: 1));
    }
    return Date.fromDateTime(current);
  }

  /// Returns the last scheduled injection date relative to [referenceDate] (or today if null).
  ///
  /// - If the [startDate] is in the future or today, returns null.
  /// - If today falls exactly on a scheduled injection date, returns the scheduled date before today.
  /// - Otherwise, returns the last scheduled date before today.
  Date? get previousDate {
    if (!startDate.isBeforeToday || daysOfWeek.isEmpty) return null;

    DateTime current = DateTime.now().subtract(const Duration(days: 1));
    while (!daysOfWeek.contains(current.weekday)) {
      current = current.subtract(const Duration(days: 1));
    }

    final prevDate = Date.fromDateTime(current);
    return prevDate.isBefore(startDate) ? null : prevDate;
  }

  List<Date> getNextDates(int count) {
    if (count <= 0 || daysOfWeek.isEmpty) return [];

    final dates = <Date>[];
    DateTime current = nextDate.toDateTime();

    while (dates.length < count) {
      if (daysOfWeek.contains(current.weekday)) {
        dates.add(Date.fromDateTime(current));
      }
      current = current.add(const Duration(days: 1));
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

  bool isTakenTodayOrLater(Date? lastTakenDate) {
    if (lastTakenDate == null) return false;

    return lastTakenDate.isToday || lastTakenDate.isAfterToday;
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'dose': dose.toString(),
      'daysOfWeek': jsonEncode(daysOfWeek),
      'startDate': startDate.toString(),
      'moleculeJson': jsonEncode(molecule.toJson()),
      'administrationRouteName': administrationRoute.name,
      'esterName': ester?.name,
      'notificationTimes': _encodeTimes(notificationTimes),
    };
  }

  MedicationSchedule copyWith({
    int? id,
    String? name,
    Decimal? dose,
    List<int>? daysOfWeek,
    Date? startDate,
    Molecule? molecule,
    AdministrationRoute? administrationRoute,
    Ester? ester,
    bool clearEster = false,
    List<TimeOfDay>? notificationTimes,
  }) {
    return MedicationSchedule(
      id: id ?? this.id,
      name: name ?? this.name,
      dose: dose ?? this.dose,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      startDate: startDate ?? this.startDate,
      molecule: molecule ?? this.molecule,
      administrationRoute: administrationRoute ?? this.administrationRoute,
      ester: clearEster ? null : (ester ?? this.ester),
      notificationTimes: notificationTimes ?? this.notificationTimes,
    );
  }

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

  static String _encodeTimes(List<TimeOfDay> times) {
    return jsonEncode(
      times.map((t) => "${t.hour}:${t.minute}").toList(),
    );
  }

  static List<TimeOfDay> _decodeTimes(String json) {
    final List list = jsonDecode(json);

    return list.map((e) {
      final parts = e.split(":");
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MedicationSchedule && id == other.id;

  @override
  int get hashCode => id.hashCode;

  String formatFrequency() {
    if (daysOfWeek.length == 7) return "every day";
    if (daysOfWeek.isEmpty) return "no days selected";

    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final selectedDays = daysOfWeek.map((d) => weekdays[d - 1]).join(', ');
    return "Every $selectedDays";
  }

  @override
  String toString() {
    final times =
        notificationTimes.map((t) => '${t.hour}:${t.minute}').join(', ');
    return 'MedicationSchedule(id: $id, name: $name, dose: $dose ${molecule.unit}, '
        'molecule: ${molecule.name}, ester: ${ester?.name}, '
        'route: ${administrationRoute.name}, Frequency: $formatFrequency(), '
        'startDate: $startDate, notificationTimes: [$times])';
  }
}
