import 'package:flutter/material.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/i18n/helpers/generic_type_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/widgets/dropdown_tile.dart';

class GenericTypePicker extends StatelessWidget {
  final GenericSupplyType? value;
  final ValueChanged<GenericSupplyType> onChanged;

  const GenericTypePicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropDownTile<GenericSupplyType>(
      value: value,
      items: [
        for (final type in GenericSupplyType.values)
          DropdownTileItem(value: type, label: type.localizedName),
      ],
      onChanged: onChanged,
      label: t.supplyType,
    );
  }
}
