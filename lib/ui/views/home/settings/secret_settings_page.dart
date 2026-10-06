import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/providers/blood_test_provider.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/services/demo_mode_service.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/widgets/switch_tile.dart';
import 'package:mona/ui/widgets/tappable_list_tile.dart';
import 'package:provider/provider.dart';

class SecretSettingsPage extends StatelessWidget {
  const SecretSettingsPage({super.key});

  Future<void> _loadDemoData(BuildContext context) async {
    final demoModeService = DemoModeService(
      supplyItemProvider: context.read<SupplyItemProvider>(),
      medicationScheduleProvider: context.read<MedicationScheduleProvider>(),
      medicationIntakeProvider: context.read<MedicationIntakeProvider>(),
      bloodTestProvider: context.read<BloodTestProvider>(),
    );

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Load demo data?'),
        content: const Text(
            'This will erase all your data. You cannot undo this action.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Load demo data'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    await demoModeService.load();
  }

  @override
  Widget build(BuildContext context) {
    final preferencesService = context.watch<PreferencesService>();

    return Scaffold(
      appBar: AppBar(title: Text(t.secretSettings)),
      body: ListView(
        padding: pagePadding +
            EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
        children: [
          M3ESegmentedColumn(
            padding: EdgeInsets.zero,
            children: [
              SwitchTile(
                title: t.slimeMode,
                value: preferencesService.slimeModeEnabled,
                onChanged: (value) =>
                    preferencesService.setSlimeModeEnabled(value),
              ),
              TappableListTile(
                title: 'Demo mode',
                subtitle: 'Replace all data with sample data',
                trailing: const Icon(Symbols.science_rounded),
                onTap: () => _loadDemoData(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
