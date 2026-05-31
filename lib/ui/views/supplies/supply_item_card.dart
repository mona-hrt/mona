import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/l10n/helpers/supply_item_l10n.dart';
import 'package:mona/ui/views/supplies/edit_generic_item_page.dart' as generic;
import 'package:mona/ui/views/supplies/edit_item_page.dart' as medication;

class SupplyItemCard extends StatelessWidget {
  final SupplyItem item;

  const SupplyItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isGeneric = item is GenericSupply;
    final heroBackground =
        isGeneric ? colorScheme.secondary : colorScheme.primary;

    return Card.filled(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openEditPage(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: double.infinity,
                  color: heroBackground,
                  child: Center(child: _buildHeroIcon(context)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    item.localizedSummary(context.l10n),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openEditPage(BuildContext context) {
    final supplyItem = item;
    final route = switch (supplyItem) {
      final MedicationSupplyItem m => MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => medication.EditItemPage(item: m),
        ),
      final GenericSupply g => MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => generic.EditItemPage(item: g),
        ),
      _ => null,
    };
    if (route == null) return;
    Navigator.of(context).push(route);
  }

  Widget _buildHeroIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final supplyItem = item;
    return switch (supplyItem) {
      final MedicationSupplyItem m =>
        m.administrationRoute == AdministrationRoute.injection
            ? SvgPicture.asset(
                _getVialAsset(m.getRatio()),
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              )
            : Icon(
                m.administrationRoute.icon,
                size: 100,
                color: colorScheme.onPrimary,
              ),
      final GenericSupply g => Icon(
          g.genericSupplyType.icon,
          size: 100,
          color: colorScheme.onSecondary,
        ),
      _ => const SizedBox.shrink(),
    };
  }

  String _getVialAsset(double ratio) {
    switch (ratio) {
      case < 0.10:
        return 'assets/pharmacie/fioles/fiole_00.svg';
      case < 0.20:
        return 'assets/pharmacie/fioles/fiole_02.svg';
      case < 0.25:
        return 'assets/pharmacie/fioles/fiole_025.svg';
      case < 0.30:
        return 'assets/pharmacie/fioles/fiole_03.svg';
      case < 0.40:
        return 'assets/pharmacie/fioles/fiole_04.svg';
      case < 0.50:
        return 'assets/pharmacie/fioles/fiole_05.svg';
      case < 0.60:
        return 'assets/pharmacie/fioles/fiole_06.svg';
      case < 0.75:
        return 'assets/pharmacie/fioles/fiole_075.svg';
      case < 0.80:
        return 'assets/pharmacie/fioles/fiole_08.svg';
      case < 0.90:
        return 'assets/pharmacie/fioles/fiole_09.svg';
      default:
        return 'assets/pharmacie/fioles/fiole_1.svg';
    }
  }
}
