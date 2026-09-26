import 'package:decimal/decimal.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/delivery_form.dart';
import 'package:mona/data/model/dosing_basis.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/i18n/helpers/administration_route_l10n.dart';
import 'package:mona/i18n/helpers/delivery_form_l10n.dart';
import 'package:mona/i18n/helpers/generic_type_l10n.dart';
import 'package:mona/i18n/helpers/molecule_l10n.dart';
import 'package:mona/i18n/translations.g.dart';

String countUnitLabel(
  AdministrationRoute route,
  DeliveryForm? deliveryForm,
  num count,
) =>
    deliveryForm?.localizedUnit(count) ?? route.localizedUnit(count);

String dosePerUnitFieldLabel(
  AdministrationRoute route,
  DeliveryForm? deliveryForm,
) =>
    route == AdministrationRoute.injection
        ? t.concentration
        : t.dosePerUnitLabel(
            unit: countUnitLabel(route, deliveryForm, 1),
          );

bool isQuantifiable(AdministrationRoute route, DeliveryForm? deliveryForm) {
  if (deliveryForm != null) return deliveryForm != DeliveryForm.gram;
  return route != AdministrationRoute.injection &&
      route != AdministrationRoute.transdermalDrops;
}

String doseUnitLabel(
  Molecule molecule,
  DosingBasis dosingBasis,
  AdministrationRoute route,
  DeliveryForm? deliveryForm,
) {
  final doseUnit = molecule.localizedUnit(dosingBasis);
  if (isQuantifiable(route, deliveryForm)) return doseUnit;
  return '$doseUnit/${countUnitLabel(route, deliveryForm, 1)}';
}

extension SupplyItemL10n on SupplyItem {
  String get localizedSummary {
    return switch (this) {
      final MedicationSupplyItem m => m.localizedSummary,
      final GenericSupply g => g.localizedSummary,
      _ => '',
    };
  }
}

extension MedicationSupplyItemL10n on MedicationSupplyItem {
  String localizedUnit(num count) =>
      countUnitLabel(administrationRoute, deliveryForm, count);

  String localizedSupplyAmount(Decimal dose) {
    final amount = getAmount(dose);
    return ' $dose ${molecule.localizedUnit(dosingBasis)} = $amount '
        '${localizedUnit(amount.toDouble())}';
  }

  String get localizedSummary {
    return '${molecule.localizedNameWithEster(ester)} • '
        '${_localizedConcentration()}\n'
        '${_localizedRemaining()}';
  }

  String get localizedConcentrationAndRemaining {
    return '${_localizedConcentration()} • ${_localizedRemaining()}';
  }

  String _localizedConcentration() {
    return '$dosePerUnit '
        '${doseUnitLabel(molecule, dosingBasis, administrationRoute, deliveryForm)}';
  }

  String _localizedRemaining() {
    final amountRemaining = getAmount(remainingDose);
    final amountRemainingFormatted =
        amountRemaining % Decimal.one == Decimal.zero
            ? amountRemaining.toDouble().toInt()
            : amountRemaining.round(scale: 1).toDouble();
    final routeUnitRemaining = localizedUnit(amountRemaining.toDouble());
    return t.remaining(
        count: amountRemainingFormatted, unit: routeUnitRemaining);
  }
}

extension GenericSupplyL10n on GenericSupply {
  String get localizedSummary => genericSupplyType.localizedRemaining(amount);
}
