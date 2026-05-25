import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/helpers/administration_route_l10n.dart';
import 'package:mona/l10n/helpers/molecule_l10n.dart';

extension MedicationScheduleL10n on MedicationSchedule {
  String localizedSummary(AppLocalizations localizations) =>
      '$dose ${molecule.unit} • ${molecule.localizedNameWithEster(ester, localizations)} • '
      '${administrationRoute.localizedName(localizations)}';

  String localizedSummaryWithFrequency(AppLocalizations localizations) {
    final frequency = switch (scheduling) {
      IntervalDaysSchedule(intervalDays: 1) =>
        localizations.scheduleFrequencyDaily,
      IntervalDaysSchedule(intervalDays: final n) =>
        localizations.scheduleFrequencyEveryNDays(n),
      DailySchedule _ => localizations.scheduleFrequencyDaily,
    };

    return '${localizedSummary(localizations)}\n$frequency';
  }
}
