import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/i18n/build_context_extensions.dart';
import 'package:mona/ui/views/levels/main_graph_page/chart_range_selector.dart';

class ChartDateButtons extends StatelessWidget {
  final int index;
  final DateTime startDate;
  final ValueChanged<DateTime> onStartDateChanged;

  const ChartDateButtons({
    super.key,
    required this.index,
    required this.startDate,
    required this.onStartDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        M3EButton(
          style: M3EButtonStyle.tonal,
          size: M3EButtonSize.md,
          onPressed: () => _selectDate(context),
          child:
              Text(DateFormat.yMMMd(context.intlLanguageTag).format(startDate)),
        ),
        const SizedBox(width: 8),
        M3EButton(
          style: M3EButtonStyle.filled,
          size: M3EButtonSize.md,
          decoration: M3EButtonDecoration.styleFrom(
            haptic: M3EHapticFeedback.light,
            backgroundColor: theme.colorScheme.secondary,
            foregroundColor: theme.colorScheme.onSecondary,
          ),
          onPressed: _resetToToday,
          child: const Icon(Symbols.today_rounded),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      picked = DateTime(picked.year, picked.month, picked.day, startDate.hour,
          startDate.minute);
      onStartDateChanged(picked);
    }
  }

  void _resetToToday() {
    final duration = LevelDuration.values[index];
    final today = DateTime.now();
    final newStartDate = switch (duration) {
      LevelDuration.week => today.subtract(Duration(days: 3)),
      LevelDuration.twoWeeks => today.subtract(Duration(days: 7)),
      LevelDuration.month => today.subtract(Duration(days: 15)),
      LevelDuration.threeMonths => today.subtract(Duration(days: 45)),
      LevelDuration.sixMonths => today.subtract(Duration(days: 90)),
      LevelDuration.year => today.subtract(Duration(days: 180)),
    };
    onStartDateChanged(newStartDate);
  }
}
