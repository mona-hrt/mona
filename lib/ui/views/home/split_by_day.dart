import 'package:mona/data/model/scheduled_occurrence.dart';
import 'package:mona/data/model/scheduling_strategy.dart';

({
  List<ScheduledOccurrence> today,
  List<ScheduledOccurrence> upcoming,
}) splitByDay(List<ScheduledOccurrence> occurrences) {
  final overdueToday = <ScheduledOccurrence>[];
  final otherToday = <ScheduledOccurrence>[];
  final upcoming = <ScheduledOccurrence>[];

  for (final occurrence in occurrences) {
    if (occurrence.status == ScheduleStatus.upcoming) {
      upcoming.add(occurrence);
    } else if (occurrence.status == ScheduleStatus.overdue ||
        occurrence.status == ScheduleStatus.todayOverdue) {
      overdueToday.add(occurrence);
    } else {
      otherToday.add(occurrence);
    }
  }

  otherToday.sort(_byTimeNullsFirst);

  return (today: [...overdueToday, ...otherToday], upcoming: upcoming);
}

int _byTimeNullsFirst(ScheduledOccurrence a, ScheduledOccurrence b) {
  final at = a.time;
  final bt = b.time;
  if (at == null && bt == null) return 0;
  if (at == null) return -1;
  if (bt == null) return 1;
  final hourCompare = at.hour.compareTo(bt.hour);
  return hourCompare != 0 ? hourCompare : at.minute.compareTo(bt.minute);
}
