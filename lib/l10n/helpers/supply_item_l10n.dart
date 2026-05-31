import 'package:decimal/decimal.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/helpers/administration_route_l10n.dart';
import 'package:mona/l10n/helpers/molecule_l10n.dart';

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

  String localizedSummary(AppLocalizations localizations) {
    final amountRemaining = getAmount(remainingDose);
    final routeUnitRemaining = administrationRoute.localizedUnit(
      localizations,
      amountRemaining.toDouble(),
    );
    final headline =
        '${molecule.localizedNameWithEster(ester, localizations)} • '
        '$concentration ${molecule.unit}/${administrationRoute.localizedUnit(localizations, 1)}';

    final amountRemainingFormatted =
        amountRemaining % Decimal.one == Decimal.zero
            ? amountRemaining.toDouble().toInt()
            : amountRemaining.toDouble();
    // int if whole number, otherwise double

    final remainingLine = localizations.remaining(
      amountRemainingFormatted,
      routeUnitRemaining,
    );
    return '$headline\n$remainingLine';
  }
}

extension GenericSupplyL10n on GenericSupply {
  String localizedSummary(AppLocalizations localizations) {
    // TODO localize
    return '${genericSupplyType.name}\n$amount remaining';
  }
}

extension SupplyItemL10n on SupplyItem {
  String localizedSummary(AppLocalizations localizations) {
    return switch (this) {
      final MedicationSupplyItem m => m.localizedSummary(localizations),
      final GenericSupply g => g.localizedSummary(localizations),
      _ => '', // TODO localize unknown item summary
    };
  }
}
