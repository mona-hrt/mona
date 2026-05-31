import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/views/supplies/supply_item_card.dart';
import 'package:mona/ui/widgets/main_page_wrapper.dart';
import 'package:provider/provider.dart';

enum _Filter { all, medication, generic }

class PharmacyPage extends StatefulWidget {
  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  _Filter _filter = _Filter.all;

  List<SupplyItem> _itemsFor(_Filter filter, SupplyItemProvider provider) {
    return switch (filter) {
      _Filter.all => provider.allItemsOrderedByName,
      _Filter.medication => provider.medicationItemsOrderedByName,
      _Filter.generic => provider.genericItemsOrderedByName,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SupplyItemProvider>(
      builder: (context, supplyItemProvider, child) {
        final hasMedication = supplyItemProvider.medicationItems.isNotEmpty;
        final hasGeneric = supplyItemProvider.genericItems.isNotEmpty;

        final effectiveFilter = switch (_filter) {
          _Filter.medication when !hasMedication => _Filter.all,
          _Filter.generic when !hasGeneric => _Filter.all,
          _ => _filter,
        };

        final items = _itemsFor(effectiveFilter, supplyItemProvider);

        return MainPageWrapper(
          isLoading: supplyItemProvider.isLoading,
          isEmpty: supplyItemProvider.items.isEmpty,
          emptyMessage: context.l10n.empty_supplies,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    pagePadding + const EdgeInsets.only(top: 16, bottom: 16),
                child: Align(
                  alignment: Alignment.center,
                  child: _filterToggle(
                    effectiveFilter,
                    hasMedication: hasMedication,
                    hasGeneric: hasGeneric,
                    context: context,
                  ),
                ),
              ),
              Expanded(
                child: MasonryGridView.builder(
                  padding:
                      pagePadding - const EdgeInsets.symmetric(horizontal: 4),
                  gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return SupplyItemCard(item: item);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _filterToggle(
    _Filter effectiveFilter, {
    required bool hasMedication,
    required bool hasGeneric,
    required BuildContext context,
  }) {
    return M3EToggleButtonGroup(
      type: M3EButtonGroupType.standard,
      size: M3EButtonSize.md,
      decoration: M3EToggleButtonDecoration.styleFrom(
        haptic: M3EHapticFeedback.light,
      ),
      selectedIndex: effectiveFilter.index,
      onSelectedIndexChanged: (index) {
        if (index == null) return;
        setState(() {
          _filter = _Filter.values[index];
        });
      },
      actions: [
        const M3EToggleButtonGroupAction(label: Text('All')),
        M3EToggleButtonGroupAction(
          label: const Text('Medication'),
          enabled: hasMedication,
        ),
        M3EToggleButtonGroupAction(
          label: const Text('Generic'),
          enabled: hasGeneric,
          decoration: M3EToggleButtonDecoration.styleFrom(
            checkedBackgroundColor: Theme.of(context).colorScheme.secondary,
            checkedForegroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
