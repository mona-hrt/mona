import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/planned_notification.dart';
import 'package:mona/data/model/scheduled_occurrence.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

class OccurrencesManager {
  final MedicationIntakeProvider _medicationIntakeProvider;
  final MedicationScheduleProvider _medicationScheduleProvider;

  const OccurrencesManager(
      this._medicationIntakeProvider, this._medicationScheduleProvider);

  Occurrences current() {
    final schedules = _medicationScheduleProvider.schedules;
    final occurrences = <ScheduledOccurrence>[];

    for (final schedule in schedules) {
      switch (schedule.scheduling) {
        case IntervalDaysSchedule scheduling:
          occurrences
              .addAll(_interval(schedule, scheduling, [Date.today()], true));
        case DailySchedule scheduling:
          occurrences.addAll(_daily(schedule, scheduling, 1));
        case WeeklySchedule scheduling:
          occurrences.addAll(_weekly(schedule, scheduling, 1, true));
      }
    }

    return Occurrences(occurrences);
  }

  Occurrences upcoming({required int days}) {
    final schedules = _medicationScheduleProvider.schedules;
    final occurrences = <ScheduledOccurrence>[];

    for (final schedule in schedules) {
      switch (schedule.scheduling) {
        case IntervalDaysSchedule s:
          occurrences.addAll(_interval(
              schedule, s, s.getNextDates(schedule.startDate, days), false));
        case DailySchedule s:
          occurrences.addAll(_daily(schedule, s, days));
        case WeeklySchedule s:
          occurrences.addAll(_weekly(schedule, s, days, false));
      }
    }

    return Occurrences(occurrences);
  }

  List<PlannedNotification> planNotifications({required int days}) {
    final plans = <PlannedNotification>[];

    for (final schedule in _medicationScheduleProvider.schedules) {
      switch (schedule.scheduling) {
        case IntervalDaysSchedule s:
          plans.addAll(_intervalPlans(schedule, s, days));
        case DailySchedule s:
          plans.addAll(_dailyPlans(schedule, s));
        case WeeklySchedule s:
          plans.addAll(_weeklyPlans(schedule, s));
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

  List<ScheduledOccurrence> _interval(
    MedicationSchedule schedule,
    IntervalDaysSchedule scheduling,
    List<Date> dates,
    bool current,
  ) {
    final lastTaken = _medicationIntakeProvider
        .getLastIntakeLocalDateForSchedule(schedule.id);
    final lastIntake =
        _medicationIntakeProvider.getLastTakenIntakeForSchedule(schedule.id);
    final notifiable = scheduling.notificationTimes.isNotEmpty;

    if (current) {
      final status = scheduling.statusFor(
          startDate: schedule.startDate,
          date: Date.today(),
          lastTaken: lastTaken);
      return [
        ScheduledOccurrence(
          schedule: schedule,
          date: Date.today(),
          notificationTime: null,
          status: status,
          intake: status == ScheduleStatus.taken ? lastIntake : null,
          notifiable: notifiable,
        ),
      ];
    }

    return [
      for (final date in dates)
        for (final time in scheduling.notificationTimes)
          () {
            final status = scheduling.statusFor(
                startDate: schedule.startDate,
                date: date,
                lastTaken: lastTaken);
            return ScheduledOccurrence(
              schedule: schedule,
              date: date,
              notificationTime: time,
              status: status,
              intake: status == ScheduleStatus.taken ? lastIntake : null,
              notifiable: notifiable,
            );
          }(),
    ];
  }

  List<ScheduledOccurrence> _daily(
    MedicationSchedule schedule,
    DailySchedule scheduling,
    int days,
  ) {
    final today = Date.today();
    final takenToday = _medicationIntakeProvider.getTakenIntakesForScheduleOn(
        schedule.id, today);

    return [
      for (var i = 0; i < days; i++)
        for (final time in scheduling.intakeTimes)
          () {
            final date = today.add(Duration(days: i));
            final match = date.isToday
                ? takenToday.firstWhereOrNull((it) => it.scheduledTime == time)
                : null;
            return ScheduledOccurrence(
              schedule: schedule,
              date: date,
              time: time,
              notificationTime: time,
              status: scheduling.statusFor(date: date, matchedIntake: match),
              intake: match,
              notifiable: scheduling.notify,
            );
          }(),
    ];
  }

  List<ScheduledOccurrence> _weekly(
    MedicationSchedule schedule,
    WeeklySchedule scheduling,
    int days,
    bool current,
  ) {
    final lastTaken = _medicationIntakeProvider
        .getLastIntakeLocalDateForSchedule(schedule.id);
    final lastIntake =
        _medicationIntakeProvider.getLastTakenIntakeForSchedule(schedule.id);
    final notifiable = scheduling.notificationTimes.isNotEmpty;

    if (current) {
      final status = scheduling.statusFor(
          startDate: schedule.startDate,
          date: Date.today(),
          lastTaken: lastTaken);
      return [
        ScheduledOccurrence(
          schedule: schedule,
          date: Date.today(),
          notificationTime: null,
          status: status,
          intake: status == ScheduleStatus.taken ? lastIntake : null,
          notifiable: notifiable,
        ),
      ];
    }

    return [
      for (var i = 0; i < days; i++)
        () {
          final date = Date.today().add(Duration(days: i));
          if (!scheduling.daysOfWeek.contains(date.weekday) ||
              date.isBefore(schedule.startDate)) {
            return <ScheduledOccurrence>[];
          }

          final status = scheduling.statusFor(
              startDate: schedule.startDate, date: date, lastTaken: lastTaken);

          return [
            for (final time in scheduling.notificationTimes)
              ScheduledOccurrence(
                schedule: schedule,
                date: date,
                notificationTime: time,
                status: status,
                intake: status == ScheduleStatus.taken ? lastIntake : null,
                notifiable: notifiable,
              ),
          ];
        }(),
    ].flattened.toList();
  }
}
