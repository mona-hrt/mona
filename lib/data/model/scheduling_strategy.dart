import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:mona/data/model/custom_mappers.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/util/validators.dart';

part 'scheduling_strategy.mapper.dart';

enum ScheduleStatus {
  overdue,
  todayOverdue,
  todayEarly,
  today,
  upcoming,
  taken
}

@immutable
class SlotInfo {
  final ScheduleStatus status;
  final TimeOfDay? time;
  final MedicationIntake? intake;

  const SlotInfo({
    required this.status,
    this.time,
    this.intake,
  });
}

@MappableClass(
  discriminatorKey: 'type',
  includeCustomMappers: [TimeOfDayMapper()],
)
sealed class SchedulingStrategy with SchedulingStrategyMappable {
  const SchedulingStrategy();

  List<SlotInfo> slotInfosFor({
    required Date startDate,
    Date? lastTakenLocalDate,
    MedicationIntake? lastTakenIntake,
    List<MedicationIntake> takenIntakesToday = const [],
  });
}

@MappableClass(
  discriminatorValue: 'intervalDays',
  includeCustomMappers: [TimeOfDayMapper()],
)
class IntervalDaysSchedule extends SchedulingStrategy
    with IntervalDaysScheduleMappable {
  final int intervalDays;
  final TimeOfDay? notificationTime;

  const IntervalDaysSchedule({
    required this.intervalDays,
    this.notificationTime,
  });

  /// Returns the next scheduled injection date relative to today.
  ///
  /// - If the [startDate] is in the future or today, returns [startDate].
  /// - If today falls exactly on a scheduled injection date, returns today.
  /// - Otherwise, returns the next scheduled date after today.
  Date nextDate(Date startDate) {
    if (!startDate.isBeforeToday) {
      return startDate;
    }

    final daysSinceStart = startDate.daysAwayFromToday;

    if (daysSinceStart % intervalDays == 0) {
      return Date.today();
    }

    return Date.today()
        .add(Duration(days: intervalDays - (daysSinceStart % intervalDays)));
  }

  /// Returns the last scheduled injection date relative to today.
  ///
  /// - If the [startDate] is in the future or today, returns null.
  /// - If today falls exactly on a scheduled injection date, returns the
  ///   scheduled date before today.
  /// - Otherwise, returns the last scheduled date before today.
  Date? previousDate(Date startDate) {
    if (!startDate.isBeforeToday) {
      return null;
    }

    final daysSinceStart = startDate.daysAwayFromToday;

    if (daysSinceStart % intervalDays == 0) {
      return Date.today().subtract(Duration(days: intervalDays));
    }

    return Date.today().subtract(Duration(days: daysSinceStart % intervalDays));
  }

  List<Date> getNextDates(Date startDate, int count) {
    if (count < 0) {
      throw ArgumentError('Count must be a positive integer');
    }

    if (count == 0) {
      return [];
    }

    final dates = <Date>[];
    Date next = nextDate(startDate);

    for (int i = 0; i < count; i++) {
      dates.add(next);
      next = next.add(Duration(days: intervalDays));
    }
    return dates;
  }

  bool _isScheduledForToday(Date startDate) {
    return nextDate(startDate).isToday;
  }

  bool _isLate(Date startDate, Date? lastTakenDate) {
    final prev = previousDate(startDate);
    if (prev == null) {
      return false;
    }

    return lastTakenDate == null || lastTakenDate.isBefore(prev);
  }

  bool _lastTakenLate(Date startDate, Date? lastTakenDate) {
    final prev = previousDate(startDate);
    if (lastTakenDate == null || prev == null) {
      return false;
    }
    return lastTakenDate.isAfter(prev);
  }

  bool isTakenTodayOrLater(Date? lastTakenDate) {
    if (lastTakenDate == null) return false;

    return lastTakenDate.isToday || lastTakenDate.isAfterToday;
  }

  ScheduleStatus _statusFor(Date date, Date? lastTaken) {
    if (_isScheduledForToday(date)) {
      if (isTakenTodayOrLater(lastTaken)) return ScheduleStatus.taken;
      if (_isLate(date, lastTaken)) return ScheduleStatus.todayOverdue;
      if (_lastTakenLate(date, lastTaken)) {
        return ScheduleStatus.todayEarly;
      }
      return ScheduleStatus.today;
    }

    if (_isLate(date, lastTaken)) return ScheduleStatus.overdue;

    return ScheduleStatus.upcoming;
  }

  @override
  List<SlotInfo> slotInfosFor({
    required Date startDate,
    Date? lastTakenLocalDate,
    MedicationIntake? lastTakenIntake,
    List<MedicationIntake> takenIntakesToday = const [],
  }) {
    final status = _statusFor(startDate, lastTakenLocalDate);
    final intake = status == ScheduleStatus.taken ? lastTakenIntake : null;
    return [SlotInfo(status: status, intake: intake)];
  }

  static String? validateIntervalDays(AppLocalizations l10n, String? value) =>
      requiredPositiveInt(l10n, value);
}

@MappableClass(
  discriminatorValue: 'daily',
  includeCustomMappers: [TimeOfDayMapper()],
)
class DailySchedule extends SchedulingStrategy with DailyScheduleMappable {
  final List<TimeOfDay> intakeTimes;
  final bool notify;

  const DailySchedule({
    required this.intakeTimes,
    this.notify = true,
  });

  @override
  List<SlotInfo> slotInfosFor({
    required Date startDate,
    Date? lastTakenLocalDate,
    MedicationIntake? lastTakenIntake,
    List<MedicationIntake> takenIntakesToday = const [],
  }) {
    return [
      for (final time in intakeTimes) _slotInfoForTime(time, takenIntakesToday),
    ];
  }

  SlotInfo _slotInfoForTime(
      TimeOfDay time, List<MedicationIntake> takenIntakesToday) {
    final match =
        takenIntakesToday.firstWhereOrNull((i) => i.scheduledTime == time);
    return SlotInfo(
      status: match != null ? ScheduleStatus.taken : ScheduleStatus.today,
      time: time,
      intake: match,
    );
  }

  static String? validateIntakeTimes(
          AppLocalizations l10n, List<TimeOfDay> value) =>
      requiredListOfTimes(l10n, value);
}
