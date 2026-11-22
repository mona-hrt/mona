// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/model/consumable_supply_item.dart';
import 'package:mona/ui/widgets/dropdowns/consumable_type_dropdown.dart';

extension ConsumableTypeIcon on ConsumableType {
  IconData get icon {
    switch (this) {
      case ConsumableType.syringe:
      case ConsumableType.needle:
        return Symbols.syringe_rounded;
      case ConsumableType.wipe:
        return Symbols.note_stack_rounded;
      case ConsumableType.gloves:
        return Symbols.handshake_rounded;
      case ConsumableType.bandage:
        return Symbols.healing_rounded;
    }
  }
}

extension ConsumableSupplyItemIcon on ConsumableSupplyItem {
  IconData get icon => switch (this) {
        Syringe() || Needle() => Symbols.syringe_rounded,
        OtherSupplyItem(otherSupplyType: OtherSupplyType.wipe) =>
          Symbols.note_stack_rounded,
        OtherSupplyItem(otherSupplyType: OtherSupplyType.gloves) =>
          Symbols.handshake_rounded,
        OtherSupplyItem(otherSupplyType: OtherSupplyType.bandage) =>
          Symbols.healing_rounded,
      };
}
