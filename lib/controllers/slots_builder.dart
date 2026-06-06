import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/planned_notification.dart';
import 'package:mona/data/model/scheduled_occurrence.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

class SlotsBuilder {
  final MedicationIntakeProvider _medicationIntakeProvider;
  final MedicationScheduleProvider _medicationScheduleProvider;

  const SlotsBuilder(
      this._medicationIntakeProvider, this._medicationScheduleProvider);

  List<IntakeSlot> intakeSlots() {
    final slots = <IntakeSlot>[];

    for (final schedule in _medicationScheduleProvider.schedules) {
      switch (schedule.scheduling) {
        case IntervalDaysSchedule scheduling:
          slots.add(_interval(schedule, scheduling));
        case DailySchedule scheduling:
          slots.addAll(_daily(schedule, scheduling));
        case WeeklySchedule scheduling:
          slots.add(_weekly(schedule, scheduling));
      }
    }

    return slots;
  }

  List<PlannedNotification> planNotifications({required int days}) {
    final plans = <PlannedNotification>[];

    for (final schedule in _medicationScheduleProvider.schedules) {
      switch (schedule.scheduling) {
        case IntervalDaysSchedule scheduling:
          plans.addAll(_intervalPlans(schedule, scheduling, days));
        case DailySchedule scheduling:
          plans.addAll(_dailyPlans(schedule, scheduling));
        case WeeklySchedule scheduling:
          plans.addAll(_weeklyPlans(schedule, scheduling));
      }
    }

    return plans;
  }

  List<PlannedNotification> _intervalPlans(
    MedicationSchedule schedule,
    IntervalDaysSchedule s,
    int days,
  ) {
    if (s.notificationTimes.isEmpty) return const [];

    final now = clock.now();
    final lastTaken = _medicationIntakeProvider
        .getLastIntakeLocalDateForSchedule(schedule.id);
    final dates = s.getNextDates(schedule.startDate, days);

    final plans = <PlannedNotification>[];
    for (final date in dates) {
      final status = s.statusFor(
        startDate: schedule.startDate,
        date: date,
        lastTaken: lastTaken,
      );
      if (status == ScheduleStatus.taken) continue;

      for (final time in s.notificationTimes) {
        final dateTime = date.toDateTimeAt(time);
        if (!dateTime.isAfter(now)) continue;
        plans.add(PlannedOccurrence(schedule, dateTime: dateTime));
      }
    }
    return plans;
  }

  List<PlannedNotification> _dailyPlans(
    MedicationSchedule schedule,
    DailySchedule s,
  ) {
    if (!s.notify || s.intakeTimes.isEmpty) return const [];

    final today = Date.today();
    final now = clock.now();
    final start = schedule.startDate.isAfterToday ? schedule.startDate : today;
    final takenDateTimesToday = _medicationIntakeProvider
        .getTakenIntakesForScheduleOn(schedule.id, today)
        .map((intake) => Date.today().toDateTimeAt(intake.scheduledTime!))
        .toSet();

    return [
      for (final time in s.intakeTimes)
        () {
          DateTime candidate = start.toDateTimeAt(time);
          if (!candidate.isAfter(now) ||
              takenDateTimesToday.contains(candidate)) {
            candidate = candidate.add(const Duration(days: 1));
          }
          return PlannedRepeating(
            schedule,
            periodicity: Periodicity.daily,
            firstFire: candidate,
            time: time,
          );
        }(),
    ];
  }

  List<PlannedNotification> _weeklyPlans(
    MedicationSchedule schedule,
    WeeklySchedule s,
  ) {
    if (s.notificationTimes.isEmpty) return const [];

    final today = Date.today();
    final now = clock.now();
    final takenToday = _medicationIntakeProvider
        .getTakenIntakesForScheduleOn(schedule.id, today)
        .isNotEmpty;

    return [
      for (final dayOfWeek in s.daysOfWeek)
        for (final time in s.notificationTimes)
          () {
            final nextDate = s.nextDateOn(dayOfWeek, schedule.startDate);
            DateTime candidate = nextDate.toDateTimeAt(time);
            if (nextDate.isToday && (!candidate.isAfter(now) || takenToday)) {
              candidate = candidate.add(const Duration(days: 7));
            }
            return PlannedRepeating(
              schedule,
              periodicity: Periodicity.weekly,
              firstFire: candidate,
              time: time,
              dayOfWeek: dayOfWeek,
            );
          }(),
    ];
  }

  IntakeSlot _interval(
    MedicationSchedule schedule,
    IntervalDaysSchedule scheduling,
  ) {
    final lastTaken = _medicationIntakeProvider
        .getLastIntakeLocalDateForSchedule(schedule.id);
    final lastIntake =
        _medicationIntakeProvider.getLastTakenIntakeForSchedule(schedule.id);

    final status = scheduling.statusFor(
      startDate: schedule.startDate,
      date: Date.today(),
      lastTaken: lastTaken,
    );
    return IntakeSlot(
      schedule: schedule,
      date: Date.today(),
      status: status,
      intake: status == ScheduleStatus.taken ? lastIntake : null,
    );
  }

  List<IntakeSlot> _daily(
    MedicationSchedule schedule,
    DailySchedule scheduling,
  ) {
    final today = Date.today();
    final takenToday = _medicationIntakeProvider.getTakenIntakesForScheduleOn(
        schedule.id, today);

    return [
      for (final time in scheduling.intakeTimes)
        () {
          final match =
              takenToday.firstWhereOrNull((it) => it.scheduledTime == time);
          return IntakeSlot(
            schedule: schedule,
            date: today,
            time: time,
            status: scheduling.statusFor(date: today, matchedIntake: match),
            intake: match,
          );
        }(),
    ];
  }

  IntakeSlot _weekly(
    MedicationSchedule schedule,
    WeeklySchedule scheduling,
  ) {
    final lastTaken = _medicationIntakeProvider
        .getLastIntakeLocalDateForSchedule(schedule.id);
    final lastIntake =
        _medicationIntakeProvider.getLastTakenIntakeForSchedule(schedule.id);

    final status = scheduling.statusFor(
      startDate: schedule.startDate,
      date: Date.today(),
      lastTaken: lastTaken,
    );
    return IntakeSlot(
      schedule: schedule,
      date: Date.today(),
      status: status,
      intake: status == ScheduleStatus.taken ? lastIntake : null,
    );
  }
}
