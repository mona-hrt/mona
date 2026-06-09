import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:mona/controllers/supply_item_manager.dart';
import 'package:mona/data/model/generic_supply_item.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import '../data/model/medication_intake.dart';
import '../data/providers/medication_intake_provider.dart';

class MedicationIntakeManager {
  final MedicationIntakeProvider _medicationIntakeProvider;
  final SupplyItemProvider _supplyItemProvider;

  MedicationIntakeManager(
      this._medicationIntakeProvider, this._supplyItemProvider);

  Future<void> takeMedication({
    required Decimal takenDose,
    TimeOfDay? scheduledTime,
    required DateTime takenDateTime,
    SupplyItem? supplyItem,
    required MedicationSchedule schedule,
    InjectionSide? side,
    Decimal? deadSpace, //in μL
    String? notes,
    Decimal? wastedAmount, // in mL
  }) async {
    if (!takenDateTime.isUtc) {
      throw ArgumentError('takenDateTime must be in UTC');
    }

    final timezone = await FlutterTimezone.getLocalTimezone();
    final tzName = timezone.identifier;

    await _medicationIntakeProvider.add(MedicationIntake(
      takenDose: takenDose,
      scheduledTime: scheduledTime,
      takenDateTime: takenDateTime,
      takenTimeZone: tzName,
      side: side,
      scheduleId: schedule.id,
      molecule: schedule.molecule,
      administrationRoute: schedule.administrationRoute,
      ester: schedule.ester,
      supplyItemId: supplyItem?.id,
      notes: notes,
      wastedAmount: wastedAmount,
    ));

    final itemManager = SupplyItemManager(_supplyItemProvider);

    switch (supplyItem) {
      case null:
        return;
      case GenericSupply _:
        await itemManager.use(supplyItem);
        return;
      case MedicationSupplyItem _:
        if (deadSpace != null && deadSpace > Decimal.zero) {
          final microlitersToMilliliters = Decimal.parse('0.001');
          takenDose +=
              (supplyItem).getDose(deadSpace * microlitersToMilliliters);
        }
        if (wastedAmount != null && wastedAmount > Decimal.zero) {
          takenDose += (supplyItem).getDose(wastedAmount);
        }
        await itemManager.useDose(supplyItem, takenDose);
    }
  }

  Future<void> deleteIntake(MedicationIntake intake) async {
    await _medicationIntakeProvider.deleteIntake(intake);

    final SupplyItem? item =
        _supplyItemProvider.getItemById(intake.supplyItemId);
    final itemManager = SupplyItemManager(_supplyItemProvider);

    switch (item) {
      case null:
        return;
      case GenericSupply _:
        await itemManager.putBack(item);
        return;
      case MedicationSupplyItem _:
        final wastedDose = item.getDose(intake.wastedAmount ?? Decimal.zero);
        await itemManager.useDose(item, -(intake.takenDose + wastedDose));
    }
  }

  InjectionSide getNextSide() {
    final lastIntake = _medicationIntakeProvider.getLastTakenInjectionIntake();

    if (lastIntake == null || lastIntake.side == null) {
      return InjectionSide.left;
    }

    return lastIntake.side == InjectionSide.left
        ? InjectionSide.right
        : InjectionSide.left;
  }
}
