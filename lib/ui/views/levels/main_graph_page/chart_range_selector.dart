import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/i18n/translations.g.dart';

class ChartRangeSelector extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexChanged;

  const ChartRangeSelector({
    super.key,
    required this.index,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return M3EToggleButtonGroup(
      type: M3EButtonGroupType.connected,
      size: M3EButtonSize.xs,
      decoration: M3EToggleButtonDecoration.styleFrom(
        haptic: M3EHapticFeedback.light,
      ),
      selectedIndex: index,
      onSelectedIndexChanged: (newIndex) {
        if (newIndex == null) return;
        onIndexChanged(newIndex);
      },
      actions: [
        for (final duration in LevelDuration.values)
          M3EToggleButtonGroupAction(
            label: Text(duration.label),
          ),
      ],
    );
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
