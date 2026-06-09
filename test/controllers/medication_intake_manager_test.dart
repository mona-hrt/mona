import 'package:decimal/decimal.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/medication_intake_manager.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/supply_item_provider.dart';

import '../fixtures.dart';

@GenerateNiceMocks([
  MockSpec<MedicationIntakeProvider>(),
  MockSpec<SupplyItemProvider>(),
])
import 'medication_intake_manager_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('flutter_timezone'),
    (MethodCall call) async {
      if (call.method == 'getLocalTimezone') return 'UTC';
      return null;
    },
  );

  late MockMedicationIntakeProvider mockMedicationIntakeProvider;
  late MockSupplyItemProvider mockSupplyItemProvider;
  late MedicationIntakeManager manager;

  setUp(() {
    mockMedicationIntakeProvider = MockMedicationIntakeProvider();
    mockSupplyItemProvider = MockSupplyItemProvider();
    manager = MedicationIntakeManager(
        mockMedicationIntakeProvider, mockSupplyItemProvider);
  });

  group('MedicationIntakeManager', () {
    group('takeMedication', () {
      group('takenDateTime validation', () {
        final localDate = DateTime(2025, 9, 14, 12, 0);

        test('throws ArgumentError when takenDateTime is not UTC', () async {
          // Arrange
          final schedule = aMedicationSchedule();

          // Act / Assert
          await expectLater(
            manager.takeMedication(
              takenDose: Decimal.parse('2'),
              takenDateTime: localDate,
              schedule: schedule,
            ),
            throwsArgumentError,
          );
        });

        test('does not add an intake when takenDateTime is not UTC', () async {
          // Arrange
          final schedule = aMedicationSchedule();

          // Act
          try {
            await manager.takeMedication(
              takenDose: Decimal.parse('2'),
              takenDateTime: localDate,
              schedule: schedule,
            );
          } on ArgumentError {/* swallowed */}

          // Assert
          verifyNever(mockMedicationIntakeProvider.add(any));
        });

        test('does not update the supply item when takenDateTime is not UTC',
            () async {
          // Arrange
          final schedule = aMedicationSchedule();
          final supplyItem = aMedicationSupplyItem();

          // Act
          try {
            await manager.takeMedication(
              takenDose: Decimal.parse('2'),
              takenDateTime: localDate,
              schedule: schedule,
              supplyItem: supplyItem,
            );
          } on ArgumentError {/* swallowed */}

          // Assert
          verifyNever(mockSupplyItemProvider.updateItem(any));
        });
      });

      group('MedicationIntake creation', () {
        late MedicationIntake addedIntake;
        final dose = Decimal.parse('3');
        final takenDate = DateTime.utc(2025, 9, 14, 12, 0);
        final notes = 'yummy';
        final supplyItemId = 99;
        final scheduleId = 42;

        setUp(() async {
          // Arrange
          final supplyItem = aMedicationSupplyItem(
            id: supplyItemId,
            administrationRoute: AdministrationRoute.injection,
            ester: Ester.enanthate,
          );
          final schedule = aMedicationSchedule(
            id: scheduleId,
            dose: dose,
            administrationRoute: AdministrationRoute.injection,
            ester: Ester.enanthate,
          );

          when(mockMedicationIntakeProvider.add(any)).thenAnswer((inv) async {
            addedIntake = inv.positionalArguments.first as MedicationIntake;
          });

          // Act
          await manager.takeMedication(
            takenDose: dose,
            takenDateTime: takenDate,
            supplyItem: supplyItem,
            schedule: schedule,
            side: InjectionSide.right,
            notes: notes,
          );
        });

        test('marks the intake as taken', () {
          // Assert
          expect(addedIntake.isTaken, isTrue);
        });

        test('propagates dose to the intake', () {
          // Assert
          expect(addedIntake.takenDose, dose);
        });

        test('propagates takenDateTime to the intake', () {
          // Assert
          expect(addedIntake.takenDateTime, takenDate);
        });

        test('sets takenTimeZone from the local timezone', () {
          // Assert
          expect(addedIntake.takenTimeZone, 'UTC');
        });

        test('propagates side to the intake', () {
          // Assert
          expect(addedIntake.side, InjectionSide.right);
        });

        test('propagates scheduleId from the schedule', () {
          // Assert
          expect(addedIntake.scheduleId, scheduleId);
        });

        test('propagates molecule from the schedule', () {
          // Assert
          expect(addedIntake.molecule, KnownMolecules.estradiol);
        });

        test('propagates administrationRoute from the schedule', () {
          // Assert
          expect(
              addedIntake.administrationRoute, AdministrationRoute.injection);
        });

        test('propagates ester from the schedule', () {
          // Assert
          expect(addedIntake.ester, Ester.enanthate);
        });

        test('sets supplyItemId from the supplyItem', () {
          // Assert
          expect(addedIntake.supplyItemId, supplyItemId);
        });

        test('sets notes on the intake', () {
          // Assert
          expect(addedIntake.notes, notes);
        });
      });

      group('null supplyItem', () {
        late MedicationIntake addedIntake;

        setUp(() async {
          // Arrange
          final schedule = aMedicationSchedule();
          final date = DateTime.utc(2025, 9, 14, 12, 0);

          when(mockMedicationIntakeProvider.add(any)).thenAnswer((inv) async {
            addedIntake = inv.positionalArguments.first as MedicationIntake;
          });

          // Act
          await manager.takeMedication(
            takenDose: Decimal.parse('2'),
            takenDateTime: date,
            supplyItem: null,
            schedule: schedule,
          );
        });

        test('sets supplyItemId on the intake to null', () {
          // Assert
          expect(addedIntake.supplyItemId, isNull);
        });

        test('does not call the supply provider', () {
          // Assert
          verifyNever(mockSupplyItemProvider.updateItem(any));
        });
      });

      group('GenericSupply', () {
        late MedicationIntake addedIntake;
        late GenericSupply updatedSupplyItem;
        final supplyItem = aGenericSupply(id: 7, amount: 5);

        setUp(() async {
          // Arrange
          final schedule = aMedicationSchedule(
            administrationRoute: AdministrationRoute.injection,
          );
          final date = DateTime.utc(2025, 9, 14, 12, 0);

          when(mockMedicationIntakeProvider.add(any)).thenAnswer((inv) async {
            addedIntake = inv.positionalArguments.first as MedicationIntake;
          });
          when(mockSupplyItemProvider.updateItem(any)).thenAnswer((inv) async {
            updatedSupplyItem = inv.positionalArguments.first as GenericSupply;
          });

          // Act
          await manager.takeMedication(
            takenDose: Decimal.parse('2'),
            takenDateTime: date,
            supplyItem: supplyItem,
            schedule: schedule,
            deadSpace: Decimal.parse('100'),
          );
        });

        test('decrements amount by 1', () {
          // Assert
          expect(updatedSupplyItem.amount, supplyItem.amount - 1);
        });

        test('sets supplyItemId on the intake', () {
          // Assert
          expect(addedIntake.supplyItemId, supplyItem.id);
        });
      });

      group('MedicationSupplyItem', () {
        group('with no deadSpace', () {
          late MedicationSupplyItem updatedSupplyItem;
          final supplyItem = aMedicationSupplyItem(
            usedDose: Decimal.parse('1'),
            concentration: Decimal.parse('1'),
          );
          final dose = Decimal.parse('2');

          setUp(() async {
            // Arrange
            final schedule = aMedicationSchedule(dose: dose);
            final date = DateTime.utc(2025, 9, 14, 12, 0);

            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedSupplyItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act
            await manager.takeMedication(
              takenDose: dose,
              takenDateTime: date,
              supplyItem: supplyItem,
              schedule: schedule,
            );
          });

          test('increases usedDose by the given dose', () {
            // Assert
            expect(updatedSupplyItem.usedDose, supplyItem.usedDose + dose);
          });
        });

        group('with deadSpace > 0', () {
          late MedicationIntake addedIntake;
          late MedicationSupplyItem updatedSupplyItem;
          final supplyItem = aMedicationSupplyItem(
            usedDose: Decimal.parse('1'),
            concentration: Decimal.parse('10'),
          );
          final dose = Decimal.parse('2');
          // 100 μL × 0.001 mL/μL × concentration 10 = 1 extra dose unit.
          final deadSpace = Decimal.parse('100');
          final expectedExtra = Decimal.parse('1');

          setUp(() async {
            // Arrange
            final schedule = aMedicationSchedule(dose: dose);
            final date = DateTime.utc(2025, 9, 14, 12, 0);

            when(mockMedicationIntakeProvider.add(any)).thenAnswer((inv) async {
              addedIntake = inv.positionalArguments.first as MedicationIntake;
            });
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedSupplyItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act
            await manager.takeMedication(
              takenDose: dose,
              takenDateTime: date,
              supplyItem: supplyItem,
              schedule: schedule,
              deadSpace: deadSpace,
            );
          });

          test('adds the deadSpace dose to usedDose', () {
            // Assert
            expect(
              updatedSupplyItem.usedDose,
              supplyItem.usedDose + dose + expectedExtra,
            );
          });

          test('records the original dose (without deadSpace) on the intake',
              () {
            // Assert
            expect(addedIntake.takenDose, dose);
          });
        });

        group('with deadSpace == 0', () {
          late MedicationSupplyItem updatedSupplyItem;
          final supplyItem = aMedicationSupplyItem(
            usedDose: Decimal.parse('1'),
            concentration: Decimal.parse('10'),
          );
          final dose = Decimal.parse('2');

          setUp(() async {
            // Arrange
            final schedule = aMedicationSchedule(dose: dose);
            final date = DateTime.utc(2025, 9, 14, 12, 0);

            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedSupplyItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act
            await manager.takeMedication(
              takenDose: dose,
              takenDateTime: date,
              supplyItem: supplyItem,
              schedule: schedule,
              deadSpace: Decimal.zero,
            );
          });

          test('does not adjust usedDose', () {
            // Assert
            expect(updatedSupplyItem.usedDose, supplyItem.usedDose + dose);
          });
        });

        group('with wastedAmount > 0', () {
          late MedicationIntake addedIntake;
          late MedicationSupplyItem updatedSupplyItem;
          final supplyItem = aMedicationSupplyItem(
            usedDose: Decimal.parse('1'),
            concentration: Decimal.parse('10'),
          );
          final dose = Decimal.parse('2');
          // 0.5 mL × concentration 10 = 5 extra dose units.
          final wastedAmount = Decimal.parse('0.5');
          final expectedExtra = Decimal.parse('5');

          setUp(() async {
            // Arrange
            final schedule = aMedicationSchedule(dose: dose);
            final date = DateTime.utc(2025, 9, 14, 12, 0);

            when(mockMedicationIntakeProvider.add(any)).thenAnswer((inv) async {
              addedIntake = inv.positionalArguments.first as MedicationIntake;
            });
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedSupplyItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act
            await manager.takeMedication(
              takenDose: dose,
              takenDateTime: date,
              supplyItem: supplyItem,
              schedule: schedule,
              wastedAmount: wastedAmount,
            );
          });

          test('adds the wasted dose (concentration × mL) to usedDose', () {
            // Assert
            expect(
              updatedSupplyItem.usedDose,
              supplyItem.usedDose + dose + expectedExtra,
            );
          });

          test('persists wastedAmount in mL on the intake', () {
            // Assert
            expect(addedIntake.wastedAmount, wastedAmount);
          });

          test(
              'records the original takenDose (in molecule units) on the intake',
              () {
            // Assert
            expect(addedIntake.takenDose, dose);
          });
        });
      });
    });

    group('deleteIntake', () {
      group('when supply lookup returns null', () {
        final intake = aMedicationIntake(supplyItemId: 10);

        setUp(() async {
          // Act
          await manager.deleteIntake(intake);
        });

        test('deletes the intake on the provider', () {
          // Assert
          verify(mockMedicationIntakeProvider.deleteIntake(intake)).called(1);
        });

        test('does not call updateItem', () {
          // Assert
          verifyNever(mockSupplyItemProvider.updateItem(any));
        });
      });

      group('GenericSupply', () {
        late GenericSupply updatedSupplyItem;
        final supplyItem = aGenericSupply(id: 7, amount: 5);
        final intake = aMedicationIntake(supplyItemId: supplyItem.id);

        setUp(() async {
          // Arrange
          when(mockSupplyItemProvider.getItemById(supplyItem.id))
              .thenReturn(supplyItem);
          when(mockSupplyItemProvider.updateItem(any)).thenAnswer((inv) async {
            updatedSupplyItem = inv.positionalArguments.first as GenericSupply;
          });

          // Act
          await manager.deleteIntake(intake);
        });

        test('increments amount by 1', () {
          // Assert
          expect(updatedSupplyItem.amount, supplyItem.amount + 1);
        });

        test('deletes the intake on the provider', () {
          // Assert
          verify(mockMedicationIntakeProvider.deleteIntake(intake)).called(1);
        });
      });

      group('MedicationSupplyItem', () {
        group('when intake.dose is within usedDose', () {
          late MedicationSupplyItem updatedSupplyItem;
          final supplyItem = aMedicationSupplyItem(
            usedDose: Decimal.parse('5'),
          );
          final dose = Decimal.parse('2');
          final intake =
              aMedicationIntake(supplyItemId: supplyItem.id, dose: dose);

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.getItemById(supplyItem.id))
                .thenReturn(supplyItem);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedSupplyItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act
            await manager.deleteIntake(intake);
          });

          test('decreases usedDose by intake.dose', () {
            // Assert
            expect(updatedSupplyItem.usedDose, supplyItem.usedDose - dose);
          });

          test('deletes the intake on the provider', () {
            // Assert
            verify(mockMedicationIntakeProvider.deleteIntake(intake)).called(1);
          });
        });

        group('when intake.dose exceeds usedDose', () {
          late MedicationSupplyItem updatedSupplyItem;
          final supplyItem = aMedicationSupplyItem(
            usedDose: Decimal.parse('1'),
          );
          final intake = aMedicationIntake(
            supplyItemId: supplyItem.id,
            dose: Decimal.parse('5'),
          );

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.getItemById(supplyItem.id))
                .thenReturn(supplyItem);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedSupplyItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act
            await manager.deleteIntake(intake);
          });

          test('clamps usedDose to zero', () {
            // Assert
            expect(updatedSupplyItem.usedDose, Decimal.zero);
          });
        });

        group('when intake.dose is zero', () {
          final supplyItem = aMedicationSupplyItem(
            usedDose: Decimal.parse('5'),
          );
          final intake = aMedicationIntake(
            supplyItemId: supplyItem.id,
            dose: Decimal.zero,
          );

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.getItemById(supplyItem.id))
                .thenReturn(supplyItem);

            // Act
            await manager.deleteIntake(intake);
          });

          test('does not call updateItem', () {
            // Assert
            verifyNever(mockSupplyItemProvider.updateItem(any));
          });

          test('deletes the intake on the provider', () {
            // Assert
            verify(mockMedicationIntakeProvider.deleteIntake(intake)).called(1);
          });
        });

        group('when intake has a wastedAmount', () {
          late MedicationSupplyItem updatedSupplyItem;
          final supplyItem = aMedicationSupplyItem(
            totalDose: Decimal.parse('100'),
            usedDose: Decimal.parse('20'),
            concentration: Decimal.parse('10'),
          );
          final dose = Decimal.parse('2');
          // 0.5 mL × concentration 10 = 5 dose units to put back on top of dose.
          final wastedAmount = Decimal.parse('0.5');
          final expectedRollback = Decimal.parse('7'); // 2 + 5
          final intake = aMedicationIntake(
            supplyItemId: supplyItem.id,
            dose: dose,
            wastedAmount: wastedAmount,
          );

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.getItemById(supplyItem.id))
                .thenReturn(supplyItem);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedSupplyItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act
            await manager.deleteIntake(intake);
          });

          test(
              'decreases usedDose by takenDose + (concentration × wastedAmount)',
              () {
            // Assert
            expect(updatedSupplyItem.usedDose,
                supplyItem.usedDose - expectedRollback);
          });
        });
      });
    });

    group('editIntake', () {
      final takenDate = DateTime.utc(2025, 10, 1, 8, 0);
      test('updates all editable fields and preserves the id', () async {
        // Arrange
        late MedicationIntake updatedIntake;
        final intake = aMedicationIntake(
          id: 1,
          dose: Decimal.parse('2'),
          supplyItemId: null,
          wastedAmount: null,
        );
        final newDose = Decimal.parse('3');
        final newWasted = Decimal.parse('0.2');
        final newTimezone = 'Europe/Paris';
        final newNotes = 'edited';

        when(mockMedicationIntakeProvider.updateIntake(any))
            .thenAnswer((inv) async {
          updatedIntake = inv.positionalArguments.first as MedicationIntake;
        });

        // Act
        await manager.editIntake(
          intake,
          takenDose: newDose,
          wastedAmount: newWasted,
          takenDateTime: takenDate,
          takenTimeZone: newTimezone,
          side: InjectionSide.left,
          supplyItem: null,
          notes: newNotes,
        );

        // Assert
        expect(
          updatedIntake,
          isA<MedicationIntake>()
              .having((i) => i.id, 'id', intake.id)
              .having((i) => i.takenDose, 'takenDose', newDose)
              .having((i) => i.wastedAmount, 'wastedAmount', newWasted)
              .having((i) => i.takenDateTime, 'takenDateTime', takenDate)
              .having((i) => i.takenTimeZone, 'takenTimeZone', newTimezone)
              .having((i) => i.side, 'side', InjectionSide.left)
              .having((i) => i.notes, 'notes', newNotes)
              .having((i) => i.supplyItemId, 'supplyItemId', isNull),
        );
      });

      group('supply transitions', () {
        group('previous null, new null', () {
          final intake = aMedicationIntake(supplyItemId: null);

          setUp(() async {
            // Act
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('2'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
            );
          });

          test('does not update any supply', () {
            // Assert
            verifyNever(mockSupplyItemProvider.updateItem(any));
          });
        });

        group('previous null, new GenericSupply', () {
          final newItem = aGenericSupply(id: 7, amount: 5);
          final intake = aMedicationIntake(supplyItemId: null);
          late GenericSupply updatedItem;

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedItem = inv.positionalArguments.first as GenericSupply;
            });

            // Act
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('2'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: newItem,
            );
          });

          test('decrements the new GenericSupply by 1', () {
            // Assert
            expect(updatedItem.amount, newItem.amount - 1);
          });
        });

        group('previous GenericSupply, new null', () {
          final previousItem = aGenericSupply(id: 7, amount: 5);
          final intake = aMedicationIntake(supplyItemId: previousItem.id);
          late GenericSupply updatedItem;

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.getItemById(previousItem.id))
                .thenReturn(previousItem);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedItem = inv.positionalArguments.first as GenericSupply;
            });

            // Act
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('2'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: null,
            );
          });

          test('increments the previous GenericSupply by 1', () {
            // Assert
            expect(updatedItem.amount, previousItem.amount + 1);
          });
        });

        group('previous and new are the same GenericSupply', () {
          final item = aGenericSupply(id: 7, amount: 5);
          final intake = aMedicationIntake(supplyItemId: item.id);

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.getItemById(item.id)).thenReturn(item);

            // Act
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('2'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: item,
            );
          });

          test('does not adjust the supply', () {
            // Assert
            verifyNever(mockSupplyItemProvider.updateItem(any));
          });
        });

        group('previous and new are different GenericSupply', () {
          final previousItem = aGenericSupply(id: 7, amount: 5);
          final newItem = aGenericSupply(id: 8, amount: 2);
          final intake = aMedicationIntake(supplyItemId: previousItem.id);
          final updates = <GenericSupply>[];

          setUp(() async {
            // Arrange
            updates.clear();
            when(mockSupplyItemProvider.getItemById(previousItem.id))
                .thenReturn(previousItem);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updates.add(inv.positionalArguments.first as GenericSupply);
            });

            // Act
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('2'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: newItem,
            );
          });

          test('puts back one on the previous and uses one on the new', () {
            // Assert
            final previousUpdate =
                updates.firstWhere((u) => u.id == previousItem.id);
            final newUpdate = updates.firstWhere((u) => u.id == newItem.id);
            expect(previousUpdate.amount, previousItem.amount + 1);
            expect(newUpdate.amount, newItem.amount - 1);
          });
        });

        group('previous null, new MedicationSupplyItem with wastedAmount', () {
          final newItem = aMedicationSupplyItem(
            usedDose: Decimal.parse('1'),
            concentration: Decimal.parse('10'),
          );
          final intake = aMedicationIntake(supplyItemId: null);
          final takenDose = Decimal.parse('2');
          // 0.5 mL × concentration 10 = 5 dose units on top of takenDose.
          final wastedAmount = Decimal.parse('0.5');
          final expectedUsed = Decimal.parse('8'); // 1 + 2 + 5
          late MedicationSupplyItem updatedItem;

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act
            await manager.editIntake(
              intake,
              takenDose: takenDose,
              wastedAmount: wastedAmount,
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: newItem,
            );
          });

          test(
              'increases usedDose by takenDose + (concentration × wastedAmount)',
              () {
            // Assert
            expect(updatedItem.usedDose, expectedUsed);
          });
        });

        group('previous MedicationSupplyItem, new null', () {
          final previousItem = aMedicationSupplyItem(
            usedDose: Decimal.parse('10'),
            concentration: Decimal.parse('10'),
          );
          // Old intake recorded: dose 2 + 0.5 mL × 10 = 7 used.
          final intake = aMedicationIntake(
            supplyItemId: previousItem.id,
            dose: Decimal.parse('2'),
            wastedAmount: Decimal.parse('0.5'),
          );
          late MedicationSupplyItem updatedItem;

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.getItemById(previousItem.id))
                .thenReturn(previousItem);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('2'),
              wastedAmount: Decimal.parse('0.5'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: null,
            );
          });

          test('rolls back usedDose by the previous used dose', () {
            // Assert
            // 10 - (2 + 5) = 3
            expect(updatedItem.usedDose, Decimal.parse('3'));
          });
        });

        group('previous and new are the same MedicationSupplyItem', () {
          final item = aMedicationSupplyItem(
            usedDose: Decimal.parse('10'),
            concentration: Decimal.parse('10'),
          );
          // Old intake: dose 2 + 0.5 mL × 10 = 7 used.
          final intake = aMedicationIntake(
            supplyItemId: item.id,
            dose: Decimal.parse('2'),
            wastedAmount: Decimal.parse('0.5'),
          );
          late MedicationSupplyItem updatedItem;

          setUp(() async {
            // Arrange
            when(mockSupplyItemProvider.getItemById(item.id)).thenReturn(item);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updatedItem =
                  inv.positionalArguments.first as MedicationSupplyItem;
            });

            // Act: new dose 3 + 0.2 mL × 10 = 5 used.
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('3'),
              wastedAmount: Decimal.parse('0.2'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: item,
            );
          });

          test('adjusts usedDose by the delta between old and new used dose',
              () {
            // Assert
            // 10 + (5 - 7) = 8
            expect(updatedItem.usedDose, Decimal.parse('8'));
          });

          test('writes the supply once', () {
            // Assert
            verify(mockSupplyItemProvider.updateItem(any)).called(1);
          });
        });

        group('previous and new are different MedicationSupplyItem', () {
          final previousItem = aMedicationSupplyItem(
            id: 10,
            usedDose: Decimal.parse('10'),
            concentration: Decimal.parse('10'),
          );
          final newItem = aMedicationSupplyItem(
            id: 11,
            usedDose: Decimal.parse('4'),
            concentration: Decimal.parse('10'),
          );
          // Old intake: 2 + 0.5 × 10 = 7 used.
          final intake = aMedicationIntake(
            supplyItemId: previousItem.id,
            dose: Decimal.parse('2'),
            wastedAmount: Decimal.parse('0.5'),
          );
          final updates = <MedicationSupplyItem>[];

          setUp(() async {
            // Arrange
            updates.clear();
            when(mockSupplyItemProvider.getItemById(previousItem.id))
                .thenReturn(previousItem);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updates
                  .add(inv.positionalArguments.first as MedicationSupplyItem);
            });

            // Act: new dose 3 + 0.2 mL × 10 = 5 used.
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('3'),
              wastedAmount: Decimal.parse('0.2'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: newItem,
            );
          });

          test('rolls back previous and uses new', () {
            // Assert
            final previousUpdate =
                updates.firstWhere((u) => u.id == previousItem.id);
            final newUpdate = updates.firstWhere((u) => u.id == newItem.id);
            // previous: 10 - 7 = 3, new: 4 + 5 = 9
            expect(previousUpdate.usedDose, Decimal.parse('3'));
            expect(newUpdate.usedDose, Decimal.parse('9'));
          });
        });

        group('previous GenericSupply, new MedicationSupplyItem', () {
          final previousItem = aGenericSupply(id: 7, amount: 5);
          final newItem = aMedicationSupplyItem(
            id: 11,
            usedDose: Decimal.parse('4'),
            concentration: Decimal.parse('10'),
          );
          final intake = aMedicationIntake(supplyItemId: previousItem.id);
          final updates = <SupplyItem>[];

          setUp(() async {
            // Arrange
            updates.clear();
            when(mockSupplyItemProvider.getItemById(previousItem.id))
                .thenReturn(previousItem);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updates.add(inv.positionalArguments.first as SupplyItem);
            });

            // Act: new dose 3 + 0.2 mL × 10 = 5 used.
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('3'),
              wastedAmount: Decimal.parse('0.2'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: newItem,
            );
          });

          test('puts back the GenericSupply and uses dose on the new item', () {
            // Assert
            final previousUpdate =
                updates.whereType<GenericSupply>().firstWhere(
                      (u) => u.id == previousItem.id,
                    );
            final newUpdate =
                updates.whereType<MedicationSupplyItem>().firstWhere(
                      (u) => u.id == newItem.id,
                    );
            expect(previousUpdate.amount, previousItem.amount + 1);
            // 4 + 5 = 9
            expect(newUpdate.usedDose, Decimal.parse('9'));
          });
        });

        group('previous MedicationSupplyItem, new GenericSupply', () {
          final previousItem = aMedicationSupplyItem(
            id: 10,
            usedDose: Decimal.parse('10'),
            concentration: Decimal.parse('10'),
          );
          final newItem = aGenericSupply(id: 7, amount: 5);
          // Old intake: 2 + 0.5 × 10 = 7 used.
          final intake = aMedicationIntake(
            supplyItemId: previousItem.id,
            dose: Decimal.parse('2'),
            wastedAmount: Decimal.parse('0.5'),
          );
          final updates = <SupplyItem>[];

          setUp(() async {
            // Arrange
            updates.clear();
            when(mockSupplyItemProvider.getItemById(previousItem.id))
                .thenReturn(previousItem);
            when(mockSupplyItemProvider.updateItem(any))
                .thenAnswer((inv) async {
              updates.add(inv.positionalArguments.first as SupplyItem);
            });

            // Act
            await manager.editIntake(
              intake,
              takenDose: Decimal.parse('3'),
              wastedAmount: Decimal.parse('0.2'),
              takenDateTime: takenDate,
              takenTimeZone: 'Etc/UTC',
              supplyItem: newItem,
            );
          });

          test(
              'rolls back the previous MedicationSupplyItem and uses the new'
              ' GenericSupply', () {
            // Assert
            final previousUpdate =
                updates.whereType<MedicationSupplyItem>().firstWhere(
                      (u) => u.id == previousItem.id,
                    );
            final newUpdate = updates.whereType<GenericSupply>().firstWhere(
                  (u) => u.id == newItem.id,
                );
            // 10 - 7 = 3
            expect(previousUpdate.usedDose, Decimal.parse('3'));
            expect(newUpdate.amount, newItem.amount - 1);
          });
        });
      });
    });

    group('getNextSide', () {
      test('returns right when last injection side is left', () {
        // Arrange
        final firstIntake = MedicationIntake(
          id: 1,
          takenDose: Decimal.parse('2.5'),
          takenDateTime: DateTime.utc(2025, 9, 14, 12, 0),
          takenTimeZone: 'Etc/UTC',
          scheduleId: 42,
          side: InjectionSide.left,
          molecule: KnownMolecules.estradiol,
          administrationRoute: AdministrationRoute.injection,
        );
        when(mockMedicationIntakeProvider.getLastTakenInjectionIntake())
            .thenReturn(firstIntake);

        // Act
        final InjectionSide nextSide = manager.getNextSide();

        // Assert
        expect(nextSide, InjectionSide.right);
      });

      test('returns left when last injection side is right', () {
        // Arrange
        final lastIntake = MedicationIntake(
          id: 2,
          takenDose: Decimal.parse('2.5'),
          takenDateTime: DateTime.utc(2025, 9, 15, 12, 0),
          takenTimeZone: 'Etc/UTC',
          scheduleId: 42,
          side: InjectionSide.right,
          molecule: KnownMolecules.estradiol,
          administrationRoute: AdministrationRoute.injection,
        );
        when(mockMedicationIntakeProvider.getLastTakenInjectionIntake())
            .thenReturn(lastIntake);

        // Act / Assert
        expect(manager.getNextSide(), InjectionSide.left);
      });

      test('returns left when there is no last injection intake', () {
        // Arrange
        when(mockMedicationIntakeProvider.getLastTakenInjectionIntake())
            .thenReturn(null);

        // Act / Assert
        expect(manager.getNextSide(), InjectionSide.left);
      });

      test('returns left when last injection intake side is null', () {
        // Arrange
        final intake = MedicationIntake(
          id: 3,
          takenDose: Decimal.parse('2.5'),
          takenDateTime: DateTime.utc(2025, 9, 16, 12, 0),
          takenTimeZone: 'Etc/UTC',
          scheduleId: 42,
          side: null,
          molecule: KnownMolecules.estradiol,
          administrationRoute: AdministrationRoute.injection,
        );
        when(mockMedicationIntakeProvider.getLastTakenInjectionIntake())
            .thenReturn(intake);

        // Act / Assert
        expect(manager.getNextSide(), InjectionSide.left);
      });

      test(
          'alternates from last injection even when a non-injection intake was taken more recently',
          () {
        // Arrange
        final lastInjection = MedicationIntake(
          id: 4,
          takenDose: Decimal.parse('2.5'),
          takenDateTime: DateTime.utc(2025, 9, 14, 12, 0),
          takenTimeZone: 'Etc/UTC',
          scheduleId: 42,
          side: InjectionSide.left,
          molecule: KnownMolecules.estradiol,
          administrationRoute: AdministrationRoute.injection,
        );
        when(mockMedicationIntakeProvider.getLastTakenInjectionIntake())
            .thenReturn(lastInjection);

        // Act / Assert
        expect(manager.getNextSide(), InjectionSide.right);
      });
    });
  });
}
