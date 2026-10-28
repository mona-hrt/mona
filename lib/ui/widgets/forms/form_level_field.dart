// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/i18n/helpers/units_l10n.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/util/regex_patterns.dart';

class FormLevelField extends StatelessWidget {
  final TextEditingController controller;
  final ValueComparison comparison;
  final ValueChanged<ValueComparison> onComparisonChanged;
  final VoidCallback onChanged;
  final String label;
  final String? suffixText;
  final String? errorText;

  const FormLevelField({
    super.key,
    required this.controller,
    required this.comparison,
    required this.onComparisonChanged,
    required this.onChanged,
    required this.label,
    this.suffixText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: M3EButton(
            onPressed: () => onComparisonChanged(comparison.next),
            style: M3EButtonStyle.tonal,
            size: M3EButtonSize.md,
            tooltip: comparison.localizedName,
            child: Text(comparison.symbol),
          ),
        ),
        Expanded(
          child: FormTextField(
            controller: controller,
            label: label,
            onChanged: onChanged,
            inputType: const TextInputType.numberWithOptions(decimal: true),
            regexFormatter: RegexPatterns.floatNumber,
            errorText: errorText,
            suffixText: suffixText,
          ),
        ),
      ],
    );
  }
}
