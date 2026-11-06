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
}
