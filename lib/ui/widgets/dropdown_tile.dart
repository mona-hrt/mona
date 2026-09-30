import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class DropdownTileItem<T> {
  final T value;
  final String label;

  const DropdownTileItem({required this.value, required this.label});
}

class DropDownTile<T> extends StatelessWidget {
  final T? value;
  final List<DropdownTileItem<T>> items;
  final ValueChanged<T> onChanged;
  final String label;
  final Widget? trailing;

  const DropDownTile({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
    this.trailing,
  });

  String? get _selectedLabel {
    for (final item in items) {
      if (item.value == value) return item.label;
    }
    return null;
  }

  Future<void> _openSheet(BuildContext context) async {
    final selected = await showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final item in items)
              ListTile(
                title: Text(item.label),
                trailing: item.value == value
                    ? const Icon(Symbols.check_rounded)
                    : null,
                onTap: () => Navigator.of(sheetContext).pop(item.value),
              ),
          ],
        ),
      ),
    );

    if (selected == null || selected == value) return;
    onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedLabel = _selectedLabel;
    final titleStyle = theme.textTheme.bodyLarge;
    final subtitleStyle = theme.textTheme.bodyMedium
        ?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        minTileHeight: 72, // 2-line height to avoid changing height on select
        title: Text(label),
        subtitle: selectedLabel == null ? null : Text(selectedLabel),
        titleTextStyle: selectedLabel == null ? titleStyle : subtitleStyle,
        subtitleTextStyle: titleStyle,
        trailing: trailing ?? const Icon(Symbols.keyboard_arrow_down_rounded),
        onTap: () => _openSheet(context),
      ),
    );
  }
}
