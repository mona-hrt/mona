// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter/material.dart';
import 'package:mona/data/model/medication_schedule.dart';

@immutable
sealed class PlannedNotification {
  final MedicationSchedule schedule;

  const PlannedNotification(this.schedule);

  DateTime get firstFire;
}

class PlannedOccurrence extends PlannedNotification {
  final DateTime dateTime;

  const PlannedOccurrence(super.schedule, {required this.dateTime});

  @override
  DateTime get firstFire => dateTime;
}
