import 'package:mona/data/model/supply_item.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/validators.dart';
import 'package:uuid/uuid.dart';

class GenericSupply implements SupplyItem {
  @override
  final String id;
  @override
  final String name;
  final int amount;
  @override
  final int updatedAt;
  @override
  final bool isDeleted;

  GenericSupply({
    String? id,
    required this.name,
    required this.amount,
    int? updatedAt,
    this.isDeleted = false,
  })  : id = id ?? const Uuid().v4(),
        updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  factory GenericSupply.fromMap(Map<String, Object?> map) {
    return GenericSupply(
      id: map['id'] as String?,
      name: map['name'] as String,
      amount: map['amount'] as int,
    );
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'type': SupplyType.generic.name,
    };
  }

  GenericSupply copyWith({
    String? id,
    String? name,
    int? amount,
  }) {
    return GenericSupply(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  // coverage:ignore-start
  static String? validateAmount(AppLocalizations l10n, String? value) =>
      requiredPositiveInt(l10n, value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is GenericSupply && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'GenericSupply(id: $id, name: $name, amount: $amount)';
  }
  // coverage:ignore-end
}
