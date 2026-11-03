// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/ui/views/levels/blood_test_chart_page/bar_chart_graph.dart';

void main() {
  testWidgets('tooltip shows the comparison sign of the touched bar',
      (tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BarChartGraph(
          spots: const [FlSpot(0, 200), FlSpot(1, 5)],
          comparisons: const [ValueComparison.equal, ValueComparison.below],
          labels: const ['May 1', 'May 4'],
          unit: 'pg/mL',
        ),
      ),
    ));
    final data = tester.widget<BarChart>(find.byType(BarChart)).data;
    final group = data.barGroups.firstWhere((group) => group.x == 1);

    // Act
    final item = data.barTouchData.touchTooltipData
        .getTooltipItem(group, 1, group.barRods.single, 0);

    // Assert
    expect(item!.text, '≤\u00A05.0\npg/mL');
  });
}
