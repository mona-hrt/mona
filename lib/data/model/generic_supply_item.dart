import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/validators.dart';

part 'generic_supply_item.mapper.dart';

@MappableEnum()
enum GenericSupplyType {
  syringe(
    name: 'syringe',
    icon: Symbols.syringe,
  ),

  wipe(
    name: 'wipe',
    icon: Symbols.note_stack,
  ),

  needle(
    name: 'needle',
    icon: Symbols.syringe,
  ),

  gloves(
    name: 'gloves',
    icon: Symbols.handshake,
  ),

  bandage(
    name: 'bandage',
    icon: Symbols.healing,
  );

  final String name;
  final IconData icon;

  const GenericSupplyType({
    required this.name,
    required this.icon,
  });
} // TODO move the icon in an extension in the ui layer

@MappableClass(discriminatorValue: 'generic')
class GenericSupply extends SupplyItem with GenericSupplyMappable {
  @override
  final int id;
  @override
  final String name;
  final int amount;
  final GenericSupplyType genericSupplyType;

  GenericSupply({
    int? id,
    required this.name,
    required this.amount,
    required this.genericSupplyType,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch;

  // coverage:ignore-start
  static String? validateAmount(AppLocalizations l10n, String? value) =>
      requiredPositiveInt(l10n, value);
  // coverage:ignore-end
}
