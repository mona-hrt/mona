// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/calculator/hormone_simulation.dart';
import 'package:mona/data/model/calculator/injection_params.dart';
import 'package:mona/data/model/ester.dart';

void main() {
  group('HormoneSimulation', () {
    test('uses the params it is given', () {
      // Arrange
      const intakes = [
        GraphIntake(dose: 1.0, ester: Ester.valerate, time: 0.0)
      ];
      final valerate = defaultInjectionParams[Ester.valerate]!;
      final params = {
        Ester.valerate: InjectionParams(
          f: 2 * valerate.f,
          auc: valerate.auc,
          k1: valerate.k1,
          k2: valerate.k2,
          k3: valerate.k3,
        ),
      };

      // Act
      final level = HormoneSimulation(intakes, params).levelAt(1.6922);

      // Assert
      expect(level, closeTo(2 * 73.509, 1e-3));
    });
  });

  group('singleInjectionConcentration', () {
    final enanthate = defaultInjectionParams[Ester.enanthate]!;
    final InjectionParams(:k1, :k2, :k3) = enanthate;

    final cases = [
      (rates: 'k1 equal to k3', k1: k3, k2: k2, k3: k3, level: 44.999748),
      (rates: 'k1 equal to k2', k1: k2, k2: k2, k3: k3, level: 18.860433),
      (rates: 'k2 equal to k3', k1: k1, k2: k3, k3: k3, level: 32.944842),
      (rates: 'all rates equal', k1: k3, k2: k3, k3: k3, level: 59.293969),
      (
        rates: 'k1 within 1e-14 of k3',
        k1: k3 * (1 + 1e-14),
        k2: k2,
        k3: k3,
        level: 44.999748,
      ),
    ];

    for (final c in cases) {
      test('1 mg with ${c.rates} is ${c.level} pg/mL on day 7', () {
        // Arrange
        final params = InjectionParams(
          f: enanthate.f,
          auc: enanthate.auc,
          k1: c.k1,
          k2: c.k2,
          k3: c.k3,
        );

        // Act
        final level = singleInjectionConcentration(params, 1.0, 7.0);

        // Assert
        expect(level, closeTo(c.level, 1e-3));
      });
    }
  });
}
