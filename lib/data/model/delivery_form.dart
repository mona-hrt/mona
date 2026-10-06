// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:dart_mappable/dart_mappable.dart';

part 'delivery_form.mapper.dart';

@MappableEnum()
enum DeliveryForm { pump, sachet, gram }
