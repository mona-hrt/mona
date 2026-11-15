// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'consumable_supply_item.dart';

class SyringeTypeMapper extends EnumMapper<SyringeType> {
  SyringeTypeMapper._();

  static SyringeTypeMapper? _instance;
  static SyringeTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SyringeTypeMapper._());
    }
    return _instance!;
  }

  static SyringeType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SyringeType decode(dynamic value) {
    switch (value) {
      case r'standard':
        return SyringeType.standard;
      case r'lowDeadSpace':
        return SyringeType.lowDeadSpace;
      case r'fixedNeedle':
        return SyringeType.fixedNeedle;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SyringeType self) {
    switch (self) {
      case SyringeType.standard:
        return r'standard';
      case SyringeType.lowDeadSpace:
        return r'lowDeadSpace';
      case SyringeType.fixedNeedle:
        return r'fixedNeedle';
    }
  }
}

extension SyringeTypeMapperExtension on SyringeType {
  String toValue() {
    SyringeTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SyringeType>(this) as String;
  }
}

class NeedleTypeMapper extends EnumMapper<NeedleType> {
  NeedleTypeMapper._();

  static NeedleTypeMapper? _instance;
  static NeedleTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NeedleTypeMapper._());
    }
    return _instance!;
  }

  static NeedleType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  NeedleType decode(dynamic value) {
    switch (value) {
      case r'standard':
        return NeedleType.standard;
      case r'lowDeadSpace':
        return NeedleType.lowDeadSpace;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(NeedleType self) {
    switch (self) {
      case NeedleType.standard:
        return r'standard';
      case NeedleType.lowDeadSpace:
        return r'lowDeadSpace';
    }
  }
}

extension NeedleTypeMapperExtension on NeedleType {
  String toValue() {
    NeedleTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<NeedleType>(this) as String;
  }
}

class OtherSupplyTypeMapper extends EnumMapper<OtherSupplyType> {
  OtherSupplyTypeMapper._();

  static OtherSupplyTypeMapper? _instance;
  static OtherSupplyTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OtherSupplyTypeMapper._());
    }
    return _instance!;
  }

  static OtherSupplyType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  OtherSupplyType decode(dynamic value) {
    switch (value) {
      case r'wipe':
        return OtherSupplyType.wipe;
      case r'gloves':
        return OtherSupplyType.gloves;
      case r'bandage':
        return OtherSupplyType.bandage;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(OtherSupplyType self) {
    switch (self) {
      case OtherSupplyType.wipe:
        return r'wipe';
      case OtherSupplyType.gloves:
        return r'gloves';
      case OtherSupplyType.bandage:
        return r'bandage';
    }
  }
}

extension OtherSupplyTypeMapperExtension on OtherSupplyType {
  String toValue() {
    OtherSupplyTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<OtherSupplyType>(this) as String;
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
      SyringeMapper.ensureInitialized();
      NeedleMapper.ensureInitialized();
      OtherSupplyItemMapper.ensureInitialized();
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

  @override
  final MappableFields<ConsumableSupplyItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #amount: _f$amount,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ConsumableSupplyItem';
  @override
  late final ClassMapperBase superMapper = SupplyItemMapper.ensureInitialized();

  static ConsumableSupplyItem _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'ConsumableSupplyItem',
      'type',
      '${data.value['type']}',
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
  String toJson();
  Map<String, dynamic> toMap();
  ConsumableSupplyItemCopyWith<ConsumableSupplyItem, ConsumableSupplyItem,
      ConsumableSupplyItem> get copyWith;
}

abstract class ConsumableSupplyItemCopyWith<
    $R,
    $In extends ConsumableSupplyItem,
    $Out> implements SupplyItemCopyWith<$R, $In, $Out> {
  @override
  $R call({int? id, String? name, int? amount});
  ConsumableSupplyItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class SyringeMapper extends SubClassMapperBase<Syringe> {
  SyringeMapper._();

  static SyringeMapper? _instance;
  static SyringeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SyringeMapper._());
      ConsumableSupplyItemMapper.ensureInitialized().addSubMapper(_instance!);
      SyringeTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Syringe';

  static int _$id(Syringe v) => v.id;
  static const Field<Syringe, int> _f$id = Field('id', _$id, opt: true);
  static String _$name(Syringe v) => v.name;
  static const Field<Syringe, String> _f$name = Field('name', _$name);
  static int _$amount(Syringe v) => v.amount;
  static const Field<Syringe, int> _f$amount = Field('amount', _$amount);
  static SyringeType? _$syringeType(Syringe v) => v.syringeType;
  static const Field<Syringe, SyringeType> _f$syringeType = Field(
    'syringeType',
    _$syringeType,
    opt: true,
  );

  @override
  final MappableFields<Syringe> fields = const {
    #id: _f$id,
    #name: _f$name,
    #amount: _f$amount,
    #syringeType: _f$syringeType,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'syringe';
  @override
  late final ClassMapperBase superMapper =
      ConsumableSupplyItemMapper.ensureInitialized();

  static Syringe _instantiate(DecodingData data) {
    return Syringe(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      amount: data.dec(_f$amount),
      syringeType: data.dec(_f$syringeType),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Syringe fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Syringe>(map);
  }

  static Syringe fromJson(String json) {
    return ensureInitialized().decodeJson<Syringe>(json);
  }
}

mixin SyringeMappable {
  String toJson() {
    return SyringeMapper.ensureInitialized().encodeJson<Syringe>(
      this as Syringe,
    );
  }

  Map<String, dynamic> toMap() {
    return SyringeMapper.ensureInitialized().encodeMap<Syringe>(
      this as Syringe,
    );
  }

  SyringeCopyWith<Syringe, Syringe, Syringe> get copyWith =>
      _SyringeCopyWithImpl<Syringe, Syringe>(
        this as Syringe,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SyringeMapper.ensureInitialized().stringifyValue(this as Syringe);
  }

  @override
  bool operator ==(Object other) {
    return SyringeMapper.ensureInitialized().equalsValue(
      this as Syringe,
      other,
    );
  }

  @override
  int get hashCode {
    return SyringeMapper.ensureInitialized().hashValue(this as Syringe);
  }
}

extension SyringeValueCopy<$R, $Out> on ObjectCopyWith<$R, Syringe, $Out> {
  SyringeCopyWith<$R, Syringe, $Out> get $asSyringe =>
      $base.as((v, t, t2) => _SyringeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SyringeCopyWith<$R, $In extends Syringe, $Out>
    implements ConsumableSupplyItemCopyWith<$R, $In, $Out> {
  @override
  $R call({int? id, String? name, int? amount, SyringeType? syringeType});
  SyringeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SyringeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Syringe, $Out>
    implements SyringeCopyWith<$R, Syringe, $Out> {
  _SyringeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Syringe> $mapper =
      SyringeMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    String? name,
    int? amount,
    Object? syringeType = $none,
  }) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != null) #name: name,
          if (amount != null) #amount: amount,
          if (syringeType != $none) #syringeType: syringeType,
        }),
      );
  @override
  Syringe $make(CopyWithData data) => Syringe(
        id: data.get(#id, or: $value.id),
        name: data.get(#name, or: $value.name),
        amount: data.get(#amount, or: $value.amount),
        syringeType: data.get(#syringeType, or: $value.syringeType),
      );

  @override
  SyringeCopyWith<$R2, Syringe, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SyringeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class NeedleMapper extends SubClassMapperBase<Needle> {
  NeedleMapper._();

  static NeedleMapper? _instance;
  static NeedleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NeedleMapper._());
      ConsumableSupplyItemMapper.ensureInitialized().addSubMapper(_instance!);
      NeedleTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Needle';

  static int _$id(Needle v) => v.id;
  static const Field<Needle, int> _f$id = Field('id', _$id, opt: true);
  static String _$name(Needle v) => v.name;
  static const Field<Needle, String> _f$name = Field('name', _$name);
  static int _$amount(Needle v) => v.amount;
  static const Field<Needle, int> _f$amount = Field('amount', _$amount);
  static NeedleType? _$needleType(Needle v) => v.needleType;
  static const Field<Needle, NeedleType> _f$needleType = Field(
    'needleType',
    _$needleType,
    opt: true,
  );

  @override
  final MappableFields<Needle> fields = const {
    #id: _f$id,
    #name: _f$name,
    #amount: _f$amount,
    #needleType: _f$needleType,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'needle';
  @override
  late final ClassMapperBase superMapper =
      ConsumableSupplyItemMapper.ensureInitialized();

  static Needle _instantiate(DecodingData data) {
    return Needle(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      amount: data.dec(_f$amount),
      needleType: data.dec(_f$needleType),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Needle fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Needle>(map);
  }

  static Needle fromJson(String json) {
    return ensureInitialized().decodeJson<Needle>(json);
  }
}

mixin NeedleMappable {
  String toJson() {
    return NeedleMapper.ensureInitialized().encodeJson<Needle>(this as Needle);
  }

  Map<String, dynamic> toMap() {
    return NeedleMapper.ensureInitialized().encodeMap<Needle>(this as Needle);
  }

  NeedleCopyWith<Needle, Needle, Needle> get copyWith =>
      _NeedleCopyWithImpl<Needle, Needle>(this as Needle, $identity, $identity);
  @override
  String toString() {
    return NeedleMapper.ensureInitialized().stringifyValue(this as Needle);
  }

  @override
  bool operator ==(Object other) {
    return NeedleMapper.ensureInitialized().equalsValue(this as Needle, other);
  }

  @override
  int get hashCode {
    return NeedleMapper.ensureInitialized().hashValue(this as Needle);
  }
}

extension NeedleValueCopy<$R, $Out> on ObjectCopyWith<$R, Needle, $Out> {
  NeedleCopyWith<$R, Needle, $Out> get $asNeedle =>
      $base.as((v, t, t2) => _NeedleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NeedleCopyWith<$R, $In extends Needle, $Out>
    implements ConsumableSupplyItemCopyWith<$R, $In, $Out> {
  @override
  $R call({int? id, String? name, int? amount, NeedleType? needleType});
  NeedleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NeedleCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Needle, $Out>
    implements NeedleCopyWith<$R, Needle, $Out> {
  _NeedleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Needle> $mapper = NeedleMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    String? name,
    int? amount,
    Object? needleType = $none,
  }) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != null) #name: name,
          if (amount != null) #amount: amount,
          if (needleType != $none) #needleType: needleType,
        }),
      );
  @override
  Needle $make(CopyWithData data) => Needle(
        id: data.get(#id, or: $value.id),
        name: data.get(#name, or: $value.name),
        amount: data.get(#amount, or: $value.amount),
        needleType: data.get(#needleType, or: $value.needleType),
      );

  @override
  NeedleCopyWith<$R2, Needle, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NeedleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class OtherSupplyItemMapper extends SubClassMapperBase<OtherSupplyItem> {
  OtherSupplyItemMapper._();

  static OtherSupplyItemMapper? _instance;
  static OtherSupplyItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OtherSupplyItemMapper._());
      ConsumableSupplyItemMapper.ensureInitialized().addSubMapper(_instance!);
      OtherSupplyTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'OtherSupplyItem';

  static int _$id(OtherSupplyItem v) => v.id;
  static const Field<OtherSupplyItem, int> _f$id = Field('id', _$id, opt: true);
  static String _$name(OtherSupplyItem v) => v.name;
  static const Field<OtherSupplyItem, String> _f$name = Field('name', _$name);
  static int _$amount(OtherSupplyItem v) => v.amount;
  static const Field<OtherSupplyItem, int> _f$amount = Field(
    'amount',
    _$amount,
  );
  static OtherSupplyType _$otherSupplyType(OtherSupplyItem v) =>
      v.otherSupplyType;
  static const Field<OtherSupplyItem, OtherSupplyType> _f$otherSupplyType =
      Field('otherSupplyType', _$otherSupplyType);

  @override
  final MappableFields<OtherSupplyItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #amount: _f$amount,
    #otherSupplyType: _f$otherSupplyType,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'other';
  @override
  late final ClassMapperBase superMapper =
      ConsumableSupplyItemMapper.ensureInitialized();

  static OtherSupplyItem _instantiate(DecodingData data) {
    return OtherSupplyItem(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      amount: data.dec(_f$amount),
      otherSupplyType: data.dec(_f$otherSupplyType),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static OtherSupplyItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OtherSupplyItem>(map);
  }

  static OtherSupplyItem fromJson(String json) {
    return ensureInitialized().decodeJson<OtherSupplyItem>(json);
  }
}

mixin OtherSupplyItemMappable {
  String toJson() {
    return OtherSupplyItemMapper.ensureInitialized()
        .encodeJson<OtherSupplyItem>(this as OtherSupplyItem);
  }

  Map<String, dynamic> toMap() {
    return OtherSupplyItemMapper.ensureInitialized().encodeMap<OtherSupplyItem>(
      this as OtherSupplyItem,
    );
  }

  OtherSupplyItemCopyWith<OtherSupplyItem, OtherSupplyItem, OtherSupplyItem>
      get copyWith =>
          _OtherSupplyItemCopyWithImpl<OtherSupplyItem, OtherSupplyItem>(
            this as OtherSupplyItem,
            $identity,
            $identity,
          );
  @override
  String toString() {
    return OtherSupplyItemMapper.ensureInitialized().stringifyValue(
      this as OtherSupplyItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return OtherSupplyItemMapper.ensureInitialized().equalsValue(
      this as OtherSupplyItem,
      other,
    );
  }

  @override
  int get hashCode {
    return OtherSupplyItemMapper.ensureInitialized().hashValue(
      this as OtherSupplyItem,
    );
  }
}

extension OtherSupplyItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OtherSupplyItem, $Out> {
  OtherSupplyItemCopyWith<$R, OtherSupplyItem, $Out> get $asOtherSupplyItem =>
      $base.as((v, t, t2) => _OtherSupplyItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OtherSupplyItemCopyWith<$R, $In extends OtherSupplyItem, $Out>
    implements ConsumableSupplyItemCopyWith<$R, $In, $Out> {
  @override
  $R call({
    int? id,
    String? name,
    int? amount,
    OtherSupplyType? otherSupplyType,
  });
  OtherSupplyItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _OtherSupplyItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OtherSupplyItem, $Out>
    implements OtherSupplyItemCopyWith<$R, OtherSupplyItem, $Out> {
  _OtherSupplyItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OtherSupplyItem> $mapper =
      OtherSupplyItemMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    String? name,
    int? amount,
    OtherSupplyType? otherSupplyType,
  }) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != null) #name: name,
          if (amount != null) #amount: amount,
          if (otherSupplyType != null) #otherSupplyType: otherSupplyType,
        }),
      );
  @override
  OtherSupplyItem $make(CopyWithData data) => OtherSupplyItem(
        id: data.get(#id, or: $value.id),
        name: data.get(#name, or: $value.name),
        amount: data.get(#amount, or: $value.amount),
        otherSupplyType: data.get(#otherSupplyType, or: $value.otherSupplyType),
      );

  @override
  OtherSupplyItemCopyWith<$R2, OtherSupplyItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) =>
      _OtherSupplyItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
