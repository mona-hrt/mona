import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/constants/dimensions.dart';

import 'package:mona/ui/views/levels/main_graph_page/chart_date_buttons.dart';
import 'package:mona/ui/views/levels/main_graph_page/chart_graph.dart';
import 'package:mona/ui/views/levels/main_graph_page/chart_range_selector.dart';
import 'package:mona/ui/widgets/liquid_glass_bottom_clamp.dart';
import 'package:mona/ui/widgets/main_page_wrapper.dart';
import 'package:mona/ui/widgets/minute_ticker.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatefulWidget {
  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> with MinuteTicker {
  LevelDuration _duration = LevelDuration.twoWeeks;
  DateTime targetDate = clock.now().subtract(const Duration(days: 2));
  bool _isPanning = false;

  @override
  Widget build(BuildContext context) {
    final dayBoundaries = _dayBoundaries();

    return LiquidGlassBottomClamp(
      child: Scaffold(
        appBar: AppBar(title: Text(t.estradiolLevelsTitle)),
        body: Consumer<MedicationIntakeProvider>(
            builder: (context, medicationIntakeProvider, child) {
          return SafeArea(
            child: MainPageWrapper(
              isLoading: medicationIntakeProvider.isLoading,
              isEmpty: medicationIntakeProvider.plottableIntakes.isEmpty,
              emptyMessage: "",
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: borderPadding),
                    child: ChartRangeSelector(
                      index: _duration.index,
                      onIndexChanged: (index) => setState(() {
                        _duration = LevelDuration.values[index];
                      }),
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GestureDetector(
                          onHorizontalDragStart: (_) =>
                              setState(() => _isPanning = true),
                          onHorizontalDragUpdate: (details) {
                            final width = constraints.maxWidth;
                            if (width <= 0) return;
                            final shift = _duration.days.inMicroseconds *
                                ((details.primaryDelta ?? 0) / width);
                            setState(() {
                              targetDate = targetDate.subtract(
                                Duration(microseconds: shift.round()),
                              );
                            });
                          },
                          onHorizontalDragEnd: (_) =>
                              setState(() => _isPanning = false),
                          child: MainGraph(
                            startDate: dayBoundaries.$1,
                            endDate: dayBoundaries.$2,
                            isPanning: _isPanning,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 8.0,
                        left: borderPadding,
                        right: borderPadding,
                        bottom: 24),
                    child: ChartDateButtons(
                      index: _duration.index,
                      startDate: targetDate,
                      onStartDateChanged: (newTargetDate) => setState(() {
                        targetDate = newTargetDate;
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  (DateTime, DateTime) _dayBoundaries() {
    final (daysBefore, daysAfter) = switch (_duration) {
      LevelDuration.week => (3, 3),
      LevelDuration.twoWeeks => (7, 6),
      LevelDuration.month => (15, 14),
      LevelDuration.threeMonths => (45, 44),
      LevelDuration.sixMonths => (90, 89),
      LevelDuration.year => (182, 182),
    };

    return (
      targetDate.subtract(Duration(days: daysBefore)),
      targetDate.add(Duration(days: daysAfter)),
    );
  }
}
