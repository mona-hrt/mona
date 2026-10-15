// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:mona/data/model/delivery_form.dart';
import 'package:mona/i18n/translations.g.dart';

extension DeliveryFormL10n on DeliveryForm {
  String get localizedName => switch (this) {
        DeliveryForm.pump => t.deliveryFormPump,
        DeliveryForm.sachet => t.deliveryFormSachet,
        DeliveryForm.gram => t.deliveryFormGram,
      };

  String localizedUnit(num count) => switch (this) {
        DeliveryForm.pump => t.administrationRouteUnitPump(count: count),
        DeliveryForm.sachet => t.administrationRouteUnitSachet(count: count),
        DeliveryForm.gram => t.administrationRouteUnitGram(count: count),
      };
}
