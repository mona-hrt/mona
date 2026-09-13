import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/ui/widgets/tappable_list_tile.dart';

class TimeListCard extends StatelessWidget {
  final List<TimeOfDay> times;
  final IconData rowIcon;
  final String addLabel;
  final VoidCallback onAdd;
  final ValueChanged<int> onEdit;
  final ValueChanged<int> onDelete;
  final List<Widget> trailingChildren;
  final Key? addTileKey;

  const TimeListCard({
    super.key,
    required this.times,
    required this.rowIcon,
    required this.addLabel,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    this.trailingChildren = const [],
    this.addTileKey,
  });

  @override
  Widget build(BuildContext context) {
    final addCardIndex = times.length;
    return M3ESegmentedColumn(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(vertical: 8),
      onTap: (index) {
        if (index == addCardIndex) onAdd();
      },
      children: [
        for (int i = 0; i < times.length; i++)
          TappableListTile(
            leading: Icon(rowIcon),
            title: times[i].format(context),
            onTap: () => onEdit(i),
            trailing: IconButton(
              icon: const Icon(Symbols.delete_outline_rounded),
              onPressed: () => onDelete(i),
            ),
          ),
        TappableListTile(
          key: addTileKey,
          leading: const Icon(Symbols.add_rounded),
          title: addLabel,
          onTap: onAdd,
        ),
        ...trailingChildren,
      ],
    );
  }
}
