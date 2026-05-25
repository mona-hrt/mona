// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter/material.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/helpers/injection_side_l10n.dart';

List<DropdownMenuItem<InjectionSide>> injectionSideDropdownMenuItems(
  AppLocalizations localizations,
) =>
    InjectionSide.values
        .map(
          (side) => DropdownMenuItem<InjectionSide>(
            value: side,
            child: Text(side.localizedName(localizations)),
          ),
        )
        .toList();
