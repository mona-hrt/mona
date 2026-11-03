// SPDX-FileCopyrightText: 2026 Alice Lorido "yakissa" <alice@lori.do>
// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileCopyrightText: 2026 Eva Tatarka "evant" <eva@tatarka.me>
// SPDX-FileContributor: Lesley Caramella "vani11agirl"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/model/blood_test.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/data/providers/blood_test_provider.dart';
import 'package:mona/i18n/helpers/units_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/ui/widgets/forms/form_datetime_field.dart';
import 'package:mona/ui/widgets/forms/form_level_field.dart';
import 'package:mona/ui/widgets/forms/form_spacer.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/ui/widgets/forms/model_form.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:provider/provider.dart';

class NewBloodTestPage extends StatefulWidget {
  @override
  State<NewBloodTestPage> createState() => _NewBloodTestPageState();
}

class _NewBloodTestPageState extends State<NewBloodTestPage> {
  late TextEditingController _estradiolLevelsController;
  late TextEditingController _testosteroneLevelsController;
  ValueComparison _estradiolComparison = ValueComparison.equal;
  ValueComparison _testosteroneComparison = ValueComparison.equal;
  late TextEditingController _notesController;
  late DateTime _testDateTime;
  late PreferencesService _preferencesService;

  String? get _testDateError => BloodTest.validateDate(_testDateTime);

  String? get _estradiolError =>
      BloodTest.validateLevel(_estradiolLevelsController.text);

  String? get _testosteroneError =>
      BloodTest.validateLevel(_testosteroneLevelsController.text);

  bool get _isFormValid =>
      _testDateError == null &&
      _estradiolError == null &&
      _testosteroneError == null;

  void _refresh() {
    setState(() {});
  }

  void _onDateTimeChanged(DateTime dateTime) {
    setState(() {
      _testDateTime = dateTime;
    });
  }

  void _addBloodTest() async {
    final bloodTestProvider =
        Provider.of<BloodTestProvider>(context, listen: false);
    final estradiolLevels = _estradiolLevelsController.text.toDecimalOrNull;
    final testosteroneLevels =
        _testosteroneLevelsController.text.toDecimalOrNull;
    final timezone = await FlutterTimezone.getLocalTimezone();
    final tzName = timezone.identifier;
    final notes = _notesController.text.isEmpty ? null : _notesController.text;

    final bloodtest = BloodTest(
      dateTime: _testDateTime.toUtc(),
      timeZone: tzName,
      estradiolLevels: estradiolLevels != null
          ? UnitValue(estradiolLevels, _preferencesService.estradiolUnit,
              comparison: _estradiolComparison)
          : null,
      testosteroneLevels: testosteroneLevels != null
          ? UnitValue(testosteroneLevels, _preferencesService.testosteroneUnit,
              comparison: _testosteroneComparison)
          : null,
      notes: notes,
    );
    await bloodTestProvider.add(bloodtest);

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _estradiolLevelsController = TextEditingController();
    _testosteroneLevelsController = TextEditingController();
    _notesController = TextEditingController();
    _testDateTime = clock.now();
    _preferencesService = Provider.of(context, listen: false);
  }

  @override
  void dispose() {
    _estradiolLevelsController.dispose();
    _testosteroneLevelsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModelForm(
      title: t.newBloodTest,
      avatar: Symbols.lab_panel_rounded,
      submitButtonLabel: t.add,
      isFormValid: _isFormValid,
      saveChanges: _addBloodTest,
      fields: <Widget>[
        FormLevelField(
          controller: _estradiolLevelsController,
          comparison: _estradiolComparison,
          onComparisonChanged: (comparison) =>
              setState(() => _estradiolComparison = comparison),
          label: t.estradiolLevelLabel,
          onChanged: _refresh,
          errorText: _estradiolError,
          suffixText: _preferencesService.estradiolUnit.localizedName,
        ),
        FormLevelField(
          controller: _testosteroneLevelsController,
          comparison: _testosteroneComparison,
          onComparisonChanged: (comparison) =>
              setState(() => _testosteroneComparison = comparison),
          label: t.testosteroneLevelLabel,
          onChanged: _refresh,
          errorText: _testosteroneError,
          suffixText: _preferencesService.testosteroneUnit.localizedName,
        ),
        FormSpacer(),
        FormDateTimeField(
          datetime: _testDateTime,
          label: t.bloodTestDateLabel,
          errorText: _testDateError,
          onChanged: _onDateTimeChanged,
        ),
        FormTextField(
          controller: _notesController,
          label: t.notes,
          fieldKey: const ValueKey('newBloodTestNotes'),
          onChanged: _refresh,
          inputType: TextInputType.multiline,
          multiline: true,
        ),
      ],
    );
  }
}
