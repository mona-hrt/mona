import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/model/injection_type.dart';
import 'package:mona/i18n/helpers/injection_type_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/widgets/dropdown_tile.dart';

class InjectionTypePicker extends StatelessWidget {
  final InjectionType value;
  final ValueChanged<InjectionType> onChanged;

  const InjectionTypePicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropDownTile<InjectionType>(
      value: value,
      items: [
        for (final type in InjectionType.values)
          DropdownTileItem(value: type, label: type.localizedName),
      ],
      onChanged: onChanged,
      label: t.injectionType,
      trailing: const Icon(Symbols.syringe_rounded),
    );
  }
}
