import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/model/injection_type.dart';
import 'package:mona/i18n/helpers/injection_type_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/widgets/tappable_list_tile.dart';

class InjectionTypePicker extends StatelessWidget {
  final InjectionType value;
  final ValueChanged<InjectionType> onChanged;

  const InjectionTypePicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  Future<void> _openTypeSheet(BuildContext context) async {
    final selected = await showModalBottomSheet<InjectionType>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final type in InjectionType.values)
              ListTile(
                title: Text(type.localizedName),
                trailing:
                    type == value ? const Icon(Symbols.check_rounded) : null,
                onTap: () => Navigator.of(sheetContext).pop(type),
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
    return M3ESegmentedColumn(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(vertical: 8),
      children: [
        TappableListTile(
          title: value.localizedName,
          subtitle: t.injectionType,
          trailing: const Icon(Symbols.syringe_rounded),
          onTap: () => _openTypeSheet(context),
        ),
      ],
    );
  }
}
