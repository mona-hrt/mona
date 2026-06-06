import 'package:intl/intl.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/helpers/administration_route_l10n.dart';
import 'package:mona/l10n/helpers/molecule_l10n.dart';

extension MedicationScheduleL10n on MedicationSchedule {
  String localizedSummary(AppLocalizations localizations) =>
      '$dose ${molecule.unit} • ${molecule.localizedNameWithEster(ester, localizations)} • '
      '${administrationRoute.localizedName(localizations)}';

  String localizedFrequency(AppLocalizations localizations) {
    return switch (scheduling) {
      IntervalDaysSchedule(intervalDays: 1) =>
        localizations.scheduleFrequencyDaily,
      IntervalDaysSchedule(intervalDays: final n) =>
        localizations.scheduleFrequencyEveryNDays(n), // TODO use one, many ?
      DailySchedule _ => localizations.scheduleFrequencyDaily,
      WeeklySchedule s => () {
          if (s.daysOfWeek.length == 7) {
            return localizations.scheduleFrequencyDaily;
          }
          final formatter = DateFormat.E(localizations.localeName);
          final days = s.daysOfWeek
              .map((d) => formatter.format(DateTime(2024, 1, d)))
              .join(', ');
          return days;
        }(),
    };
  }

  String localizedSummaryWithFrequency(AppLocalizations localizations) {
    return '${localizedSummary(localizations)}\n${localizedFrequency(localizations)}';
  }
}
