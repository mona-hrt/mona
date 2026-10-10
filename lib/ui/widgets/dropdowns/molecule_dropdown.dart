// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter/material.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/i18n/helpers/molecule_l10n.dart';

List<DropdownMenuItem<Molecule>> moleculeDropdownMenuItems(
  List<Molecule> molecules,
) =>
    molecules
        .map(
          (molecule) => DropdownMenuItem<Molecule>(
            value: molecule,
            child: Text(molecule.localizedName),
          ),
        )
        .toList();
