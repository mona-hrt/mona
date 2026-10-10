// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:dart_mappable/dart_mappable.dart';

part 'placement.mapper.dart';

@MappableEnum()
enum PlacementPreset {
  left,
  right,
  leftThigh,
  rightThigh,
  leftArm,
  rightArm,
  leftButtock,
  rightButtock,
  leftAbdomen,
  rightAbdomen,
}

@MappableClass(
    discriminatorKey: 'kind',
    includeSubClasses: [PresetPlacement, CustomPlacement])
sealed class Placement with PlacementMappable {
  const Placement();
}

@MappableClass(discriminatorValue: 'preset')
class PresetPlacement extends Placement with PresetPlacementMappable {
  final PlacementPreset preset;

  const PresetPlacement(this.preset);
}

@MappableClass(discriminatorValue: 'custom')
class CustomPlacement extends Placement with CustomPlacementMappable {
  final String label;

  const CustomPlacement(this.label);
}
