// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/graph_blood_test.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/ui/views/levels/chart_time_axis.dart';
import 'package:mona/ui/views/levels/graph_calculator.dart';

import '../../../fixtures.dart';

void main() {
  final calculator = GraphCalculator();
  const unit = EstradiolUnit.pg_mL;

  MedicationIntake intakeAt(double day) =>
      aSimulatedInjection(day: day, dose: Decimal.fromInt(5));

  group('totalConcentrationAtTime', () {
    test('is zero before the injection offset', () {
      // Act
      final concentration = calculator.totalConcentrationAtTime(
          simulationDay(-1.0), [intakeAt(0.0)], unit);

      // Assert
      expect(concentration, 0.0);
    });

    test('is zero at the injection offset', () {
      // Act
      final concentration = calculator.totalConcentrationAtTime(
          simulationDay(0.0), [intakeAt(0.0)], unit);

      // Assert
      expect(concentration, 0.0);
    });

    test('is positive within the active window', () {
      // Act
      final concentration = calculator.totalConcentrationAtTime(
          simulationDay(2.0), [intakeAt(0.0)], unit);

      // Assert
      expect(concentration, greaterThan(0.0));
    });

    test('returns zero for an empty intake list', () {
      // Act
      final concentration =
          calculator.totalConcentrationAtTime(simulationDay(2.0), [], unit);

      // Assert
      expect(concentration, 0.0);
    });

    test('a fractional offset shifts the curve by exactly that amount', () {
      // Act
      final shifted = calculator.totalConcentrationAtTime(
          simulationDay(2.5), [intakeAt(0.5)], unit);
      final base = calculator.totalConcentrationAtTime(
          simulationDay(2.0), [intakeAt(0.0)], unit);

      // Assert
      expect(shifted, closeTo(base, 1e-9));
    });

    test('sums the contribution of multiple injections', () {
      // Act
      final single = calculator.totalConcentrationAtTime(
          simulationDay(2.0), [intakeAt(0.0)], unit);
      final two = calculator.totalConcentrationAtTime(
          simulationDay(2.0), [intakeAt(0.0), intakeAt(0.0)], unit);

      // Assert
      expect(two, closeTo(2 * single, 1e-6));
    });
  });

  group('expected levels', () {
    final cases = [
      (ester: Ester.enanthate, day: 4.9913, level: 37.584),
      (ester: Ester.enanthate, day: 7.0, level: 35.467),
      (ester: Ester.valerate, day: 1.6922, level: 73.509),
      (ester: Ester.valerate, day: 7.0, level: 27.130),
      (ester: Ester.benzoate, day: 0.4919, level: 260.064),
      (ester: Ester.benzoate, day: 7.0, level: 9.669),
      (ester: Ester.cypionate, day: 3.3899, level: 24.999),
      (ester: Ester.cypionate, day: 7.0, level: 20.476),
      (ester: Ester.cypionateSuspension, day: 0.6513, level: 53.516),
      (ester: Ester.cypionateSuspension, day: 7.0, level: 29.284),
      (ester: Ester.undecylate, day: 0.25, level: 1.654),
      (ester: Ester.undecylate, day: 2.7737, level: 4.912),
      (ester: Ester.undecylate, day: 7.0, level: 4.542),
    ];

    for (final c in cases) {
      test('1 mg ${c.ester.name} is ${c.level} pg/mL on day ${c.day}', () {
        // Arrange
        final intake = aSimulatedInjection(ester: c.ester);

        // Act
        final concentration = calculator.totalConcentrationAtTime(
            simulationDay(c.day), [intake], unit);

        // Assert
        expect(concentration, closeTo(c.level, 1e-3));
      });
    }

    test('1 mg valerate is 269.852 pmol/L at its peak', () {
      // Arrange
      final intake = aSimulatedInjection(ester: Ester.valerate);

      // Act
      final concentration = calculator.totalConcentrationAtTime(
          simulationDay(1.6922), [intake], EstradiolUnit.pmol_L);

      // Assert
      expect(concentration, closeTo(269.852, 1e-3));
    });

    test('100 mg undecylate is still 0.183 pg/mL on day 364', () {
      // Arrange
      final intake = aSimulatedInjection(
          dose: Decimal.fromInt(100), ester: Ester.undecylate);

      // Act
      final concentration = calculator.totalConcentrationAtTime(
          simulationDay(364.0), [intake], unit);

      // Assert
      expect(concentration, closeTo(0.183, 1e-3));
    });
  });

  group('generateLevelsSpots', () {
    test('returns an empty list for no intakes', () {
      // Act
      final spots = calculator.generateLevelsSpots([], unit,
          tMin: simulationDay(0.0), tMax: simulationDay(10.0));

      // Assert
      expect(spots, isEmpty);
    });

    test('produces numPoints + 1 spots', () {
      // Act
      final spots = calculator.generateLevelsSpots([intakeAt(0.0)], unit,
          tMin: simulationDay(0.0), tMax: simulationDay(10.0), numPoints: 10);

      // Assert
      expect(spots.length, 11);
    });

    test('samples up to an explicit tMax when provided', () {
      // Act
      final spots = calculator.generateLevelsSpots([intakeAt(0.0)], unit,
          tMin: simulationDay(0.0), tMax: simulationDay(10.0), numPoints: 10);

      // Assert
      expect(spots.last.x, chartX(simulationDay(10.0)));
    });

    test('starts sampling at tMin when provided', () {
      // Act
      final spots = calculator.generateLevelsSpots([intakeAt(0.0)], unit,
          tMin: simulationDay(5.0), tMax: simulationDay(10.0), numPoints: 10);

      // Assert
      expect(spots.first.x, chartX(simulationDay(5.0)));
    });

    test('a window after the injection still reflects the earlier intake', () {
      // Arrange
      final intakes = [
        aSimulatedInjection(dose: Decimal.fromInt(5), ester: Ester.valerate)
      ];

      // Act
      final spots = calculator.generateLevelsSpots(intakes, unit,
          tMin: simulationDay(5.0), tMax: simulationDay(10.0), numPoints: 10);

      // Assert
      expect(spots.every((s) => s.y > 0.0), isTrue);
    });
  });

  group('generateBloodSpots', () {
    test('returns an empty list for no blood tests', () {
      // Act
      final spots = calculator.generateBloodSpots([],
          tMin: simulationDay(0.0), tMax: simulationDay(10.0));

      // Assert
      expect(spots, isEmpty);
    });

    test('maps each blood test to a spot at (chartX(dateTime), level)', () {
      // Act
      final spots = calculator.generateBloodSpots(
          [GraphBloodTest(dateTime: simulationDay(1.5), level: 120.0)],
          tMin: simulationDay(0.0), tMax: simulationDay(10.0));

      // Assert
      expect(
          spots.single,
          isA<FlSpot>()
              .having((s) => s.x, 'x', chartX(simulationDay(1.5)))
              .having((s) => s.y, 'y', 120.0));
    });

    test('keeps only blood tests within the tMin/tMax range', () {
      // Arrange
      final tests = [
        GraphBloodTest(dateTime: simulationDay(1.0), level: 100.0),
        GraphBloodTest(dateTime: simulationDay(5.0), level: 200.0),
        GraphBloodTest(dateTime: simulationDay(9.0), level: 300.0),
      ];

      // Act
      final spots = calculator.generateBloodSpots(tests,
          tMin: simulationDay(2.0), tMax: simulationDay(8.0));

      // Assert
      expect(spots.single.y, 200.0);
    });

    test('includes blood tests exactly on the range bounds', () {
      // Arrange
      final tests = [
        GraphBloodTest(dateTime: simulationDay(2.0), level: 100.0),
        GraphBloodTest(dateTime: simulationDay(8.0), level: 300.0),
      ];

      // Act
      final spots = calculator.generateBloodSpots(tests,
          tMin: simulationDay(2.0), tMax: simulationDay(8.0));

      // Assert
      expect(spots.length, 2);
    });
  });

  group('comparisonAt', () {
    final bloodTests = [
      GraphBloodTest(level: 200, dateTime: simulationDay(1.0)),
      GraphBloodTest(
          level: 5,
          dateTime: simulationDay(4.5),
          comparison: ValueComparison.below),
    ];

    final cases = [
      (day: 4.5, expected: ValueComparison.below),
      (day: 1.0, expected: ValueComparison.equal),
      (day: 2.0, expected: ValueComparison.equal),
    ];

    for (final c in cases) {
      test('on day ${c.day} is ${c.expected.name}', () {
        // Act
        final comparison =
            bloodTests.comparisonAt(chartX(simulationDay(c.day)));

        // Assert
        expect(comparison, c.expected);
      });
    }
  });
}
