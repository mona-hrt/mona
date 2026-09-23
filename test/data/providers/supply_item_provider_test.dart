import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import '../../fixtures.dart';
import 'generic_repository_mock.dart';

void main() {
  late SupplyItemProvider provider;
  late GenericRepositoryMock<SupplyItem> repo;

  setUp(() async {
    repo = GenericRepositoryMock<SupplyItem>();
    provider = SupplyItemProvider(repository: repo);
    await pumpEventQueue();
  });

  group('SupplyItemProvider', () {
    group('fetchItems', () {
      test('loads items from the repository', () async {
        // Arrange
        await repo.insert(aSupplyItem());
        await repo.insert(aSupplyItem());

        // Act
        await provider.fetchItems();

        // Assert
        expect(provider.items.map((i) => i.id).toList(), [1, 2]);
      });

      test('notifies listeners', () async {
        // Arrange
        var notifications = 0;
        provider.addListener(() => notifications++);

        // Act
        await provider.fetchItems();

        // Assert
        expect(notifications, greaterThan(0));
      });
    });

    group('medicationItems', () {
      test('returns only MedicationSupplyItem entries', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(id: 1));
        await repo.insert(aGenericSupplyItem(id: 2));
        await provider.fetchItems();

        // Act
        final result = provider.medicationItems;

        // Assert
        expect(result.map((i) => i.id).toList(), [1]);
      });

      test('returns an empty list when no medication items are present',
          () async {
        // Arrange
        await repo.insert(aGenericSupplyItem());
        await provider.fetchItems();

        // Act
        final result = provider.medicationItems;

        // Assert
        expect(result, isEmpty);
      });
    });

    group('genericItems', () {
      test('returns only GenericSupply entries', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(id: 1));
        await repo.insert(aGenericSupplyItem(id: 2));
        await provider.fetchItems();

        // Act
        final result = provider.genericItems;

        // Assert
        expect(result.map((i) => i.id).toList(), [2]);
      });

      test('returns an empty list when no generic items are present', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem());
        await provider.fetchItems();

        // Act
        final result = provider.genericItems;

        // Assert
        expect(result, isEmpty);
      });
    });

    group('medicationItemsOrderedByRatio', () {
      test('orders most-used (lowest remaining ratio) first', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
          id: 1,
          name: 'A',
          totalDose: Decimal.parse('100'),
          usedDose: Decimal.parse('90'),
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 2,
          name: 'B',
          totalDose: Decimal.parse('100'),
          usedDose: Decimal.parse('10'),
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 3,
          name: 'C',
          totalDose: Decimal.parse('100'),
          usedDose: Decimal.parse('50'),
        ));
        await provider.fetchItems();

        // Act
        final ordered = provider.medicationItemsOrderedByRatio;

        // Assert
        expect(ordered.map((i) => i.name).toList(), ['A', 'C', 'B']);
      });

      test('ignores generic items', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(id: 1));
        await repo.insert(aGenericSupplyItem(id: 2));
        await provider.fetchItems();

        // Act
        final ordered = provider.medicationItemsOrderedByRatio;

        // Assert
        expect(ordered.map((i) => i.id).toList(), [1]);
      });
    });

    group('orderedByName', () {
      test('allItemsOrderedByName orders items alphabetically by name',
          () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(id: 1, name: 'Banana'));
        await repo.insert(aGenericSupplyItem(id: 2, name: 'Apple'));
        await repo.insert(aMedicationSupplyItem(id: 3, name: 'Carrot'));
        await provider.fetchItems();

        // Act
        final ordered = provider.allItemsOrderedByName;

        // Assert
        expect(
            ordered.map((i) => i.name).toList(), ['Apple', 'Banana', 'Carrot']);
      });

      test(
          'medicationItemsOrderedByName orders only medication items alphabetically by name',
          () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(id: 1, name: 'Banana'));
        await repo.insert(aGenericSupplyItem(id: 2, name: 'Apple'));
        await repo.insert(aMedicationSupplyItem(id: 3, name: 'Carrot'));
        await provider.fetchItems();

        // Act
        final ordered = provider.medicationItemsOrderedByName;

        // Assert
        expect(ordered.map((i) => i.name).toList(), ['Banana', 'Carrot']);
      });

      test(
          'genericItemsOrderedByName orders only generic items alphabetically by name',
          () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(id: 1, name: 'Banana'));
        await repo.insert(aGenericSupplyItem(id: 2, name: 'Apple'));
        await repo.insert(aGenericSupplyItem(id: 3, name: 'Carrot'));
        await provider.fetchItems();

        // Act
        final ordered = provider.genericItemsOrderedByName;

        // Assert
        expect(ordered.map((i) => i.name).toList(), ['Apple', 'Carrot']);
      });
    });

    group('getItemById', () {
      test('returns the matching item', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await repo.insert(aSupplyItem(id: 2));
        await provider.fetchItems();

        // Act
        final found = provider.getItemById(2);

        // Assert
        expect(found?.id, 2);
      });

      test('returns null when no item matches the id', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await provider.fetchItems();

        // Act
        final found = provider.getItemById(999);

        // Assert
        expect(found, isNull);
      });

      test('returns null when the id is null', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await provider.fetchItems();

        // Act
        final found = provider.getItemById(null);

        // Assert
        expect(found, isNull);
      });
    });

    group('getItemsByIds', () {
      test('returns the items matching the given ids', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await repo.insert(aSupplyItem(id: 2));
        await repo.insert(aSupplyItem(id: 3));
        await provider.fetchItems();

        // Act
        final result = provider.getItemsByIds([1, 3]);

        // Assert
        expect(result.map((i) => i.id).toList(), [1, 3]);
      });

      test('preserves the order of the given ids', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await repo.insert(aSupplyItem(id: 2));
        await provider.fetchItems();

        // Act
        final result = provider.getItemsByIds([2, 1]);

        // Assert
        expect(result.map((i) => i.id).toList(), [2, 1]);
      });

      test('skips ids that no longer exist', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await provider.fetchItems();

        // Act
        final result = provider.getItemsByIds([1, 999]);

        // Assert
        expect(result.map((i) => i.id).toList(), [1]);
      });

      test('returns an empty list when given no ids', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await provider.fetchItems();

        // Act
        final result = provider.getItemsByIds([]);

        // Assert
        expect(result, isEmpty);
      });
    });

    group('add', () {
      test('inserts the new item into items', () async {
        // Arrange
        final newItem = aSupplyItem(id: 1);

        // Act
        await provider.add(newItem);

        // Assert
        expect(provider.items, contains(newItem));
      });

      test('notifies listeners', () async {
        // Arrange
        var notifications = 0;
        provider.addListener(() => notifications++);

        // Act
        await provider.add(aSupplyItem(id: 1));

        // Assert
        expect(notifications, greaterThan(0));
      });
    });

    group('updateItem', () {
      test('replaces the item in items with the updated one', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1, name: 'Original'));
        await provider.fetchItems();
        final updated = aSupplyItem(id: 1, name: 'Updated');

        // Act
        await provider.updateItem(updated);

        // Assert
        final result = provider.items.firstWhere((i) => i.id == 1);
        expect(result.name, updated.name);
      });

      test('notifies listeners', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await provider.fetchItems();
        var notifications = 0;
        provider.addListener(() => notifications++);

        // Act
        await provider.updateItem(aSupplyItem(id: 1, name: 'Updated'));

        // Assert
        expect(notifications, greaterThan(0));
      });
    });

    group('deleteItem', () {
      test('removes the given item from items', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await repo.insert(aSupplyItem(id: 2));
        await provider.fetchItems();
        final toDelete = provider.items.firstWhere((i) => i.id == 1);

        // Act
        await provider.deleteItem(toDelete);

        // Assert
        expect(provider.items.map((i) => i.id).toList(), [2]);
      });

      test('notifies listeners', () async {
        // Arrange
        await repo.insert(aSupplyItem(id: 1));
        await provider.fetchItems();
        final toDelete = provider.items.first;
        var notifications = 0;
        provider.addListener(() => notifications++);

        // Act
        await provider.deleteItem(toDelete);

        // Assert
        expect(notifications, greaterThan(0));
      });
    });

    group('getMostUsedItemForMedication', () {
      test('returns the item with the lowest remaining ratio', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
          id: 1,
          totalDose: Decimal.parse('200'),
          usedDose: Decimal.parse('150'),
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 2,
          totalDose: Decimal.parse('200'),
          usedDose: Decimal.parse('50'),
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 3,
          totalDose: Decimal.parse('200'),
          usedDose: Decimal.parse('100'),
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await provider.fetchItems();

        // Act
        final mostUsed = provider.getMostUsedItemForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(mostUsed?.id, 1);
      });

      test('ignores items with a different administration route', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
          id: 1,
          usedDose: Decimal.parse('50'),
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 2,
          usedDose: Decimal.parse('99'),
          administrationRoute: AdministrationRoute.oral,
        ));
        await provider.fetchItems();

        // Act
        final mostUsed = provider.getMostUsedItemForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(mostUsed?.id, 1);
      });

      test('ignores items with a different molecule', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
          id: 1,
          usedDose: Decimal.parse('50'),
          totalDose: Decimal.parse('100'),
          molecule: KnownMolecules.estradiol,
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 2,
          usedDose: Decimal.parse('99'),
          totalDose: Decimal.parse('100'),
          molecule: KnownMolecules.progesterone,
        ));
        await provider.fetchItems();

        // Act
        final mostUsed = provider.getMostUsedItemForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(mostUsed?.id, 1);
      });

      test('ignores items with a different ester', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
          id: 1,
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 2,
          usedDose: Decimal.parse('99'),
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.enanthate,
        ));
        await provider.fetchItems();

        // Act
        final mostUsed = provider.getMostUsedItemForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(mostUsed?.id, 1);
      });

      test('returns null when there are no medication items', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
            id: 1, molecule: KnownMolecules.testosterone));
        await provider.fetchItems();

        // Act
        final mostUsed = provider.getMostUsedItemForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.oral,
          null,
        );

        // Assert
        expect(mostUsed, isNull);
      });

      test('returns null when no medication item matches', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
            id: 1, administrationRoute: AdministrationRoute.oral));
        await provider.fetchItems();

        // Act
        final mostUsed = provider.getMostUsedItemForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(mostUsed, isNull);
      });
    });

    group('getItemsForMedication', () {
      test('returns matching items ordered by most used first', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
          id: 1,
          totalDose: Decimal.parse('200'),
          usedDose: Decimal.parse('150'),
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 2,
          totalDose: Decimal.parse('200'),
          usedDose: Decimal.parse('50'),
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 3,
          totalDose: Decimal.parse('200'),
          usedDose: Decimal.parse('100'),
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await provider.fetchItems();

        // Act
        final items = provider.getItemsForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(items.map((i) => i.id).toList(), [1, 3, 2]);
      });

      test('filters out items with a different molecule', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
          id: 1,
          molecule: KnownMolecules.estradiol,
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 2,
          molecule: KnownMolecules.progesterone,
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await provider.fetchItems();

        // Act
        final items = provider.getItemsForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(items.map((i) => i.id).toList(), [1]);
      });

      test('filters out items with a different administration route', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
          id: 1,
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
            id: 2, administrationRoute: AdministrationRoute.oral));
        await provider.fetchItems();

        // Act
        final items = provider.getItemsForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(items.map((i) => i.id).toList(), [1]);
      });

      test('filters out items with a different ester', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
          id: 1,
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.valerate,
        ));
        await repo.insert(aMedicationSupplyItem(
          id: 2,
          administrationRoute: AdministrationRoute.injection,
          ester: Ester.enanthate,
        ));
        await provider.fetchItems();

        // Act
        final items = provider.getItemsForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(items.map((i) => i.id).toList(), [1]);
      });

      test('returns an empty list when there are no medication items',
          () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
            id: 1, administrationRoute: AdministrationRoute.oral));
        await provider.fetchItems();

        // Act
        final items = provider.getItemsForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(items, isEmpty);
      });

      test('returns an empty list when no medication item matches', () async {
        // Arrange
        await repo.insert(aMedicationSupplyItem(
            id: 1, administrationRoute: AdministrationRoute.oral));
        await provider.fetchItems();

        // Act
        final items = provider.getItemsForMedication(
          KnownMolecules.estradiol,
          AdministrationRoute.injection,
          Ester.valerate,
        );

        // Assert
        expect(items, isEmpty);
      });
    });
  });
}
