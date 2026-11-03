// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/ui/widgets/forms/form_level_field.dart';

void main() {
  Widget levelField(
    ValueComparison comparison, {
    ValueChanged<ValueComparison>? onComparisonChanged,
  }) =>
      MaterialApp(
        home: Scaffold(
          body: FormLevelField(
            controller: TextEditingController(),
            comparison: comparison,
            onComparisonChanged: onComparisonChanged ?? (_) {},
            onChanged: () {},
            label: 'Estradiol level',
          ),
        ),
      );

  final symbolCases = [
    (comparison: ValueComparison.equal, symbol: '='),
    (comparison: ValueComparison.below, symbol: '≤'),
    (comparison: ValueComparison.above, symbol: '≥'),
  ];

  for (final c in symbolCases) {
    testWidgets('${c.comparison.name} shows ${c.symbol} on the button',
        (tester) async {
      // Arrange
      await tester.pumpWidget(levelField(c.comparison));

      // Act
      final button = find.widgetWithText(M3EButton, c.symbol);

      // Assert
      expect(button, findsOneWidget);
    });
  }

  final cycleCases = [
    (comparison: ValueComparison.equal, next: ValueComparison.below),
    (comparison: ValueComparison.below, next: ValueComparison.above),
    (comparison: ValueComparison.above, next: ValueComparison.equal),
  ];

  for (final c in cycleCases) {
    testWidgets('a tap on ${c.comparison.name} reports ${c.next.name}',
        (tester) async {
      // Arrange
      ValueComparison? result;
      await tester.pumpWidget(levelField(
        c.comparison,
        onComparisonChanged: (comparison) => result = comparison,
      ));

      // Act
      await tester.tap(find.byType(M3EButton));
      await tester.pump();

      // Assert
      expect(result, c.next);
    });
  }
}
