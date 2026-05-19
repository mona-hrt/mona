import 'package:intl/intl.dart';
import 'package:mona/controllers/schedule_occurrences.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';

class NotificationScheduler {
  static const int _numberOfDays = 5;

  final MedicationScheduleProvider medicationScheduleProvider;
  final ScheduleOccurrences scheduleOccurrences;
  final PreferencesService preferencesService;

  NotificationScheduler(
    this.medicationScheduleProvider,
    this.scheduleOccurrences,
    this.preferencesService,
  );

  List<_ScheduledNotification> _getNotificationTimes() {
    final out = <_ScheduledNotification>[];
    final now = DateTime.now();

    for (final schedule in medicationScheduleProvider.schedules) {
      for (final occ in scheduleOccurrences.upcomingFor(
        schedule,
        days: _numberOfDays,
      )) {
        if (!occ.notifiable) continue;
        if (occ.status == ScheduleStatus.taken) continue;
        final dt = occ.localDateTime;
        if (dt == null || now.isAfter(dt)) continue;
        out.add((dateTime: dt, schedule: schedule));
      }
    }

    return out;
  }

  Future<void> regenerateAll(AppLocalizations l10n, String localeName) async {
    await NotificationService().triggerPastPendingNotifications();
    await NotificationService().cancelPendingNotifications();

    if (!preferencesService.notificationsEnabled) {
      return;
    }

    final scheduledDateTimeFormat = DateFormat.MMMMd(localeName);

    final notificationTimes = _getNotificationTimes();

    await Future.wait(
      notificationTimes.map((entry) {
        final dateTime = entry.dateTime;
        final schedule = entry.schedule;

        return NotificationService().scheduleNotification(
          title: l10n.notificationMedicationReminderTitle(schedule.name),
          body: l10n.notificationMedicationReminderBody(
            scheduledDateTimeFormat.format(dateTime),
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
});
