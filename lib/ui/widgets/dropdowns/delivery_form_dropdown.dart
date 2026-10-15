// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

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
