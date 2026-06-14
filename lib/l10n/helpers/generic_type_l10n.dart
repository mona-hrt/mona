import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';

extension GenericItemTypeL10n on GenericSupplyType {
  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case GenericSupplyType.syringe:
        return l10n.syringe;
      case GenericSupplyType.wipe:
        return l10n.wipe;
      case GenericSupplyType.needle:
        return l10n.needle;
      case GenericSupplyType.gloves:
        return l10n.gloves;
      case GenericSupplyType.bandage:
        return l10n.bandage;
    }
  }

  String localizedRemaining(AppLocalizations l10n, num count) {
    switch (this) {
      case GenericSupplyType.syringe:
        return l10n.syringeRemaining(count);
      case GenericSupplyType.wipe:
        return l10n.wipeRemaining(count);
      case GenericSupplyType.needle:
        return l10n.needleRemaining(count);
      case GenericSupplyType.gloves:
        return l10n.glovesRemaining(count);
      case GenericSupplyType.bandage:
        return l10n.bandageRemaining(count);
    }
  }

  String fallbackLabel() {
    final name = this.name;
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1);
  }
}
