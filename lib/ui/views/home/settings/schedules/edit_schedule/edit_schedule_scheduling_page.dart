import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/ui/widgets/forms/form_date_field.dart';
import 'package:mona/ui/widgets/forms/form_spacer.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/ui/widgets/forms/model_form.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:provider/provider.dart';

enum _ScheduleType { daily, intervalDays }

class EditScheduleSchedulingPage extends StatefulWidget {
  final MedicationSchedule schedule;

  const EditScheduleSchedulingPage({super.key, required this.schedule});

  @override
  State<EditScheduleSchedulingPage> createState() =>
      _EditScheduleSchedulingPageState();
}

class _EditScheduleSchedulingPageState
    extends State<EditScheduleSchedulingPage> {
  late _ScheduleType _type;

  late TextEditingController _intervalDaysController;
  final List<TimeOfDay> _dailyIntakeTimes = [];
  bool _dailyNotify = true;

  late Date _startDate;

  late MedicationScheduleProvider _medicationScheduleProvider;

  String? get _intervalDaysError => IntervalDaysSchedule.validateIntervalDays(
      context.l10n, _intervalDaysController.text);
  String? get _startDateError =>
      MedicationSchedule.validateStartDate(context.l10n, _startDate);
  String? get _dailyIntakeTimesError =>
      DailySchedule.validateIntakeTimes(context.l10n, _dailyIntakeTimes);

  bool get _isFormValid {
    if (_startDateError != null) return false;
    return switch (_type) {
      _ScheduleType.intervalDays => _intervalDaysError == null,
      _ScheduleType.daily => _dailyIntakeTimesError == null,
    };
  }

  void _refresh() => setState(() {});

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
    if (!mounted) return;

    final SchedulingStrategy scheduling = switch (_type) {
      _ScheduleType.intervalDays => IntervalDaysSchedule(
          intervalDays: _intervalDaysController.text.toInt,
          notificationTimes: List.unmodifiable(_dailyIntakeTimes),
        ),
      _ScheduleType.daily => DailySchedule(
          intakeTimes: List.unmodifiable(_dailyIntakeTimes),
          notify: _dailyNotify,
        ),
    };

    final updatedSchedule = widget.schedule.copyWith(
      scheduling: scheduling,
      startDate: _startDate,
    );

    _medicationScheduleProvider.updateSchedule(updatedSchedule);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _medicationScheduleProvider =
        Provider.of<MedicationScheduleProvider>(context, listen: false);
    _startDate = widget.schedule.startDate;

    final scheduling = widget.schedule.scheduling;
    switch (scheduling) {
      case IntervalDaysSchedule(
          intervalDays: final intervalDays,
          notificationTimes: final notificationTimes,
        ):
        _type = _ScheduleType.intervalDays;
        _intervalDaysController =
            TextEditingController(text: intervalDays.toString());
        _dailyIntakeTimes.addAll(notificationTimes);
        _sortDailyIntakeTimes();
      case DailySchedule(
          intakeTimes: final intakeTimes,
          notify: final notify,
        ):
        _type = _ScheduleType.daily;
        _intervalDaysController = TextEditingController();
        _dailyIntakeTimes.addAll(intakeTimes);
        _sortDailyIntakeTimes();
        _dailyNotify = notify;
    }
  }

  @override
  void dispose() {
    _intervalDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ModelForm(
      title: widget.schedule.name,
      submitButtonLabel: l10n.save,
      isFormValid: _isFormValid,
      saveChanges: _save,
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
          label: l10n.startDate,
          errorText: _startDateError,
          onChanged: (date) => setState(() {
            _startDate = date;
          }),
        ),
      ],
    );
  }

  Widget _typeToggle() {
    final l10n = context.l10n;
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
      actions: [
        M3EToggleButtonGroupAction(label: Text(l10n.scheduleFrequencyDaily)),
        M3EToggleButtonGroupAction(label: Text(l10n.scheduleFrequencyInterval)),
      ],
    );
  }

  List<Widget> _intervalDaysSpecifics() {
    final addCardIndex = _dailyIntakeTimes.length;
    final l10n = context.l10n;
    return [
      FormTextField(
        controller: _intervalDaysController,
        label: l10n.every,
        suffixText: l10n.days,
        onChanged: _refresh,
        inputType: TextInputType.number,
        regexFormatter: '[0-9]',
      ),
      FormSpacer(),
      M3ECardColumn(
        padding: EdgeInsets.zero,
        onTap: (index) {
          if (index == addCardIndex) _addDailyTime();
        },
        children: [
          for (int i = 0; i < _dailyIntakeTimes.length; i++)
            _intervalTimeRow(i),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(l10n.addIntakeTime),
            onTap: () => _addDailyTime(),
          ),
        ],
      ),
    ];
  }

  List<Widget> _dailySpecifics() {
    final l10n = context.l10n;
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
            title: Text(l10n.addIntakeTime),
            onTap: () => _addDailyTime(),
          ),
          SwitchListTile(
            title: Text(l10n.enableNotifications),
            subtitle: Text(l10n.enableNotificationsDescription),
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
      leading: Icon(widget.schedule.administrationRoute.icon),
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

  Widget _intervalTimeRow(int index) {
    final time = _dailyIntakeTimes[index];
    return ListTile(
      leading: Icon(Icons.alarm),
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
