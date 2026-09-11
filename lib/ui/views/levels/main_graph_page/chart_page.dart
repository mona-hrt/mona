import 'package:flutter/material.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/views/levels/main_graph_page/chart_buttons.dart';
import 'package:mona/ui/views/levels/main_graph_page/chart_graph.dart';
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
                ChartButtons(
                  index: _duration.index,
                  onChanged: (index) =>
                      setState(() => _duration = LevelDuration.values[index]),
                ),
                Expanded(
                    child: MainGraph(
                        startDate: startDate, endDate: startDate.add(_offset))),
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
