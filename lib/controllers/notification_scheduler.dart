import 'package:intl/intl.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';

class NotificationScheduler {
  static const int _numberOfDays = 5;

  final MedicationScheduleProvider medicationScheduleProvider;
  final MedicationIntakeProvider medicationIntakeProvider;
  final PreferencesService preferencesService;

  NotificationScheduler(
    this.medicationScheduleProvider,
    this.medicationIntakeProvider,
    this.preferencesService,
  );

  List<_ScheduledNotification> _getNotificationTimes() {
    final notificationsToSchedule = <_ScheduledNotification>[];
    final now = DateTime.now();

    for (final schedule in medicationScheduleProvider.schedules) {
      switch (schedule.scheduling) {
        case IntervalDaysSchedule scheduling:
          _collectIntervalTimes(
              schedule, scheduling, now, notificationsToSchedule);
        case DailySchedule scheduling:
          _collectDailyTimes(
              schedule, scheduling, now, notificationsToSchedule);
      }
    }

    return notificationsToSchedule;
  }

  void _collectIntervalTimes(
    MedicationSchedule schedule,
    IntervalDaysSchedule scheduling,
    DateTime now,
    List<_ScheduledNotification> out,
  ) {
    final time = scheduling.notificationTime;
    if (time == null) return;

    final lastTaken =
        medicationIntakeProvider.getLastIntakeLocalDateForSchedule(schedule.id);
    final nextDates =
        scheduling.getNextDates(schedule.startDate, _numberOfDays);

    for (final date in nextDates) {
      final dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      if (now.isAfter(dateTime)) continue;
      if (date.isToday && scheduling.isTakenTodayOrLater(lastTaken)) {
        continue;
      }

      out.add((dateTime: dateTime, schedule: schedule));
    }
  }

  void _collectDailyTimes(
    MedicationSchedule schedule,
    DailySchedule scheduling,
    DateTime now,
    List<_ScheduledNotification> out,
  ) {
    if (!scheduling.notify) return;

    final today = Date.today();
    final takenToday = medicationIntakeProvider.getTakenIntakesForScheduleOn(
        schedule.id, today);

    for (int i = 0; i < _numberOfDays; i++) {
      final date = today.add(Duration(days: i));
      final isToday = date.isToday;

      for (final time in scheduling.intakeTimes) {
        final dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        if (now.isAfter(dateTime)) continue;
        if (isToday &&
            takenToday.any((intake) => intake.scheduledTime == time)) {
          continue;
        }

        out.add((dateTime: dateTime, schedule: schedule));
      }
    }
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
