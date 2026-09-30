import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/i18n/helpers/administration_route_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/widgets/dropdown_tile.dart';

class AdministrationRoutePicker extends StatelessWidget {
  final AdministrationRoute? value;
  final ValueChanged<AdministrationRoute> onChanged;

  const AdministrationRoutePicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropDownTile<AdministrationRoute>(
      value: value,
      items: [
        for (final route in AdministrationRoute.values)
          DropdownTileItem(value: route, label: route.localizedName),
      ],
      onChanged: onChanged,
      label: t.adminRoute,
    );
  }
}
