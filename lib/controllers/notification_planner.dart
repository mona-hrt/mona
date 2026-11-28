// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:clock/clock.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/planned_notification.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

class NotificationPlanner {
  final MedicationIntakeProvider _medicationIntakeProvider;
  final MedicationScheduleProvider _medicationScheduleProvider;

  const NotificationPlanner(
      this._medicationIntakeProvider, this._medicationScheduleProvider);

  List<PlannedNotification> planNotifications({required int maxScheduled}) {
    final plansPerSchedule = [
      for (final schedule in _medicationScheduleProvider.schedules)
        if (schedule.scheduling.isNotifiable)
          _plansForSchedule(
              schedule, maxScheduled + 1), // + 1 in case today is dropped
    ];

    final plans = <PlannedNotification>[];
    for (int round = 0; plans.length < maxScheduled; round++) {
      final roundPlans = [
        for (final schedulePlans in plansPerSchedule)
          if (round < schedulePlans.length) schedulePlans[round],
      ];
      if (roundPlans.isEmpty) break;

      plans.addAll(roundPlans.take(maxScheduled - plans.length));
    }

    return plans;
  }

  List<PlannedNotification> _plansForSchedule(
          MedicationSchedule schedule, int daysAhead) =>
      switch (schedule.scheduling) {
        IntervalDaysSchedule scheduling =>
          _intervalPlans(schedule, scheduling, daysAhead),
        DynamicIntervalSchedule scheduling =>
          _dynamicIntervalPlans(schedule, scheduling),
        DailySchedule scheduling =>
          _dailyPlans(schedule, scheduling, daysAhead),
        WeeklySchedule scheduling =>
          _weeklyPlans(schedule, scheduling, daysAhead),
        MonthlySchedule scheduling =>
          _monthlyPlans(schedule, scheduling, daysAhead),
        AsNeededSchedule _ => [],
      };

  List<PlannedNotification> _intervalPlans(
    MedicationSchedule schedule,
    IntervalDaysSchedule scheduling,
    int days,
  ) {
    final now = clock.now();
    final lastTaken = _medicationIntakeProvider
        .getLastIntakeLocalDateForSchedule(schedule.id);
    final takenToday = lastTaken != null && !lastTaken.isBefore(Date.today());
    final dates = scheduling.getNextDates(schedule.startDate, days);

    final plans = <PlannedNotification>[];
    for (final date in dates) {
      if (date.isToday && takenToday) continue;

      for (final time in scheduling.notificationTimes) {
        final dateTime = date.toDateTimeAt(time);
        if (!dateTime.isAfter(now)) continue;
        plans.add(PlannedNotification(schedule, dateTime: dateTime));
      }
    }

    return plans;
  }

  List<PlannedNotification> _dynamicIntervalPlans(
    MedicationSchedule schedule,
    DynamicIntervalSchedule scheduling,
  ) {
    final now = clock.now();
    final lastTaken = _medicationIntakeProvider
        .getLastIntakeLocalDateForSchedule(schedule.id);
    final date = scheduling.intakeDate(schedule.startDate, lastTaken);

    final plans = <PlannedNotification>[];
    for (final time in scheduling.notificationTimes) {
      final dateTime = date.toDateTimeAt(time);
      if (!dateTime.isAfter(now)) continue;
      plans.add(PlannedNotification(schedule, dateTime: dateTime));
    }

    return plans;
  }

  List<PlannedNotification> _monthlyPlans(
    MedicationSchedule schedule,
    MonthlySchedule scheduling,
    int count,
  ) {
    final now = clock.now();
    final lastTaken = _medicationIntakeProvider
        .getLastIntakeLocalDateForSchedule(schedule.id);
    final takenToday = lastTaken != null && !lastTaken.isBefore(Date.today());
    final dates = scheduling.getNextDates(schedule.startDate, count);

    final plans = <PlannedNotification>[];
    for (final date in dates) {
      if (date.isToday && takenToday) continue;

      for (final time in scheduling.notificationTimes) {
        final dateTime = date.toDateTimeAt(time);
        if (!dateTime.isAfter(now)) continue;
        plans.add(PlannedNotification(schedule, dateTime: dateTime));
      }
    }

    return plans;
  }

  List<PlannedNotification> _dailyPlans(
    MedicationSchedule schedule,
    DailySchedule scheduling,
    int days,
  ) {
    final today = Date.today();
    final now = clock.now();
    final takenDateTimesToday = _medicationIntakeProvider
        .getTakenIntakesForScheduleOn(schedule.id, today)
        .where((intake) => intake.scheduledTime != null)
        .map((intake) => Date.today().toDateTimeAt(intake.scheduledTime!))
        .toSet();
    final dates = scheduling.getNextDates(schedule.startDate, days);

    final plans = <PlannedNotification>[];
    for (final date in dates) {
      for (final time in scheduling.intakeTimes) {
        final dateTime = date.toDateTimeAt(time);
        if (!dateTime.isAfter(now)) continue;
        if (takenDateTimesToday.contains(dateTime)) continue;
        plans.add(PlannedNotification(schedule, dateTime: dateTime));
      }
    }

    return plans;
  }

  List<PlannedNotification> _weeklyPlans(
    MedicationSchedule schedule,
    WeeklySchedule scheduling,
    int days,
  ) {
    final today = Date.today();
    final now = clock.now();
    final takenToday = _medicationIntakeProvider
        .getTakenIntakesForScheduleOn(schedule.id, today)
        .isNotEmpty;
    final dates = scheduling.getNextDates(schedule.startDate, days);

    final plans = <PlannedNotification>[];
    for (final date in dates) {
      if (date.isToday && takenToday) continue;

      for (final time in scheduling.notificationTimes) {
        final dateTime = date.toDateTimeAt(time);
        if (!dateTime.isAfter(now)) continue;
        plans.add(PlannedNotification(schedule, dateTime: dateTime));
      }
    }

    return plans;
  }
}
