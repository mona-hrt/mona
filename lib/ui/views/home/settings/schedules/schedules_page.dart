import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/i18n/helpers/medication_schedule_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/views/home/settings/schedules/edit_schedule/edit_schedule_main_info.dart';
import 'package:mona/ui/widgets/tappable_list_tile.dart';
import 'package:provider/provider.dart';

import 'new_schedule_main_info_page.dart';

class SchedulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final medicationScheduleProvider =
        context.watch<MedicationScheduleProvider>();

    if (medicationScheduleProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(t.schedules),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t.schedules),
      ),
      body: medicationScheduleProvider.schedules.isEmpty
          ? SafeArea(
              child: Center(
                child: Text(t.addScheduleToGetStarted),
              ),
            )
          : M3EReorderableSegmentedList(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              listPadding: pagePadding +
                  EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
              keyBuilder: (index) =>
                  ValueKey(medicationScheduleProvider.schedules[index].id),
              onReorder: (oldIndex, newIndex) =>
                  medicationScheduleProvider.reorder(oldIndex, newIndex),
              children: [
                for (final schedule in medicationScheduleProvider.schedules)
                  TappableListTile(
                    title: schedule.name,
                    subtitle: schedule.localizedSummaryWithFrequency,
                    leading: CircleAvatar(
                      child: Icon(
                        schedule.administrationRoute.icon,
                      ),
                    ),
                    trailing: Icon(Symbols.chevron_right_rounded),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              EditScheduleMainInfoPage(schedule: schedule),
                        ),
                      );
                    },
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (context) => const NewScheduleMainInfoPage(),
          ));
        },
        tooltip: t.addSchedule,
        child: Icon(Symbols.add_rounded),
      ),
    );
  }
}
