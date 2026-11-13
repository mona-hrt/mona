// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter/material.dart';
import 'package:mona/i18n/translations.g.dart';

enum ConsumableType { syringe, wipe, needle, gloves, bandage }

List<DropdownMenuItem<ConsumableType>> consumableTypeDropdownMenuItems() =>
    ConsumableType.values
        .map(
          (type) => DropdownMenuItem<ConsumableType>(
            value: type,
            child: Text(switch (type) {
              ConsumableType.syringe => t.syringe,
              ConsumableType.wipe => t.wipe,
              ConsumableType.needle => t.needle,
              ConsumableType.gloves => t.gloves,
              ConsumableType.bandage => t.bandage,
            }),
          ),
        )
        .toList();
