import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mona/data/model/intake_slot.dart';

IntakeSlot? findSlot(
  int scheduleId,
  DateTime scheduledTime,
  List<IntakeSlot> slots,
) {
  final targetSlots =
      slots.where((slot) => slot.schedule.id == scheduleId).toList();
  if (targetSlots.isEmpty) return null;

  final slot = targetSlots.length == 1
      ? targetSlots.single
      : targetSlots.firstWhereOrNull(
          (slot) => slot.time == TimeOfDay.fromDateTime(scheduledTime));
  if (slot == null) return null;
  if (slot.intake != null) return null;

  return slot;
}
