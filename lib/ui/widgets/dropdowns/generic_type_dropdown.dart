import 'package:flutter/material.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/helpers/generic_type_l10n.dart';

List<DropdownMenuItem<GenericSupplyType>> genericItemTypeDropdownMenuItems(
  AppLocalizations localizations,
) =>
    GenericSupplyType.values
        .map(
          (type) => DropdownMenuItem<GenericSupplyType>(
            value: type,
            child: Text(type.localizedName(localizations)),
          ),
        )
        .toList();
