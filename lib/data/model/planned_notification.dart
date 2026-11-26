// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter/material.dart';
import 'package:mona/data/model/medication_schedule.dart';

@immutable
class PlannedNotification {
  final MedicationSchedule schedule;
  final DateTime dateTime;

  const PlannedNotification(this.schedule, {required this.dateTime});
}
