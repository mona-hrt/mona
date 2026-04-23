import 'package:intl/intl.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/helpers/administration_route_l10n.dart';
import 'package:mona/l10n/helpers/molecule_l10n.dart';

extension MedicationScheduleL10n on MedicationSchedule {
  String localizedSummary(AppLocalizations localizations) {
    final firstLine =
        '$dose ${molecule.unit} • ${molecule.localizedNameWithEster(ester, localizations)} • '
        '${administrationRoute.localizedName(localizations)}';

    if (daysOfWeek.isEmpty) return firstLine;

    final String secondLine;
    if (daysOfWeek.length == 7) {
      secondLine = localizations.scheduleFrequencyDaily;
    } else {
      final formatter = DateFormat.EEEE(localizations.localeName);
      secondLine = daysOfWeek
          .map((day) => formatter.format(DateTime(2024, 1, day)))
          .join(', ');
    }

    return '$firstLine\n$secondLine';
  }
}
