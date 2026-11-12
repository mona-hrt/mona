// SPDX-FileCopyrightText: 2026 Alice Lorido "yakissa" <alice@lori.do>
// SPDX-FileContributor: Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Lesley Caramella "vani11agirl"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:math' as math;

import 'package:clock/clock.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:mona/data/model/graph_blood_test.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/data/providers/blood_test_provider.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/i18n/build_context_extensions.dart';
import 'package:mona/i18n/helpers/units_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/views/levels/chart_time_axis.dart';
import 'package:mona/ui/views/levels/graph_calculator.dart';
import 'package:provider/provider.dart';

class _ChartConstants {
  static const double maxYPadding = 1.1;
  static const double maxYClamp = 50;
  static const double labelFontSize = 12;
  static const double titleFontSize = 14;
  static const double axesPadding = 8.0;
  static const double bottomReservedSize = 40;
  static const double leftReservedSize = 30;
  static const double lineBarWidth = 3;
  static const double tooltipPadding = 6;
  static const double tooltipRadius = 8;
}

class MainGraph extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final bool isPanning;

  MainGraph({
    required this.startDate,
    required this.endDate,
    this.isPanning = false,
  });

  @override
  State<MainGraph> createState() => _MainGraphState();
}

class _MainGraphState extends State<MainGraph> {
  double? _lastMaxY;
  double? _lastMinY;

  @override
  Widget build(BuildContext context) {
    final medicationIntakeProvider = context.watch<MedicationIntakeProvider>();
    final preferencesProvider = context.watch<PreferencesService>();
    final bloodTestProvider = context.watch<BloodTestProvider>();
    final theme = Theme.of(context);
    final unit = preferencesProvider.estradiolUnit;

    if (medicationIntakeProvider.plottableIntakes.isEmpty) {
      return SizedBox.shrink();
    }

    final DateTime now = clock.now();
    final double tNow = chartX(now);
    final double tMin = chartX(widget.startDate);
    final double tMax = chartX(widget.endDate);

    final intakes = medicationIntakeProvider.intakes;
    List<GraphBloodTest> bloodTests =
        bloodTestProvider.getBloodTestsForGraph(unit);

    final List<FlSpot> spots = GraphCalculator().generateLevelsSpots(
      intakes,
      unit,
      tMin: widget.startDate,
      tMax: widget.endDate,
    );
    final List<FlSpot> bloodSpots = GraphCalculator().generateBloodSpots(
      bloodTests,
      tMin: widget.startDate,
      tMax: widget.endDate,
    );
    FlSpot? todaySpot;

    if (tNow >= tMin && tNow <= tMax) {
      final todayConcentration =
          GraphCalculator().totalConcentrationAtTime(now, intakes, unit);
      todaySpot = FlSpot(tNow, todayConcentration);
    }

    final double dataMaxY =
        [...spots, ...bloodSpots].map((s) => s.y).fold(0.0, math.max) *
            _ChartConstants.maxYPadding;
    final double dataMinY = [...spots, ...bloodSpots]
        .map((s) => s.y)
        .fold(double.infinity, math.min);
    final double computedMaxY = math.max(dataMaxY, _ChartConstants.maxYClamp);
    final double maxY =
        widget.isPanning ? (_lastMaxY ?? computedMaxY) : computedMaxY;
    final double minY =
        widget.isPanning ? (_lastMinY ?? dataMinY * 0.75) : dataMinY * 0.75;
    _lastMaxY = maxY;
    _lastMinY = minY;

    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              right: _ChartConstants.axesPadding, left: 2),
          child: RotatedBox(
            quarterTurns: -1,
            child: Text('${t.concentration} (${unit.localizedName})',
                style:
                    const TextStyle(fontSize: _ChartConstants.titleFontSize)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                right: borderPadding, top: 8.0, bottom: 8.0),
            child: LineChart(
              LineChartData(
                minX: tMin,
                maxX: tMax,
                minY: minY,
                maxY: maxY,
                clipData: const FlClipData.all(),
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: theme.colorScheme.outlineVariant,
                    strokeWidth: 0.4,
                    dashArray: const [8, 4],
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: theme.colorScheme.outlineVariant,
                    strokeWidth: 0.4,
                    dashArray: const [8, 4],
                  ),
                ),
                titlesData: _buildTitlesData(context),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                lineBarsData: [
                  _buildLineBarData(spots, theme),
                  _buildBloodTestData(bloodSpots, theme),
                ],
                lineTouchData:
                    _buildLineTouchData(context, theme, unit, bloodTests),
                extraLinesData: _buildTodayVerticalLine(
                    theme, todaySpot, tNow, unit, Directionality.of(context)),
              ),
              duration:
                  widget.isPanning && !preferencesProvider.slimeModeEnabled
                      ? Duration.zero
                      : const Duration(milliseconds: 150),
            ),
          ),
        ),
      ],
    );
  }

  ExtraLinesData? _buildTodayVerticalLine(ThemeData theme, FlSpot? todaySpot,
      double nowX, EstradiolUnit unit, TextDirection textDirection) {
    if (todaySpot == null) return null;

    final nowLabel =
        '${t.chartNowConcentration(value: todaySpot.y.toStringAsFixed(0))} ${unit.localizedName}';

    return ExtraLinesData(
      verticalLines: [
        VerticalLine(
          x: nowX,
          color: theme.colorScheme.tertiary,
          strokeWidth: 2,
          dashArray: [6, 4],
          label: VerticalLineLabel(
            show: true,
            labelResolver: (_) => textDirection == TextDirection.rtl
                ? '\u2067$nowLabel\u2069'
                : nowLabel,
            style: TextStyle(fontSize: 11, color: theme.colorScheme.tertiary),
          ),
        )
      ],
      extraLinesOnTop: true,
    );
  }

  LineChartBarData _buildLineBarData(List<FlSpot> spots, ThemeData theme) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: theme.colorScheme.primary,
      barWidth: _ChartConstants.lineBarWidth,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: theme.colorScheme.primary.withValues(alpha: 0.3),
      ),
    );
  }

  LineChartBarData _buildBloodTestData(
      List<FlSpot> bloodSpots, ThemeData theme) {
    return LineChartBarData(
      spots: bloodSpots,
      isCurved: false,
      color: theme.colorScheme.tertiary,
      barWidth: 0,
      dotData: FlDotData(show: true),
    );
  }

  LineTouchData _buildLineTouchData(BuildContext context, ThemeData theme,
      EstradiolUnit unit, List<GraphBloodTest> bloodTests) {
    return LineTouchData(
      getTouchedSpotIndicator: (barData, spotIndexes) {
        return spotIndexes.map((index) {
          return TouchedSpotIndicatorData(
            FlLine(color: theme.colorScheme.tertiary, strokeWidth: 3),
            FlDotData(
              getDotPainter: (spot, percent, bar, i) => FlDotCirclePainter(
                radius: 8,
                color: theme.colorScheme.tertiary,
              ),
            ),
          );
        }).toList();
      },
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpots) => theme.colorScheme.tertiaryContainer,
        tooltipBorderRadius:
            BorderRadius.circular(_ChartConstants.tooltipRadius),
        tooltipPadding: const EdgeInsets.all(_ChartConstants.tooltipPadding),
        maxContentWidth: 200,
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            String text;
            if (spot.barIndex == 0) {
              text =
                  '${t.chartLevelTooltip(date: _getDateLabel(spot.x, context), level: spot.y.toStringAsFixed(1))} ${unit.localizedName}';
            } else {
              final comparison = bloodTests.comparisonAt(spot.x);
              text =
                  '${t.chartBloodTestLevelTooltip(date: _getDateLabel(spot.x, context), level: '${comparison.prefix}${spot.y.toStringAsFixed(1)}')} ${unit.localizedName}';
            }
            return LineTooltipItem(
              text,
              theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer) ??
                  const TextStyle(),
              textDirection: Directionality.of(context),
            );
          }).toList();
        },
      ),
    );
  }

  FlTitlesData _buildTitlesData(BuildContext context) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: _ChartConstants.bottomReservedSize,
          getTitlesWidget: (value, meta) {
            return SideTitleWidget(
              meta: meta,
              space: _ChartConstants.axesPadding,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Text(
                  _getDateLabel(value, context),
                  style: const TextStyle(
                    fontSize: _ChartConstants.labelFontSize,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: _ChartConstants.leftReservedSize,
          getTitlesWidget: (value, meta) {
            return Text(value.toStringAsFixed(0),
                style:
                    const TextStyle(fontSize: _ChartConstants.labelFontSize));
          },
        ),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  String _getDateLabel(double value, BuildContext context) {
    final date = chartDate(value).toLocal();
    return DateFormat.Md(context.intlLanguageTag).format(date);
  }
}
