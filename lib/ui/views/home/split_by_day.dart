import 'package:mona/data/model/intake_slot.dart';
import 'package:mona/data/model/scheduling_strategy.dart';

({
  List<IntakeSlot> today,
  List<IntakeSlot> asNeeded,
  List<IntakeSlot> upcoming,
}) splitByDay(
  List<IntakeSlot> occurrences, {
  List<int> scheduleOrder = const [],
}) {
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

  final indexById = {
    for (var i = 0; i < scheduleOrder.length; i++) scheduleOrder[i]: i
  };

  int byTimeNullsFirst(IntakeSlot a, IntakeSlot b) {
    final at = a.time;
    final bt = b.time;
    if (at == null && bt == null) return 0;
    if (at == null) return -1;
    if (bt == null) return 1;
    final hourCompare = at.hour.compareTo(bt.hour);
    return hourCompare != 0 ? hourCompare : at.minute.compareTo(bt.minute);
  }

  int byOrder(IntakeSlot a, IntakeSlot b) {
    final ai = indexById[a.schedule.id] ?? scheduleOrder.length;
    final bi = indexById[b.schedule.id] ?? scheduleOrder.length;
    final orderCompare = ai.compareTo(bi);
    return orderCompare != 0
        ? orderCompare
        : a.schedule.id.compareTo(b.schedule.id);
  }

  int byDateThenTimeThenOrder(IntakeSlot a, IntakeSlot b) {
    final dateCompare = a.date.value.compareTo(b.date.value);
    if (dateCompare != 0) return dateCompare;
    final timeCompare = byTimeNullsFirst(a, b);
    return timeCompare != 0 ? timeCompare : byOrder(a, b);
  }

  overdueToday.sort(byDateThenTimeThenOrder);
  otherToday.sort(byTimeNullsFirst);
  asNeeded.sort(byOrder);
  upcoming.sort(byDateThenTimeThenOrder);

  return (
    today: [...overdueToday, ...otherToday],
    asNeeded: asNeeded,
    upcoming: upcoming,
  );
}
