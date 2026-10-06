// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class ChartMirror {
  final bool enabled;

  const ChartMirror({required this.enabled});

  ChartMirror.of(BuildContext context)
      : enabled = Directionality.of(context) == TextDirection.rtl;

  double mirrored(double x) => enabled ? -x : x;

  (double, double) mirroredRange(double minX, double maxX) =>
      enabled ? (-maxX, -minX) : (minX, maxX);

  List<FlSpot> mirroredSpots(List<FlSpot> spots) => enabled
      ? [for (final spot in spots.reversed) spot.copyWith(x: -spot.x)]
      : spots;
}
