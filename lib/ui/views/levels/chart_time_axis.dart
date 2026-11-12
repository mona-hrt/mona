// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:mona/util/time_difference.dart';

final _axisOrigin = DateTime(2000);

double chartX(DateTime instant) => timeDifferenceInDays(instant, _axisOrigin);

DateTime chartDate(double x) => _axisOrigin.add(durationFromDays(x));
