import 'package:dart_mappable/dart_mappable.dart';

part 'injection_type.mapper.dart';

@MappableEnum()
enum InjectionType {
  intramuscular,
  subcutaneous,
}
