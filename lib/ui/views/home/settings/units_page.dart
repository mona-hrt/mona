import 'package:flutter/material.dart';
import 'package:mona/data/model/units.dart';
import 'package:mona/i18n/helpers/units_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:provider/provider.dart';

class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesService = context.watch<PreferencesService>();
    void onEstradiolUnitChanged(EstradiolUnit? value) {
      if (value != null) preferencesService.setEstradiolUnit(value);
    }

    void onTestosteroneUnitChanged(TestosteroneUnit? value) {
      if (value != null) preferencesService.setTestosteroneUnit(value);
    }

    return Scaffold(
      appBar: AppBar(title: Text(t.units)),
      body: ListView(
        children: [
          ListTile(
            title: Text(t.estradiol),
          ),
          RadioGroup<EstradiolUnit>(
            groupValue: preferencesService.estradiolUnit,
            onChanged: onEstradiolUnitChanged,
            child: Column(
              children: [
                for (final unit in EstradiolUnit.values)
                  RadioListTile<EstradiolUnit>(
                    title: Text(unit.localizedName),
                    value: unit,
                  ),
              ],
            ),
          ),
          ListTile(
            title: Text(t.testosterone),
          ),
          RadioGroup<TestosteroneUnit>(
            groupValue: preferencesService.testosteroneUnit,
            onChanged: onTestosteroneUnitChanged,
            child: Column(
              children: [
                for (final unit in TestosteroneUnit.values)
                  RadioListTile<TestosteroneUnit>(
                    title: Text(unit.localizedName),
                    value: unit,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
