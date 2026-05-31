import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';

extension GenericTypeL10n on GenericSupplyType {
  String localizedName(AppLocalizations localizations, [num count = 1]) =>
      _GenericTypeDisplayNames.resolve(this, localizations, count);
}

abstract final class _GenericTypeDisplayNames {
  static final Map<String, String Function(AppLocalizations, num)>
      _labelsByName = {
    GenericSupplyType.syringe.name: (l, c) => l.syringe(c),
    GenericSupplyType.wipe.name: (l, c) => l.wipe(c),
    GenericSupplyType.needle.name: (l, c) => l.needle(c),
    GenericSupplyType.gloves.name: (l, c) => l.gloves(c),
    GenericSupplyType.bandage.name: (l, c) => l.bandage(c),
  };

  static String resolve(
      GenericSupplyType type, AppLocalizations localizations, num count) {
    final labelBuilder = _labelsByName[type.name];
    if (labelBuilder != null) {
      return labelBuilder(localizations, count);
    }
    final n = type.name;
    return n[0].toUpperCase() + n.substring(1);
  }
}
