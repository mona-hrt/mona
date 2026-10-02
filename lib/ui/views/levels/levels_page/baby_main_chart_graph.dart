import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mona/ui/views/levels/chart_mirror.dart';

class BabyMainChartGraph extends StatelessWidget {
  final List<FlSpot> spots;

  final double? nowX;
  final double? nowY;

  BabyMainChartGraph({required this.spots, this.nowX, this.nowY});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (spots.isEmpty) {
      return const SizedBox.shrink();
    }

    final mirror = ChartMirror.of(context);
    final minY = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);

    return LineChart(
      LineChartData(
        minY: minY * 0.75,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: _titlesData(),
        lineTouchData: LineTouchData(enabled: false),
        extraLinesData: _nowLine(theme, mirror),
        lineBarsData: [
          LineChartBarData(
            spots: mirror.mirroredSpots(spots),
            isCurved: true,
            color: theme.colorScheme.primary,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
          ),
          if (nowX != null) _nowDotBar(theme, mirror),
        ],
      ),
    );
  }

  ExtraLinesData? _nowLine(ThemeData theme, ChartMirror mirror) {
    if (nowX == null) return null;

    return ExtraLinesData(
      verticalLines: [
        VerticalLine(
          x: mirror.mirrored(nowX!),
          color: theme.colorScheme.tertiary,
          strokeWidth: 2,
          dashArray: [6, 4],
        ),
      ],
    );
  }

  LineChartBarData _nowDotBar(ThemeData theme, ChartMirror mirror) {
    return LineChartBarData(
      spots: [FlSpot(mirror.mirrored(nowX!), nowY ?? 0)],
      barWidth: 0,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
          radius: 8,
          color: theme.colorScheme.tertiary,
        ),
      ),
    );
  }

  FlTitlesData _titlesData() => FlTitlesData(
        show: true,
        bottomTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );
}
