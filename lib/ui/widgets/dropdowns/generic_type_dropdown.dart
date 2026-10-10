// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter/material.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/i18n/helpers/generic_type_l10n.dart';

List<DropdownMenuItem<GenericSupplyType>> genericItemTypeDropdownMenuItems() =>
    GenericSupplyType.values
        .map(
          (type) => DropdownMenuItem<GenericSupplyType>(
            value: type,
            child: Text(type.localizedName),
          ),
        )
        .toList();
