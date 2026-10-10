// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/i18n/helpers/administration_route_l10n.dart';
import 'package:mona/i18n/helpers/molecule_l10n.dart';
import 'package:mona/i18n/helpers/placement_l10n.dart';

extension MedicationIntakeL10n on MedicationIntake {
  String get localizedSummary {
    final intakeString = '$takenDose ${molecule.localizedUnit(dosingBasis)} • '
        '${molecule.localizedNameWithEster(ester)} • '
        '${administrationRoute.localizedName}';
    if (placements.isEmpty) return intakeString;

    final placementsString = placements.map((p) => p.localizedName).join(', ');
    return '$intakeString • $placementsString';
  }
}
