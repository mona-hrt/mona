import 'package:dart_mappable/dart_mappable.dart';
import 'package:decimal/decimal.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/custom_mappers.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/mapping_hooks.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/validators.dart';

part 'medication_schedule.mapper.dart';

@MappableClass(
  // TODO: migrate Molecule (and the daily notification list) to use
  // JsonStringHook (see mapping_hooks.dart) and delete MoleculeJsonMapper /
  // NotificationTimesMapper.
  includeCustomMappers: [
    MoleculeJsonMapper(),
    AdministrationRouteNameMapper(),
    EsterNameMapper(),
    DecimalStringMapper(),
    DateStringMapper(),
  ],
  generateMethods: GenerateMethods.all,
)
class MedicationSchedule with MedicationScheduleMappable {
  final int id;
  final String name;
  final Decimal dose;
  final Date startDate;
  @MappableField(key: 'moleculeJson')
  final Molecule molecule;
  @MappableField(key: 'administrationRouteName')
  final AdministrationRoute administrationRoute;
  @MappableField(key: 'esterName')
  final Ester? ester;
  @MappableField(key: 'schedulingStrategy', hook: JsonStringHook())
  final SchedulingStrategy scheduling;

  MedicationSchedule({
    int? id,
    required this.name,
    required this.dose,
    required this.scheduling,
    Date? startDate,
    required this.molecule,
    required this.administrationRoute,
    this.ester,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch,
        startDate = startDate ?? Date.today();

  static String? Function(Ester?) esterValidator(AppLocalizations l10n,
      Molecule? molecule, AdministrationRoute? administrationRoute) {
    return (Ester? value) {
      return (molecule == KnownMolecules.estradiol &&
              administrationRoute == AdministrationRoute.injection &&
              value == null)
          ? l10n.requiredField
          : null;
    };
  }

  // coverage:ignore-start
  static String? validateName(AppLocalizations l10n, String? value) =>
      requiredString(l10n, value);

  static String? validateDose(AppLocalizations l10n, String? value) =>
      requiredStrictlyPositiveDecimal(l10n, value);

  static String? validateStartDate(AppLocalizations l10n, Date? value) =>
      requiredDate(l10n, value);

  static String? validateMolecule(AppLocalizations l10n, Molecule? value) =>
      requiredMolecule(l10n, value);

  // String formatFrequency() {
  //   if (daysOfWeek.length == 7) return "every day";
  //   if (daysOfWeek.isEmpty) return "no days selected";

  //   const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  //   final selectedDays = daysOfWeek.map((d) => weekdays[d - 1]).join(', ');
  //   return "Every $selectedDays";
  // }

  static String? validateAdministrationRoute(
          AppLocalizations l10n, AdministrationRoute? value) =>
      requiredAdministrationRoute(l10n, value);
  // coverage:ignore-end
}
