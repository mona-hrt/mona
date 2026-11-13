// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:clock/clock.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/util/validators.dart';

part 'consumable_supply_item.mapper.dart';

@MappableEnum()
enum OtherSupplyType {
  wipe,
  gloves,
  bandage;
}

@MappableClass(includeSubClasses: [Syringe, Needle, OtherSupplyItem])
sealed class ConsumableSupplyItem extends SupplyItem
    with ConsumableSupplyItemMappable {
  @override
  final int id;
  @override
  final String name;
  final int amount;

  ConsumableSupplyItem({
    int? id,
    required this.name,
    required this.amount,
  }) : id = id ?? clock.now().millisecondsSinceEpoch;

  // coverage:ignore-start
  static String? validateAmount(String? value) => requiredPositiveInt(value);
  // coverage:ignore-end
}

@MappableClass(discriminatorValue: 'syringe')
class Syringe extends ConsumableSupplyItem with SyringeMappable {
  Syringe({
    super.id,
    required super.name,
    required super.amount,
  });
}

@MappableClass(discriminatorValue: 'needle')
class Needle extends ConsumableSupplyItem with NeedleMappable {
  Needle({
    super.id,
    required super.name,
    required super.amount,
  });
}

@MappableClass(discriminatorValue: 'other')
class OtherSupplyItem extends ConsumableSupplyItem
    with OtherSupplyItemMappable {
  final OtherSupplyType otherSupplyType;

  OtherSupplyItem({
    super.id,
    required super.name,
    required super.amount,
    required this.otherSupplyType,
  });
}
