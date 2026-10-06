// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'delivery_form.dart';

class DeliveryFormMapper extends EnumMapper<DeliveryForm> {
  DeliveryFormMapper._();

  static DeliveryFormMapper? _instance;
  static DeliveryFormMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeliveryFormMapper._());
    }
    return _instance!;
  }

  static DeliveryForm fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DeliveryForm decode(dynamic value) {
    switch (value) {
      case r'pump':
        return DeliveryForm.pump;
      case r'sachet':
        return DeliveryForm.sachet;
      case r'gram':
        return DeliveryForm.gram;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DeliveryForm self) {
    switch (self) {
      case DeliveryForm.pump:
        return r'pump';
      case DeliveryForm.sachet:
        return r'sachet';
      case DeliveryForm.gram:
        return r'gram';
    }
  }
}

extension DeliveryFormMapperExtension on DeliveryForm {
  String toValue() {
    DeliveryFormMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DeliveryForm>(this) as String;
  }
}
