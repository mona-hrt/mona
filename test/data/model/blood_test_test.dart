// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/blood_test.dart';
import 'package:mona/data/model/units.dart';

void main() {
  group('BloodTest', () {
    test('constructor throws if dateTime is not UTC', () {
      // Arrange
      final localDateTime = DateTime(2024, 1, 1);

      // Act & Assert
      expect(
        () => BloodTest(
          id: 1,
          dateTime: localDateTime,
          timeZone: 'Etc/UTC',
        ),
        throwsArgumentError,
      );
    });

    group('level comparison storage', () {
      Map<String, Object?> row(String estradiolLevels) => {
            'id': 1,
            'dateTime': '2025-03-14T06:07:00.000Z',
            'timeZone': 'Etc/UTC',
            'estradiolLevels': estradiolLevels,
            'testosteroneLevels': null,
            'notes': null,
          };

      final cases = [
        (
          json: '{"value":"5","unit":"pg/mL","comparison":"below"}',
          expected: ValueComparison.below,
        ),
        (
          json: '{"value":"3000","unit":"pg/mL","comparison":"above"}',
          expected: ValueComparison.above,
        ),
        (
          json: '{"value":"200","unit":"pg/mL","comparison":"equal"}',
          expected: ValueComparison.equal,
        ),
        (
          json: '{"value":"200","unit":"pg/mL"}',
          expected: ValueComparison.equal,
        ),
      ];

      for (final c in cases) {
        test('estradiol ${c.json} reads as ${c.expected}', () {
          // Arrange
          final map = row(c.json);

          // Act
          final bloodTest = BloodTestMapper.fromMap(map);

          // Assert
          expect(bloodTest.estradiolLevels!.comparison, c.expected);
        });
      }
    });
  });
}
