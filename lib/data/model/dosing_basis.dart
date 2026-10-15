// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:dart_mappable/dart_mappable.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/molecule.dart';

part 'dosing_basis.mapper.dart';

@MappableEnum()
enum DosingBasis { mass, releaseRate }

bool supportsReleaseRate(Molecule molecule, AdministrationRoute route) =>
    molecule.rateUnit != null && route == AdministrationRoute.patch;
