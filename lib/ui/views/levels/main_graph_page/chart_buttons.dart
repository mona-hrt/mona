import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/views/supplies/supply_item_card.dart';
import 'package:mona/ui/widgets/main_page_wrapper.dart';
import 'package:provider/provider.dart';

class ChartButtons extends StatefulWidget {
  final int index;
  final Function(int) onChanged;

  const ChartButtons({super.key, required this.index, required this.onChanged});

  @override
  State<ChartButtons> createState() => _ChartButtonsState();
}

class _ChartButtonsState extends State<ChartButtons> {
  @override
  Widget build(BuildContext context) {
    return M3EToggleButtonGroup(
      type: M3EButtonGroupType.connected,
      size: M3EButtonSize.md,
      decoration: M3EToggleButtonDecoration.styleFrom(
        haptic: M3EHapticFeedback.light,
      ),
      selectedIndex: widget.index,
      onSelectedIndexChanged: (index) {
        if (index == null) return;
        widget.onChanged(index);
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

enum LevelDuration { week, month, year }

extension _DurationLabel on LevelDuration {
  String get label => switch (this) {
        LevelDuration.week => t.week,
        LevelDuration.month => t.month,
        LevelDuration.year => t.year,
      };
}
