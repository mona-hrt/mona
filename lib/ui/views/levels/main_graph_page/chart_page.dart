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
  double sliderValue = 0;
  LevelDuration _duration = LevelDuration.twoWeeks;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 9));
  bool _isPanning = false;

  @override
  Widget build(BuildContext context) {
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
                            final shift = _offset.inMicroseconds *
                                ((details.primaryDelta ?? 0) / width);
                            setState(() {
                              startDate = startDate.subtract(
                                Duration(microseconds: shift.round()),
                              );
                            });
                          },
                          onHorizontalDragEnd: (_) =>
                              setState(() => _isPanning = false),
                          child: MainGraph(
                            startDate: startDate,
                            endDate: startDate.add(_offset),
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
                      startDate: startDate,
                      onStartDateChanged: (newStartDate) => setState(() {
                        startDate = newStartDate;
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

  Duration get _offset {
    switch (_duration) {
      case LevelDuration.week:
        return const Duration(days: 7);
      case LevelDuration.twoWeeks:
        return const Duration(days: 14);
      case LevelDuration.month:
        return const Duration(days: 30);
      case LevelDuration.threeMonths:
        return const Duration(days: 90);
      case LevelDuration.sixMonths:
        return const Duration(days: 180);
      case LevelDuration.year:
        return const Duration(days: 365);
    }
  }
}
