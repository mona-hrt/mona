import 'package:mona/data/model/intake_slot.dart';
import 'package:mona/data/model/scheduling_strategy.dart';

({
  List<IntakeSlot> today,
  List<IntakeSlot> asNeeded,
  List<IntakeSlot> upcoming,
}) splitByDay(List<IntakeSlot> occurrences) {
  final overdueToday = <IntakeSlot>[];
  final otherToday = <IntakeSlot>[];
  final asNeeded = <IntakeSlot>[];
  final upcoming = <IntakeSlot>[];

  for (final occurrence in occurrences) {
    if (occurrence.status == ScheduleStatus.upcoming) {
      upcoming.add(occurrence);
    } else if (occurrence.status == ScheduleStatus.overdue ||
        occurrence.status == ScheduleStatus.todayOverdue) {
      overdueToday.add(occurrence);
    } else if (occurrence.status == ScheduleStatus.asNeeded) {
      asNeeded.add(occurrence);
    } else {
      otherToday.add(occurrence);
    }
  }

  overdueToday.sort(_byDateThenTimeThenName);
  otherToday.sort(_byTimeNullsFirst);
  asNeeded.sort(_byName);
  upcoming.sort(_byDateThenTimeThenName);

  return (
    today: [...overdueToday, ...otherToday],
    asNeeded: asNeeded,
    upcoming: upcoming,
  );
}

int _byDateThenTimeThenName(IntakeSlot a, IntakeSlot b) {
  final dateCompare = a.date.value.compareTo(b.date.value);
  if (dateCompare != 0) return dateCompare;
  final timeCompare = _byTimeNullsFirst(a, b);
  return timeCompare != 0 ? timeCompare : _byName(a, b);
}

int _byName(IntakeSlot a, IntakeSlot b) {
  final nameCompare =
      a.schedule.name.toLowerCase().compareTo(b.schedule.name.toLowerCase());
  return nameCompare != 0
      ? nameCompare
      : a.schedule.id.compareTo(b.schedule.id); // fallback
}

int _byTimeNullsFirst(IntakeSlot a, IntakeSlot b) {
  final at = a.time;
  final bt = b.time;
  if (at == null && bt == null) return 0;
  if (at == null) return -1;
  if (bt == null) return 1;
  final hourCompare = at.hour.compareTo(bt.hour);
  return hourCompare != 0 ? hourCompare : at.minute.compareTo(bt.minute);
}
