import 'package:flutter/material.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/i18n/helpers/molecule_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/widgets/dropdown_tile.dart';

class MoleculePicker extends StatelessWidget {
  final Molecule? value;
  final List<Molecule> molecules;
  final ValueChanged<Molecule> onChanged;

  const MoleculePicker({
    super.key,
    required this.value,
    required this.molecules,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropDownTile<Molecule>(
      value: value,
      items: [
        for (final molecule in molecules)
          DropdownTileItem(value: molecule, label: molecule.localizedName),
      ],
      onChanged: onChanged,
      label: t.molecule,
    );
  }
}
