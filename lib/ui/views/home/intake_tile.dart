import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/controllers/schedule_manager.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/l10n/helpers/molecule_l10n.dart';
import 'package:mona/ui/views/home/take_medication_page.dart';
import 'package:provider/provider.dart';

class IntakeTile extends StatelessWidget {
  const IntakeTile(this.slot, {super.key});

  final ScheduleSlot slot;

  MedicationSchedule get schedule => slot.schedule;
  ScheduleStatus get status => slot.status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final medicationIntakeProvider = context.watch<MedicationIntakeProvider>();
    final supplyItemProvider = context.watch<SupplyItemProvider>();
    final localizations = context.l10n;
    final now = DateTime.now();

    final viewModel = IntakeTileViewModel(
      schedule: schedule,
      status: status,
      slotTime: slot.time,
      slotTimeText: slot.time?.format(context),
      intakeProvider: medicationIntakeProvider,
      supplyProvider: supplyItemProvider,
      now: now,
      theme: Theme.of(context),
      localizations: localizations,
      languageTag: context.languageTag,
    );

    final textColor =
        viewModel.isActive ? theme.colorScheme.onPrimaryContainer : null;

    return Card.filled(
      color: viewModel.isActive ? theme.colorScheme.primaryContainer : null,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => TakeMedicationPage(
                schedule,
                scheduledTime: slot.time,
              ),
            ),
          );
        },
        child: ListTile(
          leading: viewModel.tileIcon,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (viewModel.scheduledText != null)
                Text(
                  viewModel.scheduledText!,
                  style:
                      theme.textTheme.labelMedium?.copyWith(color: textColor),
                ),
              Text(
                schedule.name,
                style: theme.textTheme.titleMedium?.copyWith(color: textColor),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (status != ScheduleStatus.upcoming)
                Text(
                  viewModel.intakeInfo,
                  style: TextStyle(color: textColor),
                ),
              if (viewModel.warningText != null)
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.error_outline,
                          size: 16,
                          color: textColor,
                        ),
                      ),
                      const TextSpan(text: " "),
                      TextSpan(
                        text: viewModel.warningText!,
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class IntakeTileViewModel {
  IntakeTileViewModel(
      {required this.schedule,
      required this.status,
      required this.slotTime,
      required this.slotTimeText,
      required this.intakeProvider,
      required this.supplyProvider,
      required this.now,
      required this.theme,
      required this.localizations,
      required this.languageTag});

  final MedicationSchedule schedule;
  final ScheduleStatus status;
  final TimeOfDay? slotTime;
  final String? slotTimeText;
  final MedicationIntakeProvider intakeProvider;
  final SupplyItemProvider supplyProvider;
  final DateTime now;
  final ThemeData theme;
  final AppLocalizations localizations;
  final String languageTag;

  bool get _isDailySlot => slotTime != null;

  IntervalDaysSchedule get _intervalScheduling =>
      schedule.scheduling as IntervalDaysSchedule;

  Date get nextScheduled => _intervalScheduling.nextDate(schedule.startDate);

  Date? get lastScheduled =>
      _intervalScheduling.previousDate(schedule.startDate);

  Date? get lastTaken =>
      intakeProvider.getLastIntakeLocalDateForSchedule(schedule.id);

  int get daysUntilIntake => nextScheduled.daysAwayFromToday;

  int? get daysSinceLastTaken => lastTaken?.daysAwayFromToday;

  int? get daysSinceLastScheduled => lastScheduled?.daysAwayFromToday;

  String get intakeInfo {
    if (status == ScheduleStatus.taken) {
      return localizations.taken;
    }

    return "${schedule.dose} ${schedule.molecule.unit} • ${schedule.molecule.localizedNameWithEster(schedule.ester, localizations)}";
  }

  String? get scheduledText {
    if (_isDailySlot) {
      return slotTimeText;
    }

    switch (status) {
      case ScheduleStatus.today:
      case ScheduleStatus.todayOverdue:
      case ScheduleStatus.todayEarly:
      case ScheduleStatus.taken:
        return null;

      case ScheduleStatus.overdue:
        final formatted = lastScheduled!.format(DateFormat.MMMMd(languageTag));
        return "$formatted - ${localizations.daysAgoCount(daysSinceLastScheduled!)}";

      case ScheduleStatus.upcoming:
        final formatted = nextScheduled.format(DateFormat.MMMMd(languageTag));
        return "$formatted - ${localizations.inDaysCount(daysUntilIntake)}";
    }
  }

  String? get warningText {
    switch (status) {
      case ScheduleStatus.today:
      case ScheduleStatus.upcoming:
      case ScheduleStatus.taken:
      case ScheduleStatus.overdue:
        return null;

      case ScheduleStatus.todayEarly:
      case ScheduleStatus.todayOverdue:
        if (lastTaken == null) {
          return localizations.neverTakenYet;
        }

        final formatted = lastTaken!.format(DateFormat.MMMd(languageTag));
        return "${localizations.lastTaken} ${localizations.daysAgoCount(daysSinceLastTaken!)} ($formatted)";
    }
  }

  bool get isActive =>
      status == ScheduleStatus.today ||
      status == ScheduleStatus.overdue ||
      status == ScheduleStatus.todayOverdue ||
      status == ScheduleStatus.todayEarly;

  Widget get tileIcon {
    if (status == ScheduleStatus.taken) {
      return CircleAvatar(
        backgroundColor: theme.colorScheme.tertiary,
        child: Icon(
          Symbols.check,
          color: theme.colorScheme.onTertiary,
        ),
      );
    }

    if (status == ScheduleStatus.upcoming) {
      return CircleAvatar(
        backgroundColor: theme.colorScheme.secondary,
        child: Text(
          daysUntilIntake.toString(),
          style: TextStyle(
            color: theme.colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    final icon = status == ScheduleStatus.today ||
            status == ScheduleStatus.todayOverdue ||
            status == ScheduleStatus.todayEarly
        ? schedule.administrationRoute.icon
        : Symbols.schedule;

    return CircleAvatar(
      backgroundColor: theme.colorScheme.primary,
      child: Icon(
        icon,
        color: theme.colorScheme.onPrimary,
      ),
    );
  }
}
