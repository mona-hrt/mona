import 'package:flutter/material.dart';
import 'package:mona/data/model/delivery_form.dart';
import 'package:mona/i18n/helpers/delivery_form_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/widgets/dropdown_tile.dart';

class DeliveryFormPicker extends StatelessWidget {
  final DeliveryForm? value;
  final ValueChanged<DeliveryForm> onChanged;

  const DeliveryFormPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropDownTile<DeliveryForm>(
      value: value,
      items: [
        for (final form in DeliveryForm.values)
          DropdownTileItem(value: form, label: form.localizedName),
      ],
      onChanged: onChanged,
      label: t.deliveryForm,
    );
  }
}
