import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/i18n/build_context_extensions.dart';
import 'package:mona/i18n/translations.g.dart';

class ChartButtons extends StatefulWidget {
  final int index;
  final DateTime startDate;
  final void Function(int index, DateTime startDate) onChanged;

  const ChartButtons({
    super.key,
    required this.index,
    required this.startDate,
    required this.onChanged,
  });

  @override
  State<ChartButtons> createState() => _ChartButtonsState();
}

class _ChartButtonsState extends State<ChartButtons> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        M3EToggleButtonGroup(
          type: M3EButtonGroupType.connected,
          size: M3EButtonSize.xs,
          decoration: M3EToggleButtonDecoration.styleFrom(
            haptic: M3EHapticFeedback.light,
          ),
          selectedIndex: widget.index,
          onSelectedIndexChanged: (index) {
            if (index == null) return;
            widget.onChanged(index, widget.startDate);
          },
          actions: [
            for (final duration in LevelDuration.values)
              M3EToggleButtonGroupAction(
                label: Text(duration.label),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            M3EButton(
              style: M3EButtonStyle.tonal,
              size: M3EButtonSize.md,
              decoration: M3EButtonDecoration.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
              ),
              onPressed: () => _selectDate(context),
              child: Text(DateFormat.yMMMd(context.intlLanguageTag)
                  .format(widget.startDate)),
            ),
            const SizedBox(width: 8),
            M3EButton(
              style: M3EButtonStyle.filled,
              size: M3EButtonSize.md,
              decoration: M3EButtonDecoration.styleFrom(
                backgroundColor: theme.colorScheme.secondaryContainer,
                foregroundColor: theme.colorScheme.onSecondaryContainer,
              ),
              onPressed: _resetToToday,
              child: const Icon(Symbols.today_rounded),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.startDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      picked = DateTime(picked.year, picked.month, picked.day,
          widget.startDate.hour, widget.startDate.minute);
      widget.onChanged(widget.index, picked);
    }
  }

  void _resetToToday() {
    final duration = LevelDuration.values[widget.index];
    final today = DateTime.now();
    final startDate = switch (duration) {
      LevelDuration.week => today.subtract(Duration(days: 3)),
      LevelDuration.twoWeeks => today.subtract(Duration(days: 7)),
      LevelDuration.month => today.subtract(Duration(days: 15)),
      LevelDuration.threeMonths => today.subtract(Duration(days: 45)),
      LevelDuration.sixMonths => today.subtract(Duration(days: 90)),
      LevelDuration.year => today.subtract(Duration(days: 180)),
    };
    widget.onChanged(widget.index, startDate);
  }
}

enum LevelDuration { week, twoWeeks, month, threeMonths, sixMonths, year }

extension _DurationLabel on LevelDuration {
  String get label => switch (this) {
        LevelDuration.week => t.week,
        LevelDuration.twoWeeks => t.twoWeeks,
        LevelDuration.month => t.month,
        LevelDuration.threeMonths => t.threeMonths,
        LevelDuration.sixMonths => t.sixMonths,
        LevelDuration.year => t.year,
      };
}
