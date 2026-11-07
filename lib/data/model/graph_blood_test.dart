// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:mona/data/model/units.dart';

class GraphBloodTest {
  final double level;
  final double offset;
  final ValueComparison comparison;

  const GraphBloodTest({
    required this.level,
    required this.offset,
    this.comparison = ValueComparison.equal,
  });
}
