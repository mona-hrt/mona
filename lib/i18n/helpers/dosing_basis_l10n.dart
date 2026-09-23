import 'package:mona/data/model/dosing_basis.dart';
import 'package:mona/i18n/translations.g.dart';

extension DosingBasisL10n on DosingBasis {
  String get localizedName => switch (this) {
        DosingBasis.mass => t.dosingBasisMass,
        DosingBasis.releaseRate => t.dosingBasisReleaseRate,
      };
}
