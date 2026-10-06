// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'injection_type.dart';

class InjectionTypeMapper extends EnumMapper<InjectionType> {
  InjectionTypeMapper._();

  static InjectionTypeMapper? _instance;
  static InjectionTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InjectionTypeMapper._());
    }
    return _instance!;
  }

  static InjectionType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  InjectionType decode(dynamic value) {
    switch (value) {
      case r'intramuscular':
        return InjectionType.intramuscular;
      case r'subcutaneous':
        return InjectionType.subcutaneous;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(InjectionType self) {
    switch (self) {
      case InjectionType.intramuscular:
        return r'intramuscular';
      case InjectionType.subcutaneous:
        return r'subcutaneous';
    }
  }
}

extension InjectionTypeMapperExtension on InjectionType {
  String toValue() {
    InjectionTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<InjectionType>(this) as String;
  }
}
