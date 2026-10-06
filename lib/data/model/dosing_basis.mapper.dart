// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dosing_basis.dart';

class DosingBasisMapper extends EnumMapper<DosingBasis> {
  DosingBasisMapper._();

  static DosingBasisMapper? _instance;
  static DosingBasisMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DosingBasisMapper._());
    }
    return _instance!;
  }

  static DosingBasis fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DosingBasis decode(dynamic value) {
    switch (value) {
      case r'mass':
        return DosingBasis.mass;
      case r'releaseRate':
        return DosingBasis.releaseRate;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DosingBasis self) {
    switch (self) {
      case DosingBasis.mass:
        return r'mass';
      case DosingBasis.releaseRate:
        return r'releaseRate';
    }
  }
}

extension DosingBasisMapperExtension on DosingBasis {
  String toValue() {
    DosingBasisMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DosingBasis>(this) as String;
  }
}
