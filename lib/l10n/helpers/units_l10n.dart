import 'package:mona/data/model/units.dart';
import 'package:mona/l10n/app_localizations.dart';

extension EstradiolUnitL10n on EstradiolUnit {
  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case EstradiolUnit.pg_mL:
        return l10n.unitPgPerMl;
      case EstradiolUnit.pmol_L:
        return l10n.unitPmolPerL;
    }
  }
}

extension TestosteroneUnitL10n on TestosteroneUnit {
  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case TestosteroneUnit.ng_dL:
        return l10n.unitNgPerDl;
      case TestosteroneUnit.nmol_L:
        return l10n.unitNmolPerL;
    }
  }
}

extension UnitsL10n on Units {
  String localizedName(AppLocalizations l10n) =>
      '${estradiol.localizedName(l10n)} & ${testosterone.localizedName(l10n)}';
}
