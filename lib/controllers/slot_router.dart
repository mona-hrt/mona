import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mona/data/model/intake_slot.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/services/notification_service.dart';

(MedicationSchedule, TimeOfDay?)? findSlotFromPayload(
  NotificationPayload payload,
  List<IntakeSlot> slots,
) {
  final targetSlots =
      slots.where((slot) => slot.schedule.id == payload.scheduleId).toList();
  if (targetSlots.isEmpty) return null;

  final slot = targetSlots.length == 1
      ? targetSlots.single
      : targetSlots.firstWhereOrNull(
          (slot) => slot.time == TimeOfDay.fromDateTime(payload.scheduledTime));
  if (slot == null) return null;
  if (slot.intake != null) return null;

  return (slot.schedule, slot.time);
}
