// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileCopyrightText: 2026 Alice Lorido "yakissa" <alice@lori.do>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<BarChartGroupData> buildBarGroups(
  List<FlSpot> spots, {
  required double barWidth,
  required int? highlightedIndex,
  required Color barColor,
  required Color highlightColor,
  required bool mirror,
}) {
  final groups = spots
      .asMap()
      .entries
      .map(
        (entry) => BarChartGroupData(
          x: entry.key,
          barRods: [
            BarChartRodData(
              toY: entry.value.y,
              width: barWidth,
              color: entry.key == highlightedIndex ? highlightColor : barColor,
            ),
          ],
        ),
      )
      .toList();
  return mirror ? groups.reversed.toList() : groups;
}
