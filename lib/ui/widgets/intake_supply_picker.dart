// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/model/consumable_supply_item.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/i18n/helpers/supply_item_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/extensions/generic_supply_type_icon.dart';
import 'package:mona/ui/views/supplies/new_item_page.dart';
import 'package:mona/ui/widgets/tappable_list_tile.dart';

class IntakeSupplyPicker extends StatelessWidget {
  final MedicationSupplyItem? medicationItem;
  final List<ConsumableSupplyItem> consumables;
  final List<MedicationSupplyItem> medicationOptions;
  final List<ConsumableSupplyItem> consumableOptions;
  final VoidCallback onRemoveMedication;
  final ValueChanged<int> onRemoveConsumableAt;
  final ValueChanged<MedicationSupplyItem> onAddMedication;
  final ValueChanged<ConsumableSupplyItem> onAddConsumable;

  const IntakeSupplyPicker({
    super.key,
    required this.medicationItem,
    required this.consumables,
    required this.medicationOptions,
    required this.consumableOptions,
    required this.onRemoveMedication,
    required this.onRemoveConsumableAt,
    required this.onAddMedication,
    required this.onAddConsumable,
  });

  Future<void> _openAddSheet(BuildContext context) async {
    final addableMedications =
        medicationOptions.where((o) => o.id != medicationItem?.id).toList();
    final addableConsumables = consumableOptions;

    final isEmpty = addableMedications.isEmpty && addableConsumables.isEmpty;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            if (isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: borderPadding, vertical: 8),
                child: Text(
                  t.noItemsToAdd,
                  style: Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(sheetContext).colorScheme.outline,
                      ),
                ),
              ),
            for (final item in addableMedications)
              ListTile(
                leading:
                    CircleAvatar(child: Icon(item.administrationRoute.icon)),
                title: Text(item.name),
                subtitle: Text(item.localizedConcentrationAndRemaining),
                onTap: () {
                  onAddMedication(item);
                  Navigator.of(sheetContext).pop();
                },
              ),
            for (final item in addableConsumables)
              ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(sheetContext).colorScheme.secondaryContainer,
                  foregroundColor:
                      Theme.of(sheetContext).colorScheme.onSecondaryContainer,
                  child: Icon(item.genericSupplyType.icon),
                ),
                title: Text(item.name),
                subtitle: Text(item.localizedSummary),
                onTap: () {
                  onAddConsumable(item);
                  Navigator.of(sheetContext).pop();
                },
              ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(sheetContext).colorScheme.tertiaryContainer,
                foregroundColor:
                    Theme.of(sheetContext).colorScheme.onTertiaryContainer,
                child: Icon(Symbols.add_rounded),
              ),
              title: Text(t.addAnItem),
              onTap: () async {
                Navigator.of(sheetContext).pop();
                final created = await Navigator.of(context).push(
                  MaterialPageRoute<SupplyItem?>(
                    fullscreenDialog: true,
                    builder: (_) => NewItemPage(),
                  ),
                );
                if (created is ConsumableSupplyItem) {
                  onAddConsumable(created);
                } else if (created is MedicationSupplyItem) {
                  onAddMedication(created);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = medicationItem;
    final items = <Widget>[
      if (item != null)
        ListTile(
          leading: CircleAvatar(child: Icon(item.administrationRoute.icon)),
          title: Text(item.name),
          subtitle: Text(item.localizedConcentrationAndRemaining),
          trailing: IconButton(
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            icon: const Icon(Symbols.close_rounded),
            onPressed: onRemoveMedication,
          ),
        ),
      for (final (index, consumable) in consumables.indexed)
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            child: Icon(consumable.genericSupplyType.icon),
          ),
          title: Text(consumable.name),
          subtitle: Text(consumable.localizedSummary),
          trailing: IconButton(
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            icon: const Icon(Symbols.close_rounded),
            onPressed: () => onRemoveConsumableAt(index),
          ),
        ),
      TappableListTile(
        leading: const Icon(Symbols.add_rounded),
        title: t.chooseItem,
        onTap: () => _openAddSheet(context),
      ),
    ];

    return M3ESegmentedList(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
    );
  }
}
