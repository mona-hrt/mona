// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'dart:math' as math;

import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/calculator/hormone_simulation.dart';
import 'package:mona/data/model/calculator/injection_params.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/hormone.dart';
import 'package:mona/data/model/molecule.dart';

import '../../../fixtures.dart';

void main() {
  group('HormoneSimulation', () {
    test('uses the params it is given', () {
      // Arrange
      final intakes = [aSimulatedInjection(ester: Ester.valerate)];
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
      final level = HormoneSimulation(intakes, params, simulationOrigin)
          .levelAt(Hormone.estradiol, 1.6922);

      // Assert
      expect(level, closeTo(2 * 73.509, 1e-3));
    });

    test('counts the days from its origin', () {
      // Arrange
      final intakes = [aSimulatedInjection(day: 1.0)];

      // Act
      final level =
          HormoneSimulation(intakes, defaultInjectionParams, simulationOrigin)
              .levelAt(Hormone.estradiol, 2.6922);

      // Assert
      expect(level, closeTo(73.509, 1e-3));
    });

    test(
        'adds nothing to the estradiol level for an intake it does not simulate',
        () {
      // Arrange
      final intakes = [
        aSimulatedInjection(),
        aSimulatedInjection()
            .copyWith(administrationRoute: AdministrationRoute.patch),
      ];

      // Act
      final level =
          HormoneSimulation(intakes, defaultInjectionParams, simulationOrigin)
              .levelAt(Hormone.estradiol, 1.6922);

      // Assert
      expect(level, closeTo(73.509, 1e-3));
    });

    test('the testosterone level ignores estradiol doses', () {
      // Arrange
      final intakes = [aSimulatedInjection(ester: Ester.valerate)];

      // Act
      final level =
          HormoneSimulation(intakes, defaultInjectionParams, simulationOrigin)
              .levelAt(Hormone.testosterone, 1.6922);

      // Assert
      expect(level, 0.0);
    });
  });

  group('isSimulated', () {
    final injection = aSimulatedInjection();

    final cases = [
      (
        intake: 'an estradiol injection with an ester',
        value: injection,
        expected: true,
      ),
      (
        intake: 'a testosterone injection',
        value: injection.copyWith(molecule: KnownMolecules.testosterone),
        expected: false,
      ),
      (
        intake: 'an injection with no ester',
        value: injection.copyWith(ester: null),
        expected: false,
      ),
      (
        intake: 'an estradiol patch',
        value:
            injection.copyWith(administrationRoute: AdministrationRoute.patch),
        expected: false,
      ),
      (
        intake: 'an injection not taken',
        value: injection.copyWith(takenDateTime: null, takenTimeZone: null),
        expected: false,
      ),
      (
        intake: 'an injection of -1 mg',
        value: injection.copyWith(takenDose: Decimal.fromInt(-1)),
        expected: false,
      ),
      (
        intake: 'an injection of 0 mg',
        value: injection.copyWith(takenDose: Decimal.zero),
        expected: false,
      ),
      (
        intake: 'an injection of 1e400 mg',
        value: injection.copyWith(
            takenDose: Decimal.fromBigInt(BigInt.from(10).pow(400))),
        expected: false,
      ),
    ];

    for (final c in cases) {
      test('${c.intake} is simulated: ${c.expected}', () {
        // Act
        final simulated = isSimulated(c.value);

        // Assert
        expect(simulated, c.expected);
      });
    }
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

    test('1 mg valerate is zero ln(1e6) / k1 days after the injection', () {
      // Arrange
      final valerate = defaultInjectionParams[Ester.valerate]!;
      final inactiveWindow = math.log(1e6) / valerate.k1;

      // Act
      final level = singleInjectionConcentration(valerate, 1.0, inactiveWindow);

      // Assert
      expect(level, 0.0);
    });

    test('100 mg undecylate is still 0.083 pg/mL on day 400', () {
      // Arrange
      final undecylate = defaultInjectionParams[Ester.undecylate]!;

      // Act
      final level = singleInjectionConcentration(undecylate, 100.0, 400.0);

      // Assert
      expect(level, closeTo(0.083385, 1e-6));
    });
  });
}
