import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';

extension GenericTypeL10n on GenericSupplyType {
  String localizedName(AppLocalizations localizations) =>
      _GenericTypeDisplayNames.resolve(this, localizations);
}

abstract final class _GenericTypeDisplayNames {
  static final Map<String, String Function(AppLocalizations)> _labelsByName = {
    GenericSupplyType.syringe.name: (l) => l.syringe,
    GenericSupplyType.wipe.name: (l) => l.wipe,
    GenericSupplyType.needle.name: (l) => l.needle,
    GenericSupplyType.gloves.name: (l) => l.gloves,
    GenericSupplyType.bandage.name: (l) => l.bandage,
  };

  static String resolve(
      GenericSupplyType type, AppLocalizations localizations) {
    final labelBuilder = _labelsByName[type.name];
    if (labelBuilder != null) {
      return labelBuilder(localizations);
    }
    final n = type.name;
    return n[0].toUpperCase() + n.substring(1);
  }
}
