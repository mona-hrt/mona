// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:intl/intl.dart';
import 'package:mona/controllers/notification_planner.dart';
import 'package:mona/data/model/planned_notification.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/i18n/translations.g.dart';
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

  Future<void> regenerateAll(String localeName) async {
    await NotificationService().triggerPastPendingNotifications();
    await NotificationService().cancelPendingNotifications();

    if (!preferencesService.notificationsEnabled) {
      return;
    }

    final plans = planner.planNotifications(maxScheduled: _maxScheduled);
    await Future.wait(plans.map((plan) => _schedule(plan, localeName)));
  }

  Future<void> _schedule(PlannedNotification plan, String localeName) {
    return NotificationService().scheduleNotification(
      id: _notificationIdFor(plan.schedule.id, plan.dateTime),
      scheduleId: plan.schedule.id,
      title: t.notificationMedicationReminderTitle(
          scheduleName: plan.schedule.name),
      body: _body(plan, localeName),
      scheduledTime: plan.dateTime,
    );
  }

  String _body(PlannedNotification plan, String localeName) =>
      switch (plan.schedule.scheduling) {
        DailySchedule() => t.notificationMedicationReminderBodyTime(
            time: DateFormat.Hm(localeName).format(plan.dateTime),
          ),
        WeeklySchedule() => t.notificationMedicationReminderBodyWeekday(
            weekday: DateFormat.EEEE(localeName).format(plan.dateTime),
          ),
        IntervalDaysSchedule() ||
        DynamicIntervalSchedule() ||
        MonthlySchedule() ||
        AsNeededSchedule() =>
          t.notificationMedicationReminderBodyDate(
            date: DateFormat.MMMMd(localeName).format(plan.dateTime),
          ),
      };
}
