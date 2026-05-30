import 'package:dart_mappable/dart_mappable.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/validators.dart';

part 'supply_item.mapper.dart';

@MappableClass(discriminatorKey: 'type')
abstract class SupplyItem with SupplyItemMappable {
  int get id;
  String get name;

  // coverage:ignore-start
  static String? validateName(AppLocalizations l10n, String? value) =>
      requiredString(l10n, value);
  // coverage:ignore-end
}
