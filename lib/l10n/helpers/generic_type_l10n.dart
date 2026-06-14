import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';

extension GenericItemTypeL10n on GenericSupplyType {
  String localizedName(AppLocalizations l10n, [num count = 1]) {
    switch (this) {
      case GenericSupplyType.syringe:
        return l10n.syringe(count);
      case GenericSupplyType.wipe:
        return l10n.wipe(count);
      case GenericSupplyType.needle:
        return l10n.needle(count);
      case GenericSupplyType.gloves:
        return l10n.gloves(count);
      case GenericSupplyType.bandage:
        return l10n.bandage(count);
    }
  }

  String fallbackLabel() {
    final name = this.name;
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1);
  }
}
