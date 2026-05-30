// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'generic_supply_item.dart';

class GenericSupplyMapper extends SubClassMapperBase<GenericSupply> {
  GenericSupplyMapper._();

  static GenericSupplyMapper? _instance;
  static GenericSupplyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GenericSupplyMapper._());
      SupplyItemMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'GenericSupply';

  static int _$id(GenericSupply v) => v.id;
  static const Field<GenericSupply, int> _f$id = Field('id', _$id, opt: true);
  static String _$name(GenericSupply v) => v.name;
  static const Field<GenericSupply, String> _f$name = Field('name', _$name);
  static int _$amount(GenericSupply v) => v.amount;
  static const Field<GenericSupply, int> _f$amount = Field('amount', _$amount);

  @override
  final MappableFields<GenericSupply> fields = const {
    #id: _f$id,
    #name: _f$name,
    #amount: _f$amount,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'generic';
  @override
  late final ClassMapperBase superMapper = SupplyItemMapper.ensureInitialized();

  static GenericSupply _instantiate(DecodingData data) {
    return GenericSupply(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      amount: data.dec(_f$amount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GenericSupply fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GenericSupply>(map);
  }

  static GenericSupply fromJson(String json) {
    return ensureInitialized().decodeJson<GenericSupply>(json);
  }
}

mixin GenericSupplyMappable {
  String toJson() {
    return GenericSupplyMapper.ensureInitialized().encodeJson<GenericSupply>(
      this as GenericSupply,
    );
  }

  Map<String, dynamic> toMap() {
    return GenericSupplyMapper.ensureInitialized().encodeMap<GenericSupply>(
      this as GenericSupply,
    );
  }

  GenericSupplyCopyWith<GenericSupply, GenericSupply, GenericSupply>
  get copyWith => _GenericSupplyCopyWithImpl<GenericSupply, GenericSupply>(
    this as GenericSupply,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return GenericSupplyMapper.ensureInitialized().stringifyValue(
      this as GenericSupply,
    );
  }

  @override
  bool operator ==(Object other) {
    return GenericSupplyMapper.ensureInitialized().equalsValue(
      this as GenericSupply,
      other,
    );
  }

  @override
  int get hashCode {
    return GenericSupplyMapper.ensureInitialized().hashValue(
      this as GenericSupply,
    );
  }
}

extension GenericSupplyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GenericSupply, $Out> {
  GenericSupplyCopyWith<$R, GenericSupply, $Out> get $asGenericSupply =>
      $base.as((v, t, t2) => _GenericSupplyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GenericSupplyCopyWith<$R, $In extends GenericSupply, $Out>
    implements SupplyItemCopyWith<$R, $In, $Out> {
  @override
  $R call({int? id, String? name, int? amount});
  GenericSupplyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GenericSupplyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GenericSupply, $Out>
    implements GenericSupplyCopyWith<$R, GenericSupply, $Out> {
  _GenericSupplyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GenericSupply> $mapper =
      GenericSupplyMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, String? name, int? amount}) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != null) #name: name,
      if (amount != null) #amount: amount,
    }),
  );
  @override
  GenericSupply $make(CopyWithData data) => GenericSupply(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    amount: data.get(#amount, or: $value.amount),
  );

  @override
  GenericSupplyCopyWith<$R2, GenericSupply, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GenericSupplyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

