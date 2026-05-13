import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:mona/util/validators.dart';
import 'package:uuid/uuid.dart';

class MedicationSupplyItem implements SupplyItem {
  @override
  final String id;
  @override
  final String name;
  final Decimal totalDose;
  final Decimal usedDose;
  final Decimal concentration;
  final Molecule molecule;
  final AdministrationRoute administrationRoute;
  final Ester? ester;
  @override
  final int updatedAt;
  @override
  final bool isDeleted;

  MedicationSupplyItem({
    String? id,
    required this.name,
    required this.totalDose,
    required this.concentration,
    Decimal? usedDose,
    required this.molecule,
    required this.administrationRoute,
    this.ester,
    int? updatedAt,
    this.isDeleted = false,
  })  : usedDose = usedDose ?? Decimal.zero,
        id = id ?? const Uuid().v4(),
        updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  factory MedicationSupplyItem.fromMap(Map<String, Object?> map) {
    return MedicationSupplyItem(
      id: map['id'] as String?,
      name: map['name'] as String,
      totalDose: (map['totalDose'] as String).toDecimal,
      usedDose: (map['usedDose'] as String).toDecimal,
      concentration: (map['concentration'] as String).toDecimal,
      molecule: Molecule.fromJson(jsonDecode(map['moleculeJson'] as String)),
      administrationRoute: AdministrationRoute.fromName(
          map['administrationRouteName'] as String),
      ester: Ester.fromName(map['esterName'] as String?),
      updatedAt: map['updatedAt'] as int?,
      isDeleted: (map['isDeleted'] as int?) == 1,
    );
  }

  bool get isUsed => usedDose > Decimal.zero;
  Decimal get remainingDose => totalDose - usedDose;

  bool isValid() {
    return totalDose > Decimal.zero &&
        usedDose >= Decimal.zero &&
        usedDose <= totalDose &&
        name != '' &&
        concentration > Decimal.zero;
  }

  bool canUseDose(Decimal doseToUse) {
    return usedDose + doseToUse <= totalDose;
  }

  double getRatio() {
    return (remainingDose *
            totalDose.inverse.toDecimal(scaleOnInfinitePrecision: 10))
        .toDouble();
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'totalDose': totalDose.toString(),
      'usedDose': usedDose.toString(),
      'concentration': concentration.toString(),
      'moleculeJson': jsonEncode(molecule.toJson()),
      'administrationRouteName': administrationRoute.name,
      'esterName': ester?.name,
      'type': SupplyType.medication.name,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted ? 1 : 0,
    };
  }

  Decimal getAmount(Decimal dose) =>
      (dose.toRational() / concentration.toRational())
          .toDecimal(scaleOnInfinitePrecision: 3);

  Decimal getDose(Decimal amount) => amount * concentration;

  MedicationSupplyItem copyWith({
    String? id,
    String? name,
    Decimal? totalDose,
    Decimal? usedDose,
    Decimal? concentration,
    Molecule? molecule,
    AdministrationRoute? administrationRoute,
    Ester? ester,
    bool clearEster = false,
    int? updatedAt,
    bool? isDeleted,
  }) {
    return MedicationSupplyItem(
      id: id ?? this.id,
      name: name ?? this.name,
      totalDose: totalDose ?? this.totalDose,
      usedDose: usedDose ?? this.usedDose,
      concentration: concentration ?? this.concentration,
      molecule: molecule ?? this.molecule,
      administrationRoute: administrationRoute ?? this.administrationRoute,
      ester: clearEster ? null : (ester ?? this.ester),
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  static String? Function(String?) usedAmountValidator(
      AppLocalizations l10n, String totalAmount) {
    return (String? value) {
      return requiredPositiveDecimal(l10n, value) ??
          (validateTotalAmount(l10n, totalAmount) != null
              ? l10n.invalidTotalAmount
              : null) ??
          (value.toDecimalOrZero > totalAmount.toDecimal
              ? l10n.cannotExceedTotalCapacity
              : null);
    };
  }

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

  // coverage:ignore-start
  static String? validateTotalAmount(AppLocalizations l10n, String? value) =>
      requiredStrictlyPositiveDecimal(l10n, value);

  static String? validateConcentration(AppLocalizations l10n, String? value) =>
      requiredStrictlyPositiveDecimal(l10n, value);

  static String? validateMolecule(AppLocalizations l10n, Molecule? value) =>
      requiredMolecule(l10n, value);

  static String? validateAdministrationRoute(
          AppLocalizations l10n, AdministrationRoute? value) =>
      requiredAdministrationRoute(l10n, value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MedicationSupplyItem && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'SupplyItem(id: $id, name: $name, molecule: ${molecule.name}, '
        'ester: ${ester?.name}, route: ${administrationRoute.name}, '
        'concentration: $concentration ${molecule.unit}/${administrationRoute.unit}, '
        'totalDose: $totalDose, usedDose: $usedDose)';
  }
  // coverage:ignore-end
}
