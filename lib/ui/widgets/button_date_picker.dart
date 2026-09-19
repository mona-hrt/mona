import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/i18n/build_context_extensions.dart';

class ButtonDatePicker extends StatelessWidget {
  final DateTime datetime;
  final ValueChanged<DateTime> onChanged;
  final String label;
  final String? errorText;

  ButtonDatePicker({
    required this.datetime,
    required this.onChanged,
    required this.label,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final String locale = context.intlLanguageTag;

    return M3EButton(
      style: M3EButtonStyle.filled,
      size: M3EButtonSize.md,
      shape: M3EButtonShape.round,
      onPressed: () => _selectDate(context),
      child: Text(DateFormat.yMMMd(locale)
          .format(datetime)), //datetime.yMMMd().format(datetime)
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: datetime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      picked = DateTime(picked.year, picked.month, picked.day, datetime.hour,
          datetime.minute);
      onChanged(picked);
    }
  }
}
