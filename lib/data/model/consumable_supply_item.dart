// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:clock/clock.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:decimal/decimal.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/util/validators.dart';

part 'consumable_supply_item.mapper.dart';

@MappableEnum()
enum SyringeType {
  standard,
  lowDeadSpace,
  fixedNeedle;
}

@MappableEnum()
enum NeedleType {
  standard,
  lowDeadSpace;
}

@MappableEnum()
enum OtherSupplyType {
  wipe,
  gloves,
  bandage;
}

Decimal? deadSpaceOf(SyringeType? syringeType, NeedleType? needleType) =>
    switch ((syringeType, needleType)) {
      (SyringeType.standard, NeedleType.standard) => Decimal.fromInt(92),
      (SyringeType.lowDeadSpace, NeedleType.standard) => Decimal.fromInt(59),
      (
        SyringeType.standard || SyringeType.lowDeadSpace,
        NeedleType.lowDeadSpace,
      ) =>
        Decimal.fromInt(17),
      (SyringeType.fixedNeedle, _) => Decimal.fromInt(3),
      _ => null,
    };

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
  final SyringeType? syringeType;

  Syringe({
    super.id,
    required super.name,
    required super.amount,
    this.syringeType,
  });
}

@MappableClass(discriminatorValue: 'needle')
class Needle extends ConsumableSupplyItem with NeedleMappable {
  final NeedleType? needleType;

  Needle({
    super.id,
    required super.name,
    required super.amount,
    this.needleType,
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
