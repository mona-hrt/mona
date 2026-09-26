import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/dosing_basis.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/i18n/helpers/molecule_l10n.dart';

class DosingBasisField extends StatelessWidget {
  final Molecule molecule;
  final AdministrationRoute route;
  final DosingBasis value;
  final ValueChanged<DosingBasis?> onChanged;

  const DosingBasisField({
    super.key,
    required this.molecule,
    required this.route,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (!supportsReleaseRate(molecule, route)) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: M3EToggleButtonGroup(
          type: M3EButtonGroupType.connected,
          selectedIndex: value.index,
          onSelectedIndexChanged: (index) {
            if (index == null) return;
            onChanged(DosingBasis.values[index]);
          },
          actions: [
            for (final basis in DosingBasis.values)
              M3EToggleButtonGroupAction(
                label: Text(molecule.localizedUnit(basis)),
              ),
          ],
        ),
      ),
    );
  }
}
