import 'package:clock/clock.dart';
import 'package:intl/intl.dart';
import 'package:mona/controllers/occurrences_manager.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';

int _notificationIdFor(int scheduleId, DateTime dateTime) {
  return Object.hash(scheduleId, dateTime.millisecondsSinceEpoch) & 0x7fffffff;
}

class NotificationScheduler {
  static const int _numberOfDays = 5;

  final OccurrencesManager occurencesManager;
  final PreferencesService preferencesService;

  NotificationScheduler(this.occurencesManager, this.preferencesService);

  List<_ScheduledNotification> _getScheduledNotifications() {
    final notifications = <_ScheduledNotification>[];
    final now = clock.now();

    for (final occ in occurencesManager.upcoming(days: _numberOfDays)) {
      if (!occ.notifiable) continue;
      if (occ.status == ScheduleStatus.taken) continue;
      final dt = occ.notificationDateTime;
      if (dt == null || now.isAfter(dt)) continue;
      final includeTime = occ.time != null;
      notifications.add(
          (dateTime: dt, schedule: occ.schedule, includeTime: includeTime));
    }

    return notifications;
  }

  Future<void> regenerateAll(AppLocalizations l10n, String localeName) async {
    await NotificationService().triggerPastPendingNotifications();
    await NotificationService().cancelPendingNotifications();

    if (!preferencesService.notificationsEnabled) {
      return;
    }

    final scheduledDateFormat = DateFormat.MMMMd(localeName);
    final scheduledDateTimeFormat = DateFormat.MMMMd(localeName)
        .addPattern(DateFormat.Hm(localeName).pattern);

    final scheduledNotifications = _getScheduledNotifications();

    await Future.wait(
      scheduledNotifications.map((entry) {
        final dateTime = entry.dateTime;
        final schedule = entry.schedule;
        final includeTime = entry.includeTime;

        return NotificationService().scheduleNotification(
          id: _notificationIdFor(schedule.id, dateTime),
          title: l10n.notificationMedicationReminderTitle(schedule.name),
          body: l10n.notificationMedicationReminderBody(
            includeTime
                ? scheduledDateTimeFormat.format(dateTime)
                : scheduledDateFormat.format(dateTime),
          ),
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          hour: dateTime.hour,
          minute: dateTime.minute,
        );
      }),
    );
  }
}

typedef _ScheduledNotification = ({
  DateTime dateTime,
  MedicationSchedule schedule,
  bool includeTime,
});
