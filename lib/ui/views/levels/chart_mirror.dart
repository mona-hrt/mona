import 'package:fl_chart/fl_chart.dart';

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
