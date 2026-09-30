import 'package:flutter/material.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/i18n/helpers/ester_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/widgets/dropdown_tile.dart';

class EsterPicker extends StatelessWidget {
  final Ester? value;
  final ValueChanged<Ester> onChanged;

  const EsterPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropDownTile<Ester>(
      value: value,
      items: [
        for (final ester in Ester.values)
          DropdownTileItem(value: ester, label: ester.localizedName),
      ],
      onChanged: onChanged,
      label: t.ester,
    );
  }
}
