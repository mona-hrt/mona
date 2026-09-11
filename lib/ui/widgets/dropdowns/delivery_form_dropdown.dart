import 'package:flutter/material.dart';
import 'package:mona/data/model/delivery_form.dart';
import 'package:mona/i18n/helpers/delivery_form_l10n.dart';

List<DropdownMenuItem<DeliveryForm>> deliveryFormDropdownMenuItems() =>
    DeliveryForm.values
        .map(
          (form) => DropdownMenuItem<DeliveryForm>(
            value: form,
            child: Text(form.localizedName),
          ),
        )
        .toList();
