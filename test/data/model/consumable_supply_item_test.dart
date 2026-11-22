// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/consumable_supply_item.dart';

void main() {
  group('deadSpaceOf', () {
    final cases = <(SyringeType?, NeedleType?, Decimal?)>[
      (SyringeType.standard, NeedleType.standard, Decimal.fromInt(92)),
      (SyringeType.lowDeadSpace, NeedleType.standard, Decimal.fromInt(59)),
      (SyringeType.standard, NeedleType.lowDeadSpace, Decimal.fromInt(17)),
      (SyringeType.lowDeadSpace, NeedleType.lowDeadSpace, Decimal.fromInt(17)),
      (SyringeType.fixedNeedle, null, Decimal.fromInt(3)),
      (SyringeType.fixedNeedle, NeedleType.standard, Decimal.fromInt(3)),
      (SyringeType.standard, null, null),
      (null, NeedleType.lowDeadSpace, null),
    ];

    for (final (syringeType, needleType, expected) in cases) {
      test('$syringeType syringe with $needleType needle gives $expected', () {
        // Arrange

        // Act
        final result = deadSpaceOf(syringeType, needleType);

        // Assert
        expect(result, expected);
      });
    }
  });
}
