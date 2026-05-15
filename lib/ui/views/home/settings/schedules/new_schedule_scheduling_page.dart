import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/ui/widgets/forms/form_date_field.dart';
import 'package:mona/ui/widgets/forms/form_spacer.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/ui/widgets/forms/model_form.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:provider/provider.dart';

// TODO: l10n - all hardcoded strings on this page should move to .arb files.

enum _ScheduleType { daily, intervalDays }

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
  _ScheduleType _type = _ScheduleType.daily;

  late TextEditingController _intervalDaysController;
  bool _intervalNotify = false;
  TimeOfDay? _intervalTime;

  final List<TimeOfDay> _dailyIntakeTimes = [];
  bool _dailyNotify = true;

  late Date _startDate;

  String? get _intervalDaysError => IntervalDaysSchedule.validateIntervalDays(
      context.l10n, _intervalDaysController.text);
  String? get _startDateError =>
      MedicationSchedule.validateStartDate(context.l10n, _startDate);
  String? get _dailyIntakeTimesError =>
      DailySchedule.validateIntakeTimes(context.l10n, _dailyIntakeTimes);

  bool get _isFormValid {
    if (_startDateError != null) return false;
    return switch (_type) {
      _ScheduleType.intervalDays => _intervalDaysError == null &&
          (!_intervalNotify || _intervalTime != null),
      _ScheduleType.daily => _dailyIntakeTimesError == null,
    };
  }

  void _refresh() => setState(() {});

  void _closeAll() {
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  Future<void> _pickIntervalTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _intervalTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _intervalTime = picked;
      });
    }
  }

  Future<void> _addDailyTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;

    final alreadyExists = _dailyIntakeTimes
        .any((t) => t.hour == picked.hour && t.minute == picked.minute);
    if (alreadyExists) return;

    setState(() {
      _dailyIntakeTimes.add(picked);
      _sortDailyIntakeTimes();
    });
  }

  Future<void> _editDailyTime(int index) async {
    final current = _dailyIntakeTimes[index];
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
    );
    if (picked == null) return;
    if (picked.hour == current.hour && picked.minute == current.minute) return;

    final isDuplicate = _dailyIntakeTimes
        .any((t) => t.hour == picked.hour && t.minute == picked.minute);
    if (isDuplicate) return;

    setState(() {
      _dailyIntakeTimes[index] = picked;
      _sortDailyIntakeTimes();
    });
  }

  void _sortDailyIntakeTimes() {
    _dailyIntakeTimes.sort((a, b) {
      final hourCompare = a.hour.compareTo(b.hour);
      return hourCompare != 0 ? hourCompare : a.minute.compareTo(b.minute);
    });
  }

  void _save() {
    if (!_isFormValid) return;

    final SchedulingStrategy scheduling = switch (_type) {
      _ScheduleType.intervalDays => IntervalDaysSchedule(
          intervalDays: _intervalDaysController.text.toInt,
          notificationTime: _intervalNotify ? _intervalTime : null,
        ),
      _ScheduleType.daily => DailySchedule(
          intakeTimes: List.unmodifiable(_dailyIntakeTimes),
          notify: _dailyNotify,
        ),
    };

    final schedule = MedicationSchedule(
      name: widget.name,
      dose: widget.dose,
      scheduling: scheduling,
      startDate: _startDate,
      molecule: widget.molecule,
      administrationRoute: widget.administrationRoute,
      ester: widget.ester,
    );

    Provider.of<MedicationScheduleProvider>(context, listen: false)
        .add(schedule);

    Navigator.of(context)
      ..pop()
      ..pop();
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
    return ModelForm(
      title: widget.name,
      submitButtonLabel: 'Save',
      isFormValid: _isFormValid,
      saveChanges: _save,
      closeAll: _closeAll,
      fields: <Widget>[
        _typeToggle(),
        const SizedBox(height: 16),
        ...switch (_type) {
          _ScheduleType.intervalDays => _intervalDaysSpecifics(),
          _ScheduleType.daily => _dailySpecifics(),
        },
        const SizedBox(height: 16),
        FormDateField(
          date: _startDate,
          label: 'Start date',
          errorText: _startDateError,
          onChanged: (date) => setState(() {
            _startDate = date;
          }),
        ),
      ],
    );
  }

  Widget _typeToggle() {
    return M3EToggleButtonGroup(
      type: M3EButtonGroupType.standard,
      size: M3EButtonSize.md,
      selectedIndex: _type.index,
      onSelectedIndexChanged: (index) {
        if (index == null) return;
        setState(() {
          _type = _ScheduleType.values[index];
        });
      },
      actions: const [
        M3EToggleButtonGroupAction(label: Text('Every day')),
        M3EToggleButtonGroupAction(label: Text('Every n days')),
      ],
    );
  }

  List<Widget> _intervalDaysSpecifics() {
    return [
      FormTextField(
        controller: _intervalDaysController,
        label: 'Every',
        suffixText: 'days',
        onChanged: _refresh,
        inputType: TextInputType.number,
        regexFormatter: '[0-9]',
      ),
      FormSpacer(),
      M3ECardColumn(
        padding: EdgeInsets.zero,
        children: [
          SwitchListTile(
            title: const Text('Enable notifications'),
            value: _intervalNotify,
            onChanged: (value) => setState(() => _intervalNotify = value),
          ),
          if (_intervalNotify)
            ListTile(
              leading: const Icon(Icons.alarm),
              title: Text(_intervalTime?.format(context) ?? 'Pick a time'),
              onTap: _pickIntervalTime,
            ),
        ],
      ),
    ];
  }

  List<Widget> _dailySpecifics() {
    final addCardIndex = _dailyIntakeTimes.length;
    return [
      M3ECardColumn(
        padding: EdgeInsets.zero,
        onTap: (index) {
          if (index == addCardIndex) _addDailyTime();
        },
        children: [
          for (int i = 0; i < _dailyIntakeTimes.length; i++) _intakeTimeRow(i),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add time'),
            onTap: () => _addDailyTime(),
          ),
          SwitchListTile(
            title: const Text('Enable notifications'),
            value: _dailyNotify,
            onChanged: (value) => setState(() => _dailyNotify = value),
          ),
        ],
      ),
    ];
  }

  Widget _intakeTimeRow(int index) {
    final time = _dailyIntakeTimes[index];
    return ListTile(
      leading: Icon(widget.administrationRoute.icon),
      title: Text(time.format(context)),
      onTap: () => _editDailyTime(index),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          setState(() {
            _dailyIntakeTimes.removeAt(index);
          });
        },
      ),
    );
  }
}
