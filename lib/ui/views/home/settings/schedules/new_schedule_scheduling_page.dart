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
import 'package:mona/ui/widgets/weekday_picker.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:provider/provider.dart';

enum _ScheduleType { daily, intervalDays, weekly }

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
  final List<TimeOfDay> _intakeOrNotificationTimes = [];
  bool _dailyNotify = true;
  final List<int> _weeklyDays = [];
  late Date _startDate;

  String? get _intervalDaysError => IntervalDaysSchedule.validateIntervalDays(
      context.l10n, _intervalDaysController.text);
  String? get _startDateError =>
      MedicationSchedule.validateStartDate(context.l10n, _startDate);
  String? get _dailyIntakeTimesError => DailySchedule.validateIntakeTimes(
      context.l10n, _intakeOrNotificationTimes);
  String? get _weeklyDaysError =>
      WeeklySchedule.validateDaysOfWeek(context.l10n, _weeklyDays);

  bool get _isFormValid {
    if (_startDateError != null) return false;
    return switch (_type) {
      _ScheduleType.intervalDays => _intervalDaysError == null,
      _ScheduleType.daily => _dailyIntakeTimesError == null,
      _ScheduleType.weekly => _weeklyDaysError == null,
    };
  }

  void _refresh() => setState(() {});

  void _closeAll() {
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  Future<void> _addTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;

    final alreadyExists = _intakeOrNotificationTimes
        .any((t) => t.hour == picked.hour && t.minute == picked.minute);
    if (alreadyExists) return;

    setState(() {
      _intakeOrNotificationTimes.add(picked);
      _sortTimes();
    });
  }

  Future<void> _editTime(int index) async {
    final current = _intakeOrNotificationTimes[index];
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
    );
    if (picked == null) return;
    if (picked.hour == current.hour && picked.minute == current.minute) return;

    final isDuplicate = _intakeOrNotificationTimes
        .any((t) => t.hour == picked.hour && t.minute == picked.minute);
    if (isDuplicate) return;

    setState(() {
      _intakeOrNotificationTimes[index] = picked;
      _sortTimes();
    });
  }

  void _sortTimes() {
    _intakeOrNotificationTimes.sort((a, b) {
      final hourCompare = a.hour.compareTo(b.hour);
      return hourCompare != 0 ? hourCompare : a.minute.compareTo(b.minute);
    });
  }

  void _save() {
    if (!_isFormValid) return;

    final SchedulingStrategy scheduling = switch (_type) {
      _ScheduleType.intervalDays => IntervalDaysSchedule(
          intervalDays: _intervalDaysController.text.toInt,
          notificationTimes: List.unmodifiable(_intakeOrNotificationTimes),
        ),
      _ScheduleType.daily => DailySchedule(
          intakeTimes: List.unmodifiable(_intakeOrNotificationTimes),
          notify: _dailyNotify,
        ),
      _ScheduleType.weekly => WeeklySchedule(
          daysOfWeek: List.unmodifiable(_weeklyDays),
          notificationTimes: List.unmodifiable(_intakeOrNotificationTimes),
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
    final l10n = context.l10n;

    return ModelForm(
      title: widget.name,
      submitButtonLabel: l10n.save,
      isFormValid: _isFormValid,
      saveChanges: _save,
      closeAll: _closeAll,
      fields: <Widget>[
        _typeToggle(),
        const SizedBox(height: 16),
        ...switch (_type) {
          _ScheduleType.intervalDays => _intervalDaysSpecifics(),
          _ScheduleType.daily => _dailySpecifics(),
          _ScheduleType.weekly => _weeklySpecifics(),
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
        M3EToggleButtonGroupAction(label: Text(l10n.scheduleFrequencyWeekly)),
      ],
    );
  }

  List<Widget> _intervalDaysSpecifics() {
    final addCardIndex = _intakeOrNotificationTimes.length;
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
          if (index == addCardIndex) _addTime();
        },
        children: [
          for (int i = 0; i < _intakeOrNotificationTimes.length; i++)
            _intervalTimeRow(i),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(l10n.addNotification),
            onTap: () => _addTime(),
          ),
        ],
      ),
    ];
  }

  List<Widget> _dailySpecifics() {
    final l10n = context.l10n;
    final addCardIndex = _intakeOrNotificationTimes.length;
    return [
      M3ECardColumn(
        padding: EdgeInsets.zero,
        onTap: (index) {
          if (index == addCardIndex) _addTime();
        },
        children: [
          for (int i = 0; i < _intakeOrNotificationTimes.length; i++)
            _intakeTimeRow(i),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(l10n.addIntakeTime),
            onTap: () => _addTime(),
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

  List<Widget> _weeklySpecifics() {
    final l10n = context.l10n;
    final addCardIndex = _intakeOrNotificationTimes.length;
    return [
      WeekdayPicker(
        selectedDays: _weeklyDays,
        errorText: _weeklyDaysError,
        onDayToggled: _toggleWeeklyDay,
      ),
      const SizedBox(height: 16),
      M3ECardColumn(
        padding: EdgeInsets.zero,
        onTap: (index) {
          if (index == addCardIndex) _addTime();
        },
        children: [
          for (int i = 0; i < _intakeOrNotificationTimes.length; i++)
            _intakeTimeRow(i),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(l10n.addNotification),
            onTap: () => _addTime(),
          ),
        ],
      ),
    ];
  }

  void _toggleWeeklyDay(int day, bool selected) {
    setState(() {
      if (selected) {
        _weeklyDays.add(day);
      } else {
        _weeklyDays.remove(day);
      }
    });
  }

  Widget _intakeTimeRow(int index) {
    final time = _intakeOrNotificationTimes[index];
    return ListTile(
      leading: Icon(widget.administrationRoute.icon),
      title: Text(time.format(context)),
      onTap: () => _editTime(index),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          setState(() {
            _intakeOrNotificationTimes.removeAt(index);
          });
        },
      ),
    );
  }

  Widget _intervalTimeRow(int index) {
    final time = _intakeOrNotificationTimes[index];
    return ListTile(
      leading: Icon(Icons.alarm),
      title: Text(time.format(context)),
      onTap: () => _editTime(index),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          setState(() {
            _intakeOrNotificationTimes.removeAt(index);
          });
        },
      ),
    );
  }
}
