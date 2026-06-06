import 'package:intl/intl.dart';
import 'package:mona/controllers/notification_planner.dart';
import 'package:mona/data/model/planned_notification.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';

int _notificationIdFor(int scheduleId, DateTime dateTime) {
  return Object.hash(scheduleId, dateTime.millisecondsSinceEpoch) & 0x7fffffff;
}

class NotificationScheduler {
  static const int _maxScheduled = 60; // below iOS limit

  final NotificationPlanner planner;
  final PreferencesService preferencesService;

  NotificationScheduler(this.planner, this.preferencesService);

  Future<void> regenerateAll(AppLocalizations l10n, String localeName) async {
    await NotificationService().triggerPastPendingNotifications();
    await NotificationService().cancelPendingNotifications();

    if (!preferencesService.notificationsEnabled) {
      return;
    }

    final daysAhead = planner.daysAhead(maxScheduled: _maxScheduled);
    final plans = planner.planNotifications(daysAhead: daysAhead)
      ..sort((a, b) => a.firstFire.compareTo(b.firstFire));

    await Future.wait(plans
        .take(_maxScheduled)
        .map((plan) => _schedule(plan, l10n, localeName)));
  }

  Future<void> _schedule(
      PlannedNotification plan, AppLocalizations l10n, String localeName) {
    switch (plan) {
      case PlannedOccurrence():
        return _scheduleOccurrence(plan, l10n, localeName);
      case PlannedRepeating():
        switch (plan.periodicity) {
          case Periodicity.daily:
            return _scheduleDaily(plan, l10n, localeName);
          case Periodicity.weekly:
            return _scheduleWeekly(plan, l10n, localeName);
        }
    }
  }

  Future<void> _scheduleOccurrence(
    PlannedOccurrence plan,
    AppLocalizations l10n,
    String localeName,
  ) {
    final dateFormat = DateFormat.MMMMd(localeName);
    return NotificationService().scheduleNotification(
      id: _notificationIdFor(plan.schedule.id, plan.dateTime),
      title: l10n.notificationMedicationReminderTitle(plan.schedule.name),
      body: l10n.notificationMedicationReminderBodyDate(
        dateFormat.format(plan.dateTime),
      ),
      year: plan.dateTime.year,
      month: plan.dateTime.month,
      day: plan.dateTime.day,
      hour: plan.dateTime.hour,
      minute: plan.dateTime.minute,
    );
  }

  Future<void> _scheduleDaily(
    PlannedRepeating plan,
    AppLocalizations l10n,
    String localeName,
  ) {
    final timeFormat = DateFormat.Hm(localeName);
    return NotificationService().scheduleDailyNotification(
      id: _notificationIdFor(plan.schedule.id, plan.firstFire),
      title: l10n.notificationMedicationReminderTitle(plan.schedule.name),
      body: l10n.notificationMedicationReminderBodyTime(
        timeFormat.format(plan.firstFire),
      ),
      firstOccurrence: plan.firstFire,
    );
  }

  Future<void> _scheduleWeekly(
    PlannedRepeating plan,
    AppLocalizations l10n,
    String localeName,
  ) {
    final weekdayFormat = DateFormat.EEEE(localeName);
    return NotificationService().scheduleWeeklyNotification(
      id: _notificationIdFor(plan.schedule.id, plan.firstFire),
      title: l10n.notificationMedicationReminderTitle(plan.schedule.name),
      body: l10n.notificationMedicationReminderBodyWeekday(
        weekdayFormat.format(plan.firstFire),
      ),
      firstOccurrence: plan.firstFire,
    );
  }
}
