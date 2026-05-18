import 'package:intl/intl.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';

class NotificationScheduler {
  final MedicationScheduleProvider medicationScheduleProvider;
  final MedicationIntakeProvider medicationIntakeProvider;
  final PreferencesService preferencesService;

  NotificationScheduler(
    this.medicationScheduleProvider,
    this.medicationIntakeProvider,
    this.preferencesService,
  );

  Future<void> regenerateAll(AppLocalizations l10n, String localeName) async {
    NotificationService().triggerPastPendingNotifications();
    NotificationService().cancelPendingNotifications();

    if (!preferencesService.notificationsEnabled) {
      return;
    }

    final timeFormat = DateFormat.Hm(localeName);
    final weekdayFormatter = DateFormat.EEEE(localeName);

    final List<Future<void>> schedulingFutures = [];

    for (final schedule in medicationScheduleProvider.schedules) {
      final lastTaken = medicationIntakeProvider
          .getLastIntakeLocalDateForSchedule(schedule.id);

      for (final dayOfWeek in schedule.daysOfWeek) {
        // Use Jan 1, 2024 (a Monday) as a reference to get the weekday name
        final referenceDate = DateTime(2024, 1, 1 + (dayOfWeek - 1));
        final weekdayName = weekdayFormatter.format(referenceDate);

        for (final time in schedule.notificationTimes) {
          final timeStr =
              timeFormat.format(DateTime(2024, 1, 1, time.hour, time.minute));

          // Calculate startDate for this repeating notification
          DateTime start = schedule.startDate.toDateTime();

          // If today matches this dayOfWeek and it's already taken, start from tomorrow to skip today
          if (Date.today().weekday == dayOfWeek &&
              schedule.isTakenTodayOrLater(lastTaken)) {
            start = DateTime.now().add(const Duration(days: 1));
          }

          schedulingFutures.add(
            NotificationService().scheduleWeeklyNotification(
              title: l10n.notificationMedicationReminderTitle(schedule.name),
              body: l10n.notificationMedicationReminderBody(
                "$weekdayName $timeStr",
              ),
              dayOfWeek: dayOfWeek,
              hour: time.hour,
              minute: time.minute,
              startDate: start,
            ),
          );
        }
      }
    }

    await Future.wait(schedulingFutures);
  }
}
