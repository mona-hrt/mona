import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  bool _intervalNotify = false;
  TimeOfDay? _intervalTime;

  final List<TimeOfDay> _dailyIntakeTimes = [];
  bool _dailyNotify = true;

  final List<int> _weeklyDays = [];
  final List<TimeOfDay> _weeklyIntakeTimes = [];
  bool _weeklyNotify = true;

  late Date _startDate;

  String? get _intervalDaysError => IntervalDaysSchedule.validateIntervalDays(
      context.l10n, _intervalDaysController.text);
  String? get _startDateError =>
      MedicationSchedule.validateStartDate(context.l10n, _startDate);
  String? get _dailyIntakeTimesError =>
      DailySchedule.validateIntakeTimes(context.l10n, _dailyIntakeTimes);
  String? get _weeklyIntakeTimesError =>
      WeeklySchedule.validateIntakeTimes(context.l10n, _weeklyIntakeTimes);
  String? get _weeklyDaysError =>
      WeeklySchedule.validateDaysOfWeek(context.l10n, _weeklyDays);

  bool get _isFormValid {
    if (_startDateError != null) return false;
    return switch (_type) {
      _ScheduleType.intervalDays => _intervalDaysError == null &&
          (!_intervalNotify || _intervalTime != null),
      _ScheduleType.daily => _dailyIntakeTimesError == null,
      _ScheduleType.weekly =>
        _weeklyDaysError == null && _weeklyIntakeTimesError == null,
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

  Future<void> _addTime(List<TimeOfDay> times) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;

    final alreadyExists =
        times.any((t) => t.hour == picked.hour && t.minute == picked.minute);
    if (alreadyExists) return;

    setState(() {
      times.add(picked);
      _sortTimes(times);
    });
  }

  Future<void> _editTime(List<TimeOfDay> times, int index) async {
    final current = times[index];
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
    );
    if (picked == null) return;
    if (picked.hour == current.hour && picked.minute == current.minute) return;

    final isDuplicate =
        times.any((t) => t.hour == picked.hour && t.minute == picked.minute);
    if (isDuplicate) return;

    setState(() {
      times[index] = picked;
      _sortTimes(times);
    });
  }

  void _sortTimes(List<TimeOfDay> times) {
    times.sort((a, b) {
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
      _ScheduleType.weekly => WeeklySchedule(
          daysOfWeek: List.unmodifiable(_weeklyDays),
          intakeTimes: List.unmodifiable(_weeklyIntakeTimes),
          notify: _weeklyNotify,
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
        children: [
          SwitchListTile(
            title: Text(l10n.enableNotifications),
            subtitle: Text(l10n.enableNotificationsDescription),
            value: _intervalNotify,
            onChanged: (value) => setState(() => _intervalNotify = value),
          ),
          if (_intervalNotify)
            ListTile(
              leading: const Icon(Icons.alarm),
              title: Text(_intervalTime?.format(context) ?? l10n.pickATime),
              onTap: _pickIntervalTime,
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
          if (index == addCardIndex) _addTime(_dailyIntakeTimes);
        },
        children: [
          for (int i = 0; i < _dailyIntakeTimes.length; i++)
            _intakeTimeRow(_dailyIntakeTimes, i),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(l10n.addIntakeTime),
            onTap: () => _addTime(_dailyIntakeTimes),
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
    final addCardIndex = _weeklyIntakeTimes.length;
    return [
      _dayPicker(),
      const SizedBox(height: 16),
      M3ECardColumn(
        padding: EdgeInsets.zero,
        onTap: (index) {
          if (index == addCardIndex) _addTime(_weeklyIntakeTimes);
        },
        children: [
          for (int i = 0; i < _weeklyIntakeTimes.length; i++)
            _intakeTimeRow(_weeklyIntakeTimes, i),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(l10n.addIntakeTime),
            onTap: () => _addTime(_weeklyIntakeTimes),
          ),
          SwitchListTile(
            title: Text(l10n.enableNotifications),
            subtitle: Text(l10n.enableNotificationsDescription),
            value: _weeklyNotify,
            onChanged: (value) => setState(() => _weeklyNotify = value),
          ),
        ],
      ),
    ];
  }

  Widget _dayPicker() {
    final weekdays = [1, 2, 3, 4, 5, 6, 7];

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(context.l10n.days,
              style: Theme.of(context).textTheme.labelLarge),
          if (_weeklyDaysError != null)
            Text(_weeklyDaysError!,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.error)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.center,
            children: weekdays.map((day) {
              final isSelected = _weeklyDays.contains(day);
              return FilterChip(
                label: Text(_getWeekdayName(day)),
                selected: isSelected,
                showCheckmark: false,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _weeklyDays.add(day);
                    } else {
                      _weeklyDays.remove(day);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getWeekdayName(int day) {
    final date = DateTime(2024, 1, day);
    return DateFormat.E(Localizations.localeOf(context).languageCode)
        .format(date);
  }

  Widget _intakeTimeRow(List<TimeOfDay> times, int index) {
    final time = times[index];
    return ListTile(
      leading: Icon(widget.administrationRoute.icon),
      title: Text(time.format(context)),
      onTap: () => _editTime(times, index),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          setState(() {
            times.removeAt(index);
          });
        },
      ),
    );
  }
}
