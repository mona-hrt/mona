// SPDX-FileCopyrightText: 2026 Eva Tatarka "evant" <eva@tatarka.me>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/units.dart';

void main() {
  group('UnitValue', () {
    final estradiolCases = [
      (
        value: '200',
        from: EstradiolUnit.pg_mL,
        into: EstradiolUnit.pg_mL,
        expected: '200'
      ),
      (
        value: '200',
        from: EstradiolUnit.pg_mL,
        into: EstradiolUnit.pmol_L,
        expected: '734.2'
      ),
      (
        value: '700',
        from: EstradiolUnit.pmol_L,
        into: EstradiolUnit.pg_mL,
        expected: '190.68'
      ),
      (
        value: '200',
        from: EstradiolUnit.ng_L,
        into: EstradiolUnit.pg_mL,
        expected: '200'
      ),
      (
        value: '200',
        from: EstradiolUnit.pg_mL,
        into: EstradiolUnit.ng_L,
        expected: '200'
      ),
      (
        value: '200',
        from: EstradiolUnit.ng_L,
        into: EstradiolUnit.pmol_L,
        expected: '734.2'
      ),
    ];

    for (final c in estradiolCases) {
      test('estradiol converts ${c.value} ${c.from} to ${c.into}', () {
        // Arrange
        final level = UnitValue(Decimal.parse(c.value), c.from);

        // Act
        final converted = level.inUnit(c.into);

        // Assert
        expect(converted, Decimal.parse(c.expected));
      });
    }

    final testosteroneCases = [
      (
        value: '250',
        from: TestosteroneUnit.ng_dL,
        into: TestosteroneUnit.ng_dL,
        expected: '250'
      ),
      (
        value: '250',
        from: TestosteroneUnit.ng_dL,
        into: TestosteroneUnit.nmol_L,
        expected: '8.66'
      ),
      (
        value: '8',
        from: TestosteroneUnit.nmol_L,
        into: TestosteroneUnit.ng_mL,
        expected: '2.3072'
      ),
      (
        value: '8',
        from: TestosteroneUnit.ng_dL,
        into: TestosteroneUnit.ng_mL,
        expected: '0.08'
      ),
      (
        value: '8',
        from: TestosteroneUnit.nmol_L,
        into: TestosteroneUnit.ng_dL,
        expected: '230.72'
      ),
      (
        value: '2.5',
        from: TestosteroneUnit.ug_L,
        into: TestosteroneUnit.ng_mL,
        expected: '2.5'
      ),
      (
        value: '2.5',
        from: TestosteroneUnit.ng_mL,
        into: TestosteroneUnit.ug_L,
        expected: '2.5'
      ),
      (
        value: '2.5',
        from: TestosteroneUnit.ug_L,
        into: TestosteroneUnit.ng_dL,
        expected: '250'
      ),
      (
        value: '2.5',
        from: TestosteroneUnit.ug_L,
        into: TestosteroneUnit.nmol_L,
        expected: '8.66'
      ),
    ];

    for (final c in testosteroneCases) {
      test('testosterone converts ${c.value} ${c.from} to ${c.into}', () {
        // Arrange
        final level = UnitValue(Decimal.parse(c.value), c.from);

        // Act
        final converted = level.inUnit(c.into);

        // Assert
        expect(converted, Decimal.parse(c.expected));
      });
    }

    test('levels with different comparisons are not equal', () {
      // Arrange
      final below = UnitValue(20.toDecimal(), EstradiolUnit.pg_mL,
          comparison: ValueComparison.below);

      // Act
      final isEqual = below == UnitValue(20.toDecimal(), EstradiolUnit.pg_mL);

      // Assert
      expect(isEqual, false);
    });

    final displayCases = [
      (comparison: ValueComparison.equal, expected: '20'),
      (comparison: ValueComparison.below, expected: '≤\u00A020'),
      (comparison: ValueComparison.above, expected: '≥\u00A020'),
    ];

    for (final c in displayCases) {
      test('${c.comparison.name} level displays as ${c.expected}', () {
        // Arrange
        final level = UnitValue(20.toDecimal(), EstradiolUnit.pg_mL,
            comparison: c.comparison);

        // Act
        final text = level.displayValue;

        // Assert
        expect(text, c.expected);
      });
    }
  });
}
