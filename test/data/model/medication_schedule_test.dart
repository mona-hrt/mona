// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/l10n/app_localizations_en.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('MedicationSchedule', () {
    test('validateEster works correctly', () {
      final cases = [
        {
          'molecule': null,
          'route': null,
          'value': null,
          'expected': isNull,
        },
        {
          'molecule': KnownMolecules.estradiol,
          'route': AdministrationRoute.injection,
          'value': null,
          'expected': isNotNull,
        },
        {
          'molecule': KnownMolecules.estradiol,
          'route': AdministrationRoute.injection,
          'value': Ester.enanthate,
          'expected': isNull,
        },
        {
          'molecule': KnownMolecules.estradiol,
          'route': AdministrationRoute.oral,
          'value': Ester.enanthate,
          'expected': isNull,
        },
        {
          'molecule': KnownMolecules.estradiol,
          'route': AdministrationRoute.oral,
          'value': null,
          'expected': isNull,
        },
      ];

      final results = cases.map((c) {
        final validator = MedicationSchedule.esterValidator(
          l10n,
          c['molecule'] as Molecule?,
          c['route'] as AdministrationRoute?,
        );
        return validator(c['value'] as Ester?);
      }).toList();
      final expected = cases.map((c) => c['expected'] as Matcher).toList();

      expect(results, expected);
    });
  });
}
