// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:mona/data/model/injection_type.dart';
import 'package:mona/i18n/translations.g.dart';

extension InjectionTypeL10n on InjectionType {
  String get localizedName => switch (this) {
        InjectionType.intramuscular => t.intramuscular,
        InjectionType.subcutaneous => t.subcutaneous,
      };
}
