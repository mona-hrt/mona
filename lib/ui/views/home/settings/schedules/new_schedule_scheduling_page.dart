import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/ui/views/home/settings/schedules/edit_schedule/edit_schedule_notifications_page.dart';
import 'package:mona/ui/widgets/forms/form_date_field.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/ui/widgets/forms/model_form.dart';
import 'package:mona/util/string_parsing.dart';

class NewScheduleSchedulingPage extends StatefulWidget {
  final String name;
  final Decimal dose;
  final Molecule molecule;
  final AdministrationRoute administrationRoute;
  final Ester? ester;

  const NewScheduleSchedulingPage({
    super.key,
    required this.name,
    required this.dose,
    required this.molecule,
    required this.administrationRoute,
    this.ester,
  });

  @override
  State<NewScheduleSchedulingPage> createState() =>
      _NewScheduleSchedulingPageState();
}

class _NewScheduleSchedulingPageState extends State<NewScheduleSchedulingPage> {
  late TextEditingController _intervalDaysController;
  late Date _startDate;

  String? get _intervalDaysError => MedicationSchedule.validateIntervalDays(
      context.l10n, _intervalDaysController.text);
  String? get _startDateError =>
      MedicationSchedule.validateStartDate(context.l10n, _startDate);

  bool get _isFormValid =>
      _intervalDaysError == null && _startDateError == null;

  void _refresh() {
    setState(() {});
  }

  void _closeAll() {
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  void _next() {
    final intervalDays = _intervalDaysController.text.toInt;

    final schedule = MedicationSchedule(
      name: widget.name,
      dose: widget.dose,
      intervalDays: intervalDays,
      startDate: _startDate,
      molecule: widget.molecule,
      administrationRoute: widget.administrationRoute,
      ester: widget.ester,
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

  @override
  void initState() {
    super.initState();
    _intervalDaysController = TextEditingController();
    _startDate = Date.today();
  }

  @override
  void dispose() {
    _intervalDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    return ModelForm(
      title: widget.name,
      avatar: widget.administrationRoute.icon,
      submitButtonLabel: localizations.next,
      isFormValid: _isFormValid,
      saveChanges: _next,
      closeAll: _closeAll,
      fields: <Widget>[
        FormTextField(
          controller: _intervalDaysController,
          label: localizations.every,
          suffixText: localizations.days,
          onChanged: _refresh,
          inputType: TextInputType.number,
          regexFormatter: '[0-9]',
        ),
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
