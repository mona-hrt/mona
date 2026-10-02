import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

double mirrorX(double x, {required double minX, required double maxX}) =>
    minX + maxX - x;

List<FlSpot> mirrorSpots(
  List<FlSpot> spots, {
  required double minX,
  required double maxX,
}) =>
    [
      for (final spot in spots.reversed)
        spot.copyWith(x: mirrorX(spot.x, minX: minX, maxX: maxX)),
    ];

class ChartMirror {
  final bool enabled;
  final double minX;
  final double maxX;

  ChartMirror.of(BuildContext context, {required this.minX, required this.maxX})
      : enabled = Directionality.of(context) == TextDirection.rtl;

  double mirrored(double x) => enabled ? mirrorX(x, minX: minX, maxX: maxX) : x;

  List<FlSpot> mirroredSpots(List<FlSpot> spots) =>
      enabled ? mirrorSpots(spots, minX: minX, maxX: maxX) : spots;
}
