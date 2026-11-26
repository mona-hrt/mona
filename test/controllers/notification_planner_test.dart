// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only AND LicenseRef-Proxy AND LicenseRef-Digital-storefront-exception-1.2

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mona/controllers/notification_planner.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/model/planned_notification.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';

import '../fixtures.dart';
import '../util/test_clock.dart';

@GenerateNiceMocks([
  MockSpec<MedicationIntakeProvider>(),
  MockSpec<MedicationScheduleProvider>(),
])
import 'notification_planner_test.mocks.dart';

void main() {
  late MockMedicationIntakeProvider intakesProvider;
  late MockMedicationScheduleProvider schedulesProvider;
  late NotificationPlanner planner;

  setUp(() {
    intakesProvider = MockMedicationIntakeProvider();
    schedulesProvider = MockMedicationScheduleProvider();
    when(schedulesProvider.schedules).thenReturn([]);
    planner = NotificationPlanner(intakesProvider, schedulesProvider);
  });

  void withSchedules(List<MedicationSchedule> all) {
    when(schedulesProvider.schedules).thenReturn(all);
  }

  group('planNotifications - IntervalDaysSchedule', () {
    test('empty notificationTimes -> no plans', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: anIntervalStrategy(notificationTimes: const []))
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 30);

        // Assert
        expect(plans, isEmpty);
      });
    });

    test('emits one PlannedOccurrence per (scheduled date, notificationTime)',
        () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: anIntervalStrategy(
                notificationTimes: const [morning, afternoon]),
            startDate: Date.today().subtract(const Duration(days: 7)),
          )
        ]);
        when(intakesProvider.getLastIntakeLocalDateForSchedule(any))
            .thenReturn(null);
        final today = Date.today();
        final nextWeek = today.add(const Duration(days: 7));
        final inTwoWeeks = today.add(const Duration(days: 14));

        // Act
        final plans = planner.planNotifications(maxScheduled: 5);

        // Assert
        expect(plans.map((plan) => plan.firstFire), [
          today.toDateTimeAt(afternoon), // today morning is past
          nextWeek.toDateTimeAt(morning),
          nextWeek.toDateTimeAt(afternoon),
          inTwoWeeks.toDateTimeAt(morning),
          inTwoWeeks.toDateTimeAt(afternoon),
        ]);
      });
    });

    test('skips notifications in the past', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: anIntervalStrategy(
                  notificationTimes: const [morning, afternoon]))
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, Date.today().toDateTimeAt(afternoon));
      });
    });

    test('skips today when status is taken', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling:
                anIntervalStrategy(notificationTimes: const [afternoon]),
            startDate: Date.today().subtract(const Duration(days: 7)),
          )
        ]);
        when(intakesProvider.getLastIntakeLocalDateForSchedule(any))
            .thenReturn(Date.today());

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire,
            Date.today().add(const Duration(days: 7)).toDateTimeAt(afternoon));
      });
    });
  });

  group('planNotifications - DynamicIntervalSchedule', () {
    test('no notification times -> no plans', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: aDynamicIntervalStrategy(notificationTimes: const []))
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 30);

        // Assert
        expect(plans, isEmpty);
      });
    });

    test('schedules only the next dose anchored to the last intake', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDynamicIntervalStrategy(
              intervalDays: 5,
              notificationTimes: const [afternoon],
            ),
          )
        ]);
        when(intakesProvider.getLastIntakeLocalDateForSchedule(any))
            .thenReturn(Date.today());

        // Act
        final plans = planner
            .planNotifications(maxScheduled: 30)
            .cast<PlannedOccurrence>();

        // Assert
        expect(plans.single.dateTime,
            Date.today().add(const Duration(days: 5)).toDateTimeAt(afternoon));
      });
    });

    test('overdue anchor schedules nothing', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDynamicIntervalStrategy(
              intervalDays: 5,
              notificationTimes: const [afternoon],
            ),
          )
        ]);
        when(intakesProvider.getLastIntakeLocalDateForSchedule(any))
            .thenReturn(Date.today().subtract(const Duration(days: 20)));

        // Act
        final plans = planner.planNotifications(maxScheduled: 30);

        // Assert
        expect(plans, isEmpty);
      });
    });

    test('null lastTaken anchors on the startDate', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDynamicIntervalStrategy(
              intervalDays: 5,
              notificationTimes: const [afternoon],
            ),
            startDate: Date.today(),
          )
        ]);
        when(intakesProvider.getLastIntakeLocalDateForSchedule(any))
            .thenReturn(null);

        // Act
        final plans = planner
            .planNotifications(maxScheduled: 30)
            .cast<PlannedOccurrence>();

        // Assert
        expect(plans.single.dateTime, Date.today().toDateTimeAt(afternoon));
      });
    });
  });

  group('planNotifications - MonthlySchedule', () {
    test('empty notificationTimes -> no plans', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: aMonthlyStrategy(notificationTimes: const []))
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 3);

        // Assert
        expect(plans, isEmpty);
      });
    });

    test('emits one PlannedOccurrence per (scheduled date, notificationTime)',
        () {
      withFixedClock(() {
        // testNow = 2026-06-01. First future occurrence 2026-06-21.
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aMonthlyStrategy(
                dayOfMonth: 21,
                intervalMonths: 1,
                notificationTimes: const [morning, afternoon]),
            startDate: Date(year: 2026, month: 3, day: 21),
          )
        ]);
        when(intakesProvider.getLastIntakeLocalDateForSchedule(any))
            .thenReturn(null);

        // Act
        final plans = planner.planNotifications(maxScheduled: 4);

        // Assert
        expect(plans.map((plan) => plan.firstFire), [
          DateTime(2026, 6, 21, 9),
          DateTime(2026, 6, 21, 15),
          DateTime(2026, 7, 21, 9),
          DateTime(2026, 7, 21, 15),
        ]);
      });
    });

    test('skips notifications in the past', () {
      withFixedClock(() {
        // testNow = 2026-06-01 noon; dayOfMonth 1 -> today is the next
        // occurrence, so today's morning (09:00) is past and afternoon (15:00)
        // is future.
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aMonthlyStrategy(
                dayOfMonth: 1, notificationTimes: const [morning, afternoon]),
            startDate: Date(year: 2026, month: 3, day: 1),
          )
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, Date.today().toDateTimeAt(afternoon));
      });
    });

    test('skips today when status is taken', () {
      withFixedClock(at: DateTime(2026, 6, 21, 12, 0), () {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aMonthlyStrategy(
                dayOfMonth: 21, notificationTimes: const [afternoon]),
            startDate: Date(year: 2026, month: 3, day: 21),
          )
        ]);
        when(intakesProvider.getLastIntakeLocalDateForSchedule(any))
            .thenReturn(Date.today());

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, DateTime(2026, 7, 21, 15));
      });
    });
  });

  group('planNotifications - DailySchedule', () {
    test('notify=false -> no plans', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDailyStrategy(notify: false),
          )
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 30);

        // Assert
        expect(plans, isEmpty);
      });
    });

    test('emits one PlannedOccurrence per (date, intake time)', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDailyStrategy(intakeTimes: const [morning, afternoon]),
          )
        ]);
        final today = Date.today();
        final tomorrow = today.add(const Duration(days: 1));
        final inTwoDays = today.add(const Duration(days: 2));

        // Act
        final plans = planner.planNotifications(maxScheduled: 5);

        // Assert
        expect(plans.map((plan) => plan.firstFire), [
          today.toDateTimeAt(afternoon), // today morning is past
          tomorrow.toDateTimeAt(morning),
          tomorrow.toDateTimeAt(afternoon),
          inTwoDays.toDateTimeAt(morning),
          inTwoDays.toDateTimeAt(afternoon),
        ]);
      });
    });

    test('first alert is today when the time is ahead and not taken', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDailyStrategy(intakeTimes: const [afternoon]),
          )
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, Date.today().toDateTimeAt(afternoon));
      });
    });

    test('skips today when the time is already past', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDailyStrategy(intakeTimes: const [morning]),
          )
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire,
            Date.today().add(const Duration(days: 1)).toDateTimeAt(morning));
      });
    });

    test('skips today when this time slot is taken and its time is ahead', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDailyStrategy(intakeTimes: const [afternoon]),
          )
        ]);
        when(intakesProvider.getTakenIntakesForScheduleOn(any, Date.today()))
            .thenReturn([aMedicationIntake(time: afternoon)]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire,
            Date.today().add(const Duration(days: 1)).toDateTimeAt(afternoon));
      });
    });

    test('keeps the correct time across a DST change', () {
      withFixedClock(at: DateTime(2026, 10, 24, 21, 0), () {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDailyStrategy(intakeTimes: const [evening]),
          )
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, DateTime(2026, 10, 25, 20, 30));
      });
    });

    test('a manually-logged intake (null scheduledTime) still plans the slot',
        () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDailyStrategy(intakeTimes: const [afternoon]),
          )
        ]);
        when(intakesProvider.getTakenIntakesForScheduleOn(any, Date.today()))
            .thenReturn([aMedicationIntake(time: null)]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, Date.today().toDateTimeAt(afternoon));
      });
    });

    test('a taken intake for a different slot does not skip this slot', () {
      withFixedClock(at: DateTime(2026, 6, 1, 8, 0), () {
        // Arrange
        withSchedules([
          aMedicationSchedule(
            scheduling: aDailyStrategy(intakeTimes: const [morning, afternoon]),
          )
        ]);
        when(intakesProvider.getTakenIntakesForScheduleOn(any, Date.today()))
            .thenReturn([aMedicationIntake(time: morning)]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, Date.today().toDateTimeAt(afternoon));
      });
    });

    test('no alert before startDate when startDate is in the future', () {
      withFixedClock(() {
        // Arrange
        final start = Date.today().add(const Duration(days: 5));
        withSchedules([
          aMedicationSchedule(scheduling: aDailyStrategy(), startDate: start)
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, start.toDateTimeAt(afternoon));
      });
    });
  });

  group('planNotifications - AsNeededSchedule', () {
    test('never emits plans', () {
      withFixedClock(() {
        // Arrange
        withSchedules([aMedicationSchedule(scheduling: anAsNeededStrategy())]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 30);

        // Assert
        expect(plans, isEmpty);
      });
    });
  });

  group('planNotifications - WeeklySchedule', () {
    test('empty notificationTimes -> no plans', () {
      withFixedClock(() {
        // Arrange
        withSchedules([aMedicationSchedule(scheduling: aWeeklyStrategy())]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 30);

        // Assert
        expect(plans, isEmpty);
      });
    });

    test('emits one PlannedOccurrence per (date, notificationTime)', () {
      withFixedClock(() {
        // Arrange
        // testNow = Mon. Mon, Wed and Fri -> today, +2, +4.
        withSchedules([
          aMedicationSchedule(
              scheduling: aWeeklyStrategy(
                  daysOfWeek: const [1, 3, 5],
                  notificationTimes: const [morning, afternoon]))
        ]);
        final today = Date.today();
        final wednesday = today.add(const Duration(days: 2));
        final friday = today.add(const Duration(days: 4));

        // Act
        final plans = planner.planNotifications(maxScheduled: 5);

        // Assert
        expect(plans.map((plan) => plan.firstFire), [
          today.toDateTimeAt(afternoon), // today morning is past
          wednesday.toDateTimeAt(morning),
          wednesday.toDateTimeAt(afternoon),
          friday.toDateTimeAt(morning),
          friday.toDateTimeAt(afternoon),
        ]);
      });
    });

    test('first alert is today when today matches and the time is ahead', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: aWeeklyStrategy(
                  daysOfWeek: const [1], notificationTimes: const [afternoon]))
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, Date.today().toDateTimeAt(afternoon));
      });
    });

    test('skips today when today matches but the time is past', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: aWeeklyStrategy(
                  daysOfWeek: const [1], notificationTimes: const [morning]))
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire,
            Date.today().add(const Duration(days: 7)).toDateTimeAt(morning));
      });
    });

    test('skips today when any intake is taken today and the time is ahead',
        () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: aWeeklyStrategy(
                  daysOfWeek: const [1], notificationTimes: const [afternoon]))
        ]);
        when(intakesProvider.getTakenIntakesForScheduleOn(any, Date.today()))
            .thenReturn([aMedicationIntake(time: morning)]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire,
            Date.today().add(const Duration(days: 7)).toDateTimeAt(afternoon));
      });
    });

    test('keeps the correct time across a DST change', () {
      withFixedClock(at: DateTime(2026, 10, 24, 21, 0), () {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: aWeeklyStrategy(
                  daysOfWeek: const [DateTime.saturday],
                  notificationTimes: const [evening]))
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, DateTime(2026, 10, 31, 20, 30));
      });
    });

    test('walks to the next matching weekday when today does not match', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: aWeeklyStrategy(
                  daysOfWeek: const [3], notificationTimes: const [afternoon]))
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire,
            Date.today().add(const Duration(days: 2)).toDateTimeAt(afternoon));
      });
    });

    test('no alert before startDate when startDate is in the future', () {
      withFixedClock(() {
        // Arrange
        // startDate = Wed (+2). Mon and Wed -> Mon is skipped this week.
        final start = Date.today().add(const Duration(days: 2));
        withSchedules([
          aMedicationSchedule(
              scheduling: aWeeklyStrategy(
                  daysOfWeek: const [1, 3],
                  notificationTimes: const [afternoon]),
              startDate: start)
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 1);

        // Assert
        expect(plans.single.firstFire, start.toDateTimeAt(afternoon));
      });
    });
  });

  group('planNotifications - allocation', () {
    test('two schedules share the slots in equal rounds', () {
      withFixedClock(() {
        // Arrange
        final everyDay = aMedicationSchedule(
            scheduling: anIntervalStrategy(
                intervalDays: 1, notificationTimes: const [afternoon]));
        final monthly = aMedicationSchedule(
            scheduling: aMonthlyStrategy(notificationTimes: const [afternoon]));
        withSchedules([everyDay, monthly]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 6);

        // Assert
        expect(plans.where((plan) => plan.schedule == monthly), hasLength(3));
      });
    });

    test('a schedule that runs out of dates leaves its slots to the others',
        () {
      withFixedClock(() {
        // Arrange
        final everyDay = aMedicationSchedule(
            scheduling: anIntervalStrategy(
                intervalDays: 1, notificationTimes: const [afternoon]));
        final nextDoseOnly = aMedicationSchedule(
            scheduling:
                aDynamicIntervalStrategy(notificationTimes: const [afternoon]));
        withSchedules([everyDay, nextDoseOnly]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 6);

        // Assert
        expect(plans.where((plan) => plan.schedule == everyDay), hasLength(5));
      });
    });

    test('never returns more than maxScheduled plans', () {
      withFixedClock(() {
        // Arrange
        withSchedules([
          aMedicationSchedule(
              scheduling: aWeeklyStrategy(
                  daysOfWeek: const [1, 3, 5],
                  notificationTimes: const [morning, afternoon]))
        ]);

        // Act
        final plans = planner.planNotifications(maxScheduled: 4);

        // Assert
        expect(plans, hasLength(4));
      });
    });
  });
}
