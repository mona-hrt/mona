// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileCopyrightText: 2026 Alice Lorido <alice@lori.do>
// SPDX-FileContributor: alix "a1ix2"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:dart_mappable/dart_mappable.dart';

part 'ester.mapper.dart';

@MappableEnum()
enum Ester {
  enanthate,
  valerate,
  cypionate,
  undecylate,
  benzoate,
  cypionateSuspension,
}
