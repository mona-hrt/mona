// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Thomas "Seremptos"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/l10n/helpers/medication_schedule_l10n.dart';
import 'package:mona/ui/views/home/settings/schedules/edit_schedule/edit_schedule_main_info.dart';
import 'package:mona/ui/views/home/settings/schedules/edit_schedule/edit_schedule_scheduling_page.dart';
import 'package:provider/provider.dart';

class EditSchedulePage extends StatelessWidget {
  final MedicationSchedule schedule;

  EditSchedulePage({required this.schedule});

  @override
  Widget build(BuildContext context) {
    final medicationScheduleProvider =
        context.watch<MedicationScheduleProvider>();
    final localizations = context.l10n;
    final currentSchedule = medicationScheduleProvider.schedules
        .firstWhereOrNull((s) => s.id == schedule.id);

    if (currentSchedule == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.canPop(context)) Navigator.pop(context);
      });
      return SizedBox.shrink();
    }

    final schedulingSubtitle = _schedulingSubtitle(currentSchedule, context);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentSchedule.name),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(localizations.editScheduleInfo),
            subtitle: Text(currentSchedule.localizedSummary(localizations)),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (context) => EditScheduleMainInfoPage(
                  schedule: currentSchedule,
                ),
              ));
            },
          ),
          ListTile(
            title: Text(localizations.scheduling),
            subtitle: Text(schedulingSubtitle),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (context) => EditScheduleSchedulingPage(
                  schedule: currentSchedule,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }

  String _schedulingSubtitle(
    MedicationSchedule schedule,
    BuildContext context,
  ) {
    final localizations = context.l10n;
    return switch (schedule.scheduling) {
      IntervalDaysSchedule(
        intervalDays: final intervalDays,
      ) =>
        intervalDays == 1
            ? localizations.scheduleFrequencyDaily
            : localizations.scheduleFrequencyEveryNDays(
                intervalDays), // TODO use one, many ?
      DailySchedule _ => localizations.scheduleFrequencyDaily,
    };
  }
}
