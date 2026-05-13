import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/controllers/schedule_manager.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/views/home/intake_tile.dart';
import 'package:mona/ui/widgets/main_page_wrapper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.watch<MedicationScheduleProvider>();
    final intakeProvider = context.watch<MedicationIntakeProvider>();
    final localizations = context.l10n;

    final scheduleManager = ScheduleManager(scheduleProvider, intakeProvider);
    final slots = scheduleManager.splitSlotsByDay();

    return MainPageWrapper(
      isLoading: (scheduleProvider.isLoading || intakeProvider.isLoading),
      isEmpty: scheduleProvider.schedules.isEmpty,
      emptyMessage: localizations.empty_home,
      child: SingleChildScrollView(
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(_todayTitle(context)),
              if (slots.today.isEmpty)
                _NoIntakesDueCard(message: localizations.noIntakesDue)
              else
                ...slots.today.map(IntakeTile.new),
              if (slots.upcoming.isNotEmpty) ...[
                _SectionTitle(localizations.upcoming),
                ...slots.upcoming.map(IntakeTile.new),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _todayTitle(BuildContext context) {
    final formatted =
        Date.today().format(DateFormat.MMMMEEEEd(context.languageTag));
    return formatted.replaceRange(
        0, 1, formatted.substring(0, 1).toUpperCase());
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}

class _NoIntakesDueCard extends StatelessWidget {
  const _NoIntakesDueCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card.filled(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.tertiary,
          child: Icon(Symbols.check, color: theme.colorScheme.onTertiary),
        ),
        title: Text(message, style: theme.textTheme.titleMedium),
      ),
    );
  }
}
