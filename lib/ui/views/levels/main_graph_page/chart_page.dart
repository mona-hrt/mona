import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';

import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/i18n/translations.g.dart';

import 'package:mona/ui/views/levels/main_graph_page/chart_buttons.dart';
import 'package:mona/ui/views/levels/main_graph_page/chart_graph.dart';
import 'package:mona/ui/widgets/button_date_picker.dart';
import 'package:mona/ui/widgets/main_page_wrapper.dart';
import 'package:mona/ui/widgets/minute_ticker.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatefulWidget {
  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> with MinuteTicker {
  double sliderValue = 0;
  LevelDuration _duration = LevelDuration.week;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));

  void _shiftWindow(int direction) {
    setState(() {
      startDate = startDate.add(_offset * direction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Expanded(
                  child: ChartButtons(
                    index: _duration.index,
                    onChanged: (index) => setState(
                      () => _duration = LevelDuration.values[index],
                    ),
                  ),
                ),
                Row(
                  children: [
                    M3EButton(
                      style: M3EButtonStyle.filled,
                      size: M3EButtonSize.md,
                      shape: M3EButtonShape.round,
                      onPressed: () {
                        _shiftWindow(-1);
                      },
                      decoration: M3EButtonDecoration.styleFrom(),
                      child: const Icon(Symbols.chevron_left_rounded),
                    ),
                    ButtonDatePicker(
                      datetime: startDate,
                      onChanged: (newDate) {
                        setState(() {
                          startDate = newDate;
                        });
                      },
                      label: t.startDate,
                    ),
                    M3EButton(
                      style: M3EButtonStyle.filled,
                      size: M3EButtonSize.md,
                      shape: M3EButtonShape.round,
                      onPressed: () {
                        _shiftWindow(1);
                      },
                      decoration: M3EButtonDecoration.styleFrom(),
                      child: const Icon(Symbols.chevron_right_rounded),
                    ),
                  ],
                ),
                Expanded(
                  child: MainGraph(
                    startDate: startDate,
                    endDate: startDate.add(_offset),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Duration get _offset {
    switch (_duration) {
      case LevelDuration.week:
        return const Duration(days: 7);
      case LevelDuration.month:
        return const Duration(days: 30);
      case LevelDuration.year:
        return const Duration(days: 365);
    }
  }
}
