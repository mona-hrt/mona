// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'consumable_supply_item.dart';

class GenericSupplyTypeMapper extends EnumMapper<GenericSupplyType> {
  GenericSupplyTypeMapper._();

  static GenericSupplyTypeMapper? _instance;
  static GenericSupplyTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GenericSupplyTypeMapper._());
    }
    return _instance!;
  }

  static GenericSupplyType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  GenericSupplyType decode(dynamic value) {
    switch (value) {
      case r'syringe':
        return GenericSupplyType.syringe;
      case r'wipe':
        return GenericSupplyType.wipe;
      case r'needle':
        return GenericSupplyType.needle;
      case r'gloves':
        return GenericSupplyType.gloves;
      case r'bandage':
        return GenericSupplyType.bandage;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(GenericSupplyType self) {
    switch (self) {
      case GenericSupplyType.syringe:
        return r'syringe';
      case GenericSupplyType.wipe:
        return r'wipe';
      case GenericSupplyType.needle:
        return r'needle';
      case GenericSupplyType.gloves:
        return r'gloves';
      case GenericSupplyType.bandage:
        return r'bandage';
    }
  }
}

extension GenericSupplyTypeMapperExtension on GenericSupplyType {
  String toValue() {
    GenericSupplyTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<GenericSupplyType>(this) as String;
  }
}

class ConsumableSupplyItemMapper
    extends SubClassMapperBase<ConsumableSupplyItem> {
  ConsumableSupplyItemMapper._();

  static ConsumableSupplyItemMapper? _instance;
  static ConsumableSupplyItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConsumableSupplyItemMapper._());
      SupplyItemMapper.ensureInitialized().addSubMapper(_instance!);
      GenericSupplyTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ConsumableSupplyItem';

  static int _$id(ConsumableSupplyItem v) => v.id;
  static const Field<ConsumableSupplyItem, int> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String _$name(ConsumableSupplyItem v) => v.name;
  static const Field<ConsumableSupplyItem, String> _f$name = Field(
    'name',
    _$name,
  );
  static int _$amount(ConsumableSupplyItem v) => v.amount;
  static const Field<ConsumableSupplyItem, int> _f$amount = Field(
    'amount',
    _$amount,
  );
  static GenericSupplyType _$genericSupplyType(ConsumableSupplyItem v) =>
      v.genericSupplyType;
  static const Field<ConsumableSupplyItem, GenericSupplyType>
      _f$genericSupplyType = Field('genericSupplyType', _$genericSupplyType);

  @override
  final MappableFields<ConsumableSupplyItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #amount: _f$amount,
    #genericSupplyType: _f$genericSupplyType,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'generic';
  @override
  late final ClassMapperBase superMapper = SupplyItemMapper.ensureInitialized();

  static ConsumableSupplyItem _instantiate(DecodingData data) {
    return ConsumableSupplyItem(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      amount: data.dec(_f$amount),
      genericSupplyType: data.dec(_f$genericSupplyType),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ConsumableSupplyItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConsumableSupplyItem>(map);
  }

  static ConsumableSupplyItem fromJson(String json) {
    return ensureInitialized().decodeJson<ConsumableSupplyItem>(json);
  }
}

mixin ConsumableSupplyItemMappable {
  String toJson() {
    return ConsumableSupplyItemMapper.ensureInitialized()
        .encodeJson<ConsumableSupplyItem>(this as ConsumableSupplyItem);
  }

  Map<String, dynamic> toMap() {
    return ConsumableSupplyItemMapper.ensureInitialized()
        .encodeMap<ConsumableSupplyItem>(this as ConsumableSupplyItem);
  }

  ConsumableSupplyItemCopyWith<ConsumableSupplyItem, ConsumableSupplyItem,
      ConsumableSupplyItem> get copyWith => _ConsumableSupplyItemCopyWithImpl<
          ConsumableSupplyItem, ConsumableSupplyItem>(
      this as ConsumableSupplyItem, $identity, $identity);
  @override
  String toString() {
    return ConsumableSupplyItemMapper.ensureInitialized().stringifyValue(
      this as ConsumableSupplyItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return ConsumableSupplyItemMapper.ensureInitialized().equalsValue(
      this as ConsumableSupplyItem,
      other,
    );
  }

  @override
  int get hashCode {
    return ConsumableSupplyItemMapper.ensureInitialized().hashValue(
      this as ConsumableSupplyItem,
    );
  }
}

extension ConsumableSupplyItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConsumableSupplyItem, $Out> {
  ConsumableSupplyItemCopyWith<$R, ConsumableSupplyItem, $Out>
      get $asConsumableSupplyItem => $base.as(
            (v, t, t2) => _ConsumableSupplyItemCopyWithImpl<$R, $Out>(v, t, t2),
          );
}

abstract class ConsumableSupplyItemCopyWith<
    $R,
    $In extends ConsumableSupplyItem,
    $Out> implements SupplyItemCopyWith<$R, $In, $Out> {
  @override
  $R call({
    int? id,
    String? name,
    int? amount,
    GenericSupplyType? genericSupplyType,
  });
  ConsumableSupplyItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ConsumableSupplyItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConsumableSupplyItem, $Out>
    implements ConsumableSupplyItemCopyWith<$R, ConsumableSupplyItem, $Out> {
  _ConsumableSupplyItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConsumableSupplyItem> $mapper =
      ConsumableSupplyItemMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    String? name,
    int? amount,
    GenericSupplyType? genericSupplyType,
  }) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != null) #name: name,
          if (amount != null) #amount: amount,
          if (genericSupplyType != null) #genericSupplyType: genericSupplyType,
        }),
      );
  @override
  ConsumableSupplyItem $make(CopyWithData data) => ConsumableSupplyItem(
        id: data.get(#id, or: $value.id),
        name: data.get(#name, or: $value.name),
        amount: data.get(#amount, or: $value.amount),
        genericSupplyType: data.get(
          #genericSupplyType,
          or: $value.genericSupplyType,
        ),
      );

  @override
  ConsumableSupplyItemCopyWith<$R2, ConsumableSupplyItem, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ConsumableSupplyItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
