// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';

class JsonStringHook extends MappingHook {
  const JsonStringHook();

  @override
  Object? beforeDecode(Object? value) =>
      value is String ? jsonDecode(value) : value;

  @override
  Object? afterEncode(Object? value) =>
      value == null ? null : jsonEncode(value);
}
