import 'package:dart_mappable/dart_mappable.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/validators.dart';

part 'generic_supply_item.mapper.dart';

@MappableClass(discriminatorValue: 'generic')
class GenericSupply extends SupplyItem with GenericSupplyMappable {
  @override
  final int id;
  @override
  final String name;
  final int amount;

  GenericSupply({
    int? id,
    required this.name,
    required this.amount,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch;

  // coverage:ignore-start
  static String? validateAmount(AppLocalizations l10n, String? value) =>
      requiredPositiveInt(l10n, value);
  // coverage:ignore-end
}
