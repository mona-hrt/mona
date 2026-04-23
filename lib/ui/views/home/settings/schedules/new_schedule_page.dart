import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/ui/views/home/settings/schedules/edit_schedule/edit_schedule_notifications_page.dart';
import 'package:mona/ui/widgets/dropdowns/administration_route_dropdown.dart';
import 'package:mona/ui/widgets/dropdowns/ester_dropdown.dart';
import 'package:mona/ui/widgets/dropdowns/molecule_dropdown.dart';
import 'package:mona/ui/widgets/forms/form_date_field.dart';
import 'package:mona/ui/widgets/forms/form_dropdown_field.dart';
import 'package:mona/ui/widgets/forms/form_spacer.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/ui/widgets/forms/model_form.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:provider/provider.dart';

class NewSchedulePage extends StatefulWidget {
  @override
  State<NewSchedulePage> createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  late TextEditingController _nameController;
  late TextEditingController _doseController;
  final List<int> _selectedDaysOfWeek = [];
  late Date _startDate;
  Molecule? _molecule;
  AdministrationRoute? _administrationRoute;
  Ester? _ester;
  late PreferencesService _preferencesService;

  String? get _nameError =>
      MedicationSchedule.validateName(context.l10n, _nameController.text);
  String? get _doseError =>
      MedicationSchedule.validateDose(context.l10n, _doseController.text);
  String? get _daysOfWeekError =>
      _selectedDaysOfWeek.isEmpty ? 'Please select at least one day' : null;
  String? get _startDateError =>
      MedicationSchedule.validateStartDate(context.l10n, _startDate);
  String? get _moleculeError =>
      MedicationSchedule.validateMolecule(context.l10n, _molecule);
  String? get _administrationRouteError =>
      MedicationSchedule.validateAdministrationRoute(
          context.l10n, _administrationRoute);
  String? get _esterError {
    final validator = MedicationSchedule.esterValidator(
        context.l10n, _molecule, _administrationRoute);
    return validator(_ester);
  }

  bool get _isFormValid =>
      _nameError == null &&
      _doseError == null &&
      _daysOfWeekError == null &&
      _startDateError == null &&
      _moleculeError == null &&
      _administrationRouteError == null &&
      _esterError == null;

  bool get _useEsterField =>
      _molecule == KnownMolecules.estradiol &&
      _administrationRoute == AdministrationRoute.injection;

  void _onMoleculeChanged(Molecule? molecule) {
    if (molecule != null) {
      setState(() {
        _molecule = molecule;

        if (!_useEsterField) {
          _ester = null;
        }
      });
    }
  }

  void _onAdministrationRouteChanged(AdministrationRoute? administrationRoute) {
    if (administrationRoute != null) {
      setState(() {
        _administrationRoute = administrationRoute;

        if (!_useEsterField) {
          _ester = null;
        }
      });
    }
  }

  void _onEsterChanged(Ester? ester) {
    if (ester != null) {
      setState(() {
        _ester = ester;
      });
    }
  }

  void _refresh() {
    setState(() {});
  }

  void _addSchedule() {
    final name = _nameController.text;
    final dose = _doseController.text.toDecimal;
    final startDate = _startDate;

    final schedule = MedicationSchedule(
      name: name,
      dose: dose,
      daysOfWeek: _selectedDaysOfWeek,
      startDate: startDate,
      molecule: _molecule!,
      administrationRoute: _administrationRoute!,
      ester: _ester,
      notificationTimes: List.empty(),
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScheduleNotificationsPage(
          schedule: schedule,
          isNewSchedule: true,
        ),
      ),
    );
  }

  Widget _buildDaysOfWeekSelector() {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    Widget buildChip(int index) {
      final dayInt = index + 1;
      final isSelected = _selectedDaysOfWeek.contains(dayInt);

      return ActionChip(
        label: Text(days[index]),
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surface,
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outlineVariant,
        ),
        onPressed: () {
          setState(() {
            if (isSelected) {
              _selectedDaysOfWeek.remove(dayInt);
            } else {
              _selectedDaysOfWeek.add(dayInt);
            }
            _selectedDaysOfWeek.sort();
          });
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Days of the week',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildChip(0),
                  const SizedBox(width: 8),
                  buildChip(1),
                  const SizedBox(width: 8),
                  buildChip(2),
                  const SizedBox(width: 8),
                  buildChip(3),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildChip(4),
                  const SizedBox(width: 8),
                  buildChip(5),
                  const SizedBox(width: 8),
                  buildChip(6),
                ],
              ),
            ],
          ),
          if (_daysOfWeekError != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _daysOfWeekError!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _preferencesService =
        Provider.of<PreferencesService>(context, listen: false);
    _nameController = TextEditingController();
    _doseController = TextEditingController();
    _startDate = Date.today();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _doseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    return ModelForm(
      title: localizations.newSchedule,
      submitButtonLabel: localizations.next,
      isFormValid: _isFormValid,
      saveChanges: _addSchedule,
      fields: <Widget>[
        FormTextField(
          controller: _nameController,
          label: localizations.name,
          onChanged: _refresh,
          inputType: TextInputType.text,
        ),
        FormSpacer(),
        FormDropdownField<Molecule>(
          value: _molecule,
          items: moleculeDropdownMenuItems(
            _preferencesService.allMolecules,
            localizations,
          ),
          onChanged: _onMoleculeChanged,
          label: localizations.molecule,
        ),
        FormDropdownField<AdministrationRoute>(
          value: _administrationRoute,
          items: administrationRouteDropdownMenuItems(localizations),
          onChanged: _onAdministrationRouteChanged,
          label: localizations.adminRoute,
        ),
        if (_useEsterField)
          FormDropdownField<Ester>(
            value: _ester,
            items: esterDropdownMenuItems(localizations),
            onChanged: _onEsterChanged,
            label: localizations.ester,
          ),
        FormSpacer(),
        FormTextField(
          controller: _doseController,
          label: localizations.amount,
          suffixText: _molecule?.unit,
          onChanged: _refresh,
          inputType: TextInputType.numberWithOptions(decimal: true),
          regexFormatter: '[0-9.,]',
        ),
        _buildDaysOfWeekSelector(),
        FormDateField(
          date: _startDate,
          label: localizations.startDate,
          errorText: _startDateError,
          onChanged: (date) => setState(() {
            _startDate = date;
          }),
        ),
      ],
    );
  }
}
