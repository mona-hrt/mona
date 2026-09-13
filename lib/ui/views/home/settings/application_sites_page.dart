import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/model/placement.dart';
import 'package:mona/i18n/helpers/placement_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/widgets/forms/form_spacer.dart';
import 'package:provider/provider.dart';

class ApplicationSitesPage extends StatelessWidget {
  const ApplicationSitesPage({super.key});

  Future<void> _addSite(
      BuildContext context, PreferencesService preferencesService) async {
    final placement = await showDialog<Placement>(
      context: context,
      builder: (context) => const _AddSiteDialog(),
    );
    if (placement == null) return;

    final sites = List<Placement>.from(preferencesService.placementsList);
    if (!sites.contains(placement)) {
      await preferencesService.setPlacementsList(sites..add(placement));
    }
  }

  Future<void> _removeSiteAt(
      PreferencesService preferencesService, int index) async {
    final sites = List<Placement>.from(preferencesService.placementsList)
      ..removeAt(index);
    await preferencesService.setPlacementsList(sites);
  }

  Future<void> _reorderSites(
      PreferencesService preferencesService, int oldIndex, int newIndex) async {
    final sites = List<Placement>.from(preferencesService.placementsList);
    if (newIndex > oldIndex) newIndex -= 1;
    final moved = sites.removeAt(oldIndex);
    sites.insert(newIndex, moved);
    await preferencesService.setPlacementsList(sites);
  }

  Widget _addSiteTile(
      BuildContext context, PreferencesService preferencesService) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        key: const ValueKey('addApplicationSiteTile'),
        leading: const Icon(Symbols.add_rounded),
        title: Text(t.addApplicationSite),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: () => _addSite(context, preferencesService),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final preferencesService = context.watch<PreferencesService>();
    final sites = preferencesService.placementsList;

    return Scaffold(
      appBar: AppBar(title: Text(t.applicationSites)),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                t.applicationSitesDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            FormSpacer(),
            if (sites.isEmpty)
              M3ESegmentedColumn(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: Text(t.noApplicationSitesYet),
                    subtitle: Text(t.addSiteToGetStarted),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                  _addSiteTile(context, preferencesService),
                ],
              )
            else
              M3EReorderableSegmentedList(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                keyBuilder: (index) => ValueKey(sites[index]),
                onReorder: (oldIndex, newIndex) =>
                    _reorderSites(preferencesService, oldIndex, newIndex),
                footer: _addSiteTile(context, preferencesService),
                children: [
                  for (int i = 0; i < sites.length; i++)
                    ListTile(
                      title: Text(sites[i].localizedName),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      trailing: IconButton(
                        key: ValueKey('deleteSite_$i'),
                        icon: const Icon(Symbols.delete_outline_rounded),
                        onPressed: () => _removeSiteAt(preferencesService, i),
                      ),
                    ),
                ],
              ),
            FormSpacer(),
            M3ESegmentedColumn(
              padding: EdgeInsets.zero,
              children: [
                Material(
                  type: MaterialType.transparency,
                  child: SwitchListTile(
                    key: const ValueKey('placementScopeToggle'),
                    title: Text(t.placementSuggestionPerScheduleTitle),
                    subtitle: Text(t.placementSuggestionPerScheduleDescription),
                    value: preferencesService.placementSuggestionPerSchedule,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onChanged: (value) => preferencesService
                        .setPlacementSuggestionPerSchedule(value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddSiteDialog extends StatefulWidget {
  const _AddSiteDialog();

  @override
  State<_AddSiteDialog> createState() => _AddSiteDialogState();
}

class _AddSiteDialogState extends State<_AddSiteDialog> {
  final _customController = TextEditingController();

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  Placement? _buildPlacement() {
    final custom = _customController.text.trim();
    if (custom.isNotEmpty) return CustomPlacement(custom);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.addApplicationSite),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final preset in PlacementPreset.values)
                    ListTile(
                      key: ValueKey('presetSite_${preset.name}'),
                      title: Text(preset.localizedName),
                      onTap: () =>
                          Navigator.of(context).pop(PresetPlacement(preset)),
                    ),
                ],
              ),
            ),
            const Divider(),
            TextField(
              key: const ValueKey('customSiteField'),
              controller: _customController,
              decoration: InputDecoration(
                labelText: t.customSiteLabel,
                suffixIcon: IconButton(
                  key: const ValueKey('confirmAddSite'),
                  icon: const Icon(Symbols.add_rounded),
                  onPressed: () => Navigator.of(context).pop(_buildPlacement()),
                ),
              ),
              onSubmitted: (_) => Navigator.of(context).pop(_buildPlacement()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.cancel),
        ),
      ],
    );
  }
}
