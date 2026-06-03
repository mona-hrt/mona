import 'package:decimal/decimal.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/helpers/administration_route_l10n.dart';
import 'package:mona/l10n/helpers/generic_type_l10n.dart';
import 'package:mona/l10n/helpers/molecule_l10n.dart';

extension SupplyItemL10n on SupplyItem {
  String localizedSummary(AppLocalizations localizations) {
    return switch (this) {
      final MedicationSupplyItem m => m.localizedSummary(localizations),
      final GenericSupply g => g.localizedSummary(localizations),
      _ => '',
    };
  }
}

extension MedicationSupplyItemL10n on MedicationSupplyItem {
  String localizedSupplyAmount(
    AppLocalizations localizations,
    Decimal dose,
    String moleculeUnit,
  ) {
    final amount = getAmount(dose);
    return ' $dose $moleculeUnit = $amount '
        '${administrationRoute.localizedUnit(localizations, amount.toDouble())}';
  }

  String localizedSummary(AppLocalizations l10n) {
    final amountRemaining = getAmount(remainingDose);
    final amountRemainingFormatted =
        amountRemaining % Decimal.one == Decimal.zero
            ? amountRemaining.toDouble().toInt()
            : amountRemaining.toDouble();
    final routeUnitRemaining =
        administrationRoute.localizedUnit(l10n, amountRemaining.toDouble());
    final routeConcentrationUnit = administrationRoute.localizedUnit(l10n, 1);

    return '${molecule.localizedNameWithEster(ester, l10n)} • '
        '$concentration ${molecule.unit}/$routeConcentrationUnit\n'
        '${l10n.remaining(amountRemainingFormatted, routeUnitRemaining)}';
  }
}

extension GenericSupplyL10n on GenericSupply {
  String localizedSummary(AppLocalizations l10n) {
    return '${genericSupplyType.localizedName(l10n)}\n'
        '${l10n.remaining(amount, genericSupplyType.localizedName(l10n, amount))}';
  }
}
