import 'package:collection/collection.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduled_occurrence.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';

class ScheduleOccurrences {
  final MedicationIntakeProvider _intakes;

  const ScheduleOccurrences(this._intakes);

  List<ScheduledOccurrence> currentFor(MedicationSchedule schedule) {
    switch (schedule.scheduling) {
      case IntervalDaysSchedule s:
        return _interval(schedule, s, [Date.today()]);
      case DailySchedule s:
        return _daily(schedule, s, 1);
    }
  }

  List<ScheduledOccurrence> upcomingFor(
    MedicationSchedule schedule, {
    required int days,
  }) {
    switch (schedule.scheduling) {
      case IntervalDaysSchedule s:
        return _interval(schedule, s, s.getNextDates(schedule.startDate, days));
      case DailySchedule s:
        return _daily(schedule, s, days);
    }
  }

  List<ScheduledOccurrence> _interval(
    MedicationSchedule schedule,
    IntervalDaysSchedule s,
    List<Date> dates,
  ) {
    final lastDate = _intakes.getLastIntakeLocalDateForSchedule(schedule.id);
    final lastIntake = _intakes.getLastTakenIntakeForSchedule(schedule.id);
    final notifiable = s.notificationTime != null;

    return [
      for (final date in dates)
        () {
          final status = s.statusFor(
              startDate: schedule.startDate, date: date, lastTaken: lastDate);
          return ScheduledOccurrence(
            date: date,
            time: s.notificationTime,
            status: status,
            intake: status == ScheduleStatus.taken ? lastIntake : null,
            notifiable: notifiable,
          );
        }(),
    ];
  }

  List<ScheduledOccurrence> _daily(
    MedicationSchedule schedule,
    DailySchedule s,
    int days,
  ) {
    final today = Date.today();
    final takenToday =
        _intakes.getTakenIntakesForScheduleOn(schedule.id, today);

    return [
      for (var i = 0; i < days; i++)
        for (final time in s.intakeTimes)
          () {
            final date = today.add(Duration(days: i));
            final match = date.isToday
                ? takenToday.firstWhereOrNull((it) => it.scheduledTime == time)
                : null;
            return ScheduledOccurrence(
              date: date,
              time: time,
              status: s.statusFor(date: date, matchedIntake: match),
              intake: match,
              notifiable: s.notify,
            );
          }(),
    ];
  }
}
