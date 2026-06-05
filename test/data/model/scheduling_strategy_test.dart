import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/scheduling_strategy.dart';

import '../../util/test_clock.dart';

void main() {
  group('SchedulingStrategy', () {
    group('JSON round-trip', () {
      test('IntervalDaysSchedule encodes and decodes via the discriminator',
          () {
        final original = IntervalDaysSchedule(
          intervalDays: 7,
          notificationTimes: [const TimeOfDay(hour: 8, minute: 30)],
        );

        final json = original.toJson();
        final decoded = SchedulingStrategyMapper.fromJson(json);

        expect(decoded, isA<IntervalDaysSchedule>());
        final round = decoded as IntervalDaysSchedule;
        expect(round.intervalDays, 7);
        expect(round.notificationTimes, [const TimeOfDay(hour: 8, minute: 30)]);
      });

      test('IntervalDaysSchedule round-trips with a null notificationTime', () {
        final original = IntervalDaysSchedule(intervalDays: 3);

        final decoded = SchedulingStrategyMapper.fromJson(original.toJson())
            as IntervalDaysSchedule;

        expect(decoded.intervalDays, 3);
        expect(decoded.notificationTimes, isEmpty);
      });

      test('DailySchedule encodes and decodes via the discriminator', () {
        final original = DailySchedule(
          intakeTimes: const [
            TimeOfDay(hour: 8, minute: 0),
            TimeOfDay(hour: 20, minute: 30),
          ],
          notify: false,
        );

        final json = original.toJson();
        final decoded = SchedulingStrategyMapper.fromJson(json);

        expect(decoded, isA<DailySchedule>());
        final round = decoded as DailySchedule;
        expect(round.intakeTimes, original.intakeTimes);
        expect(round.notify, isFalse);
      });

      test('WeeklySchedule encodes and decodes via the discriminator', () {
        const original = WeeklySchedule(
          daysOfWeek: [1, 3, 5],
          notificationTimes: [
            TimeOfDay(hour: 8, minute: 0),
            TimeOfDay(hour: 20, minute: 30),
          ],
        );

        final json = original.toJson();
        final decoded = SchedulingStrategyMapper.fromJson(json);

        expect(decoded, isA<WeeklySchedule>());
        final round = decoded as WeeklySchedule;
        expect(round.daysOfWeek, original.daysOfWeek);
        expect(round.notificationTimes, original.notificationTimes);
      });

      test('WeeklySchedule round-trips with empty notificationTimes', () {
        const original = WeeklySchedule(daysOfWeek: [2]);

        final decoded = SchedulingStrategyMapper.fromJson(original.toJson())
            as WeeklySchedule;

        expect(decoded.daysOfWeek, [2]);
        expect(decoded.notificationTimes, isEmpty);
      });

      test('discriminator value is `type`', () {
        final map = IntervalDaysSchedule(intervalDays: 7).toMap();
        expect(map['type'], 'intervalDays');

        final dailyMap = DailySchedule(intakeTimes: const []).toMap();
        expect(dailyMap['type'], 'daily');

        final weeklyMap = const WeeklySchedule(daysOfWeek: [1]).toMap();
        expect(weeklyMap['type'], 'weekly');
      });
    });

    group('IntervalDaysSchedule.nextDate', () {
      test('startDate > today -> returns startDate', () {
        final start = Date.today().add(Duration(days: 5));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.nextDate(start), start);
      });

      test('startDate == today -> returns startDate', () {
        final today = Date.today();
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.nextDate(today), today);
      });

      test(
          'today falls outside a scheduled date -> returns the next scheduled date',
          () {
        final start = Date.today().subtract(Duration(days: 4));
        final s = IntervalDaysSchedule(intervalDays: 7);

        final expectedNext = Date.today().add(Duration(days: 3));
        expect(s.nextDate(start), expectedNext);
      });

      test('today falls exactly on a scheduled date -> returns today', () {
        final start = Date.today().subtract(Duration(days: 7));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.nextDate(start), Date.today());
      });

      test('intervalDays = 1 and startDate < today -> returns today', () {
        final start = Date.today().subtract(Duration(days: 9));
        final s = IntervalDaysSchedule(intervalDays: 1);

        expect(s.nextDate(start), Date.today());
      });
    });

    group('IntervalDaysSchedule.previousDate', () {
      test('startDate > today -> returns null', () {
        final start = Date.today().add(Duration(days: 5));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.previousDate(start), isNull);
      });

      test('startDate == today -> returns null', () {
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.previousDate(Date.today()), isNull);
      });

      test(
          'today falls outside a scheduled date -> returns the most recent past scheduled date',
          () {
        final start = Date.today().subtract(Duration(days: 4));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.previousDate(start), start);
      });

      test(
          'today falls exactly on a scheduled date -> returns scheduled date before today',
          () {
        final start = Date.today().subtract(Duration(days: 7));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.previousDate(start), start);
      });

      test('intervalDays = 1 and startDate < today -> returns yesterday', () {
        final start = Date.today().subtract(Duration(days: 9));
        final s = IntervalDaysSchedule(intervalDays: 1);

        expect(s.previousDate(start), Date.today().subtract(Duration(days: 1)));
      });
    });

    group('Consistency between previous and next date', () {
      test(
          'when startDate < today -> previous < next and difference == intervalDays',
          () {
        final start = Date.today().subtract(Duration(days: 4));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.nextDate(start).differenceInDays(s.previousDate(start)!),
            s.intervalDays);
      });

      test(
          'difference == intervalDays when today is exactly on a scheduled date',
          () {
        final start = Date.today().subtract(Duration(days: 7));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.nextDate(start).differenceInDays(s.previousDate(start)!),
            s.intervalDays);
      });
    });

    group('IntervalDaysSchedule.getNextDates', () {
      test('today is an intake date -> first returned date is today', () {
        final start = Date.today().subtract(Duration(days: 7));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.getNextDates(start, 3).first, Date.today());
      });

      test(
          'today is not an intake date -> first returned date is next scheduled date',
          () {
        final start = Date.today().subtract(Duration(days: 4));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.getNextDates(start, 2).first,
            Date.today().add(Duration(days: 3)));
      });

      test('startDate is today -> first returned date is today', () {
        final today = Date.today();
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.getNextDates(today, 2).first, today);
      });

      test('startDate is in the future -> first returned date is startDate',
          () {
        final start = Date.today().add(Duration(days: 5));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.getNextDates(start, 2).first, start);
      });

      test('count = 1 -> returns exactly one date', () {
        final start = Date.today().subtract(Duration(days: 9));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.getNextDates(start, 1).length, 1);
      });

      test('count > 1 -> returns exactly count dates', () {
        final start = Date.today().subtract(Duration(days: 9));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.getNextDates(start, 4).length, 4);
      });

      test('returned dates are spaced by intervalDays', () {
        final start = Date.today().subtract(Duration(days: 9));
        final s = IntervalDaysSchedule(intervalDays: 7);

        final dates = s.getNextDates(start, 3);
        expect(dates[2].differenceInDays(dates[1]), 7);
      });

      test('count = 0 -> returns empty list', () {
        final start = Date.today().subtract(Duration(days: 9));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.getNextDates(start, 0), isEmpty);
      });

      test('count < 0 -> throws ArgumentError', () {
        final start = Date.today().subtract(Duration(days: 9));
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(() => s.getNextDates(start, -1), throwsArgumentError);
      });
    });

    group('IntervalDaysSchedule.isTakenTodayOrLater', () {
      final s = IntervalDaysSchedule(intervalDays: 7);

      test('returns false if no last taken', () {
        expect(s.isTakenTodayOrLater(null), isFalse);
      });

      test('returns false if last taken date is before today', () {
        expect(
            s.isTakenTodayOrLater(
                Date.today().subtract(const Duration(days: 1))),
            isFalse);
      });

      test('returns true if last taken date is after today', () {
        expect(s.isTakenTodayOrLater(Date.today().add(const Duration(days: 1))),
            isTrue);
      });

      test('returns true if last taken date is today', () {
        expect(s.isTakenTodayOrLater(Date.today()), isTrue);
      });
    });

    group('IntervalDaysSchedule.statusFor', () {
      IntervalDaysSchedule scheduledForToday() =>
          IntervalDaysSchedule(intervalDays: 7);

      Date scheduledForTodayStart() =>
          Date.today().subtract(Duration(days: 14));

      group('date == today', () {
        test('scheduled for today, taken today -> taken', () {
          final s = scheduledForToday();
          expect(
              s.statusFor(
                  startDate: scheduledForTodayStart(),
                  date: Date.today(),
                  lastTaken: Date.today()),
              ScheduleStatus.taken);
        });

        test('scheduled for today, taken in the future -> taken', () {
          final s = scheduledForToday();
          expect(
              s.statusFor(
                  startDate: scheduledForTodayStart(),
                  date: Date.today(),
                  lastTaken: Date.today().add(Duration(days: 1))),
              ScheduleStatus.taken);
        });

        test(
            'scheduled for today, last intake before previous scheduled date -> todayOverdue',
            () {
          final s = scheduledForToday();
          final start = scheduledForTodayStart();
          final lastTaken = s.previousDate(start)!.subtract(Duration(days: 1));
          expect(
              s.statusFor(
                  startDate: start, date: Date.today(), lastTaken: lastTaken),
              ScheduleStatus.todayOverdue);
        });

        test('scheduled for today, never taken -> todayOverdue', () {
          final s = scheduledForToday();
          expect(
              s.statusFor(
                  startDate: scheduledForTodayStart(), date: Date.today()),
              ScheduleStatus.todayOverdue);
        });

        test(
            'scheduled for today, last intake strictly between previous scheduled date and today -> todayEarly',
            () {
          final s = scheduledForToday();
          final start = scheduledForTodayStart();
          final lastTaken = s.previousDate(start)!.add(Duration(days: 1));
          expect(
              s.statusFor(
                  startDate: start, date: Date.today(), lastTaken: lastTaken),
              ScheduleStatus.todayEarly);
        });

        test(
            'scheduled for today, last intake equals previous scheduled date -> today',
            () {
          final s = scheduledForToday();
          final start = scheduledForTodayStart();
          expect(
              s.statusFor(
                  startDate: start,
                  date: Date.today(),
                  lastTaken: s.previousDate(start)),
              ScheduleStatus.today);
        });

        test(
            'scheduled for today with no previous date and never taken -> today',
            () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          expect(s.previousDate(Date.today()), isNull);
          expect(s.statusFor(startDate: Date.today(), date: Date.today()),
              ScheduleStatus.today);
        });

        test('not scheduled for today, last intake is overdue -> overdue', () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          final start = Date.today().subtract(Duration(days: 10));
          final lastTaken = s.previousDate(start)!.subtract(Duration(days: 1));
          expect(
              s.statusFor(
                  startDate: start, date: Date.today(), lastTaken: lastTaken),
              ScheduleStatus.overdue);
        });

        test('not scheduled for today, never taken and overdue -> overdue', () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          final start = Date.today().subtract(Duration(days: 10));
          expect(s.statusFor(startDate: start, date: Date.today()),
              ScheduleStatus.overdue);
        });

        test('not scheduled for today, start date in the future -> upcoming',
            () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          expect(
              s.statusFor(
                  startDate: Date.today().add(Duration(days: 5)),
                  date: Date.today()),
              ScheduleStatus.upcoming);
        });

        test(
            'not scheduled for today, last intake on or after previous scheduled date -> upcoming',
            () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          final start = Date.today().subtract(Duration(days: 10));
          expect(
              s.statusFor(
                  startDate: start,
                  date: Date.today(),
                  lastTaken: s.previousDate(start)),
              ScheduleStatus.upcoming);
        });

        test('taken takes priority over todayEarly', () {
          final s = scheduledForToday();
          expect(
              s.statusFor(
                  startDate: scheduledForTodayStart(),
                  date: Date.today(),
                  lastTaken: Date.today()),
              ScheduleStatus.taken);
        });
      });

      group('date != today', () {
        test('future date -> upcoming regardless of overdue history', () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          final start = Date.today().subtract(Duration(days: 10));
          expect(
              s.statusFor(
                  startDate: start, date: Date.today().add(Duration(days: 1))),
              ScheduleStatus.upcoming);
        });

        test('future date -> upcoming even when taken today', () {
          final s = scheduledForToday();
          expect(
              s.statusFor(
                  startDate: scheduledForTodayStart(),
                  date: Date.today().add(Duration(days: 7)),
                  lastTaken: Date.today()),
              ScheduleStatus.upcoming);
        });
      });
    });

    group('DailySchedule.statusFor', () {
      const time = TimeOfDay(hour: 8, minute: 0);
      const s = DailySchedule(intakeTimes: [time]);

      MedicationIntake intakeAt(TimeOfDay t) => MedicationIntake(
            id: t.hour * 60 + t.minute,
            dose: Decimal.one,
            takenDateTime: DateTime.utc(2025, 1, 1, t.hour, t.minute),
            takenTimeZone: 'Etc/UTC',
            molecule: KnownMolecules.estradiol,
            administrationRoute: AdministrationRoute.oral,
            scheduledTime: t,
          );

      test('matched intake on today -> taken', () {
        expect(s.statusFor(date: Date.today(), matchedIntake: intakeAt(time)),
            ScheduleStatus.taken);
      });

      test('matched intake on a future date -> taken', () {
        expect(
            s.statusFor(
                date: Date.today().add(const Duration(days: 1)),
                matchedIntake: intakeAt(time)),
            ScheduleStatus.taken);
      });

      test('today, no matched intake -> today', () {
        expect(s.statusFor(date: Date.today()), ScheduleStatus.today);
      });

      test('future date, no matched intake -> upcoming', () {
        expect(s.statusFor(date: Date.today().add(const Duration(days: 1))),
            ScheduleStatus.upcoming);
      });
    });

    group('WeeklySchedule.nextDate', () {
      test(
          'startDate > today and startDate.weekday in daysOfWeek -> returns startDate',
          () {
        withFixedClock(() {
          final start = Date.today().add(const Duration(days: 2)); // Wed
          const s = WeeklySchedule(daysOfWeek: [3]);

          expect(s.nextDate(start), start);
        });
      });

      test(
          'startDate > today and startDate.weekday not in daysOfWeek -> returns next scheduled day on or after startDate',
          () {
        withFixedClock(() {
          final start = Date.today().add(const Duration(days: 2)); // Wed
          const s = WeeklySchedule(daysOfWeek: [5]); // Fri

          expect(s.nextDate(start), Date.today().add(const Duration(days: 4)));
        });
      });

      test('startDate == today and today is scheduled -> returns today', () {
        withFixedClock(() {
          const s = WeeklySchedule(daysOfWeek: [1]); // Mon

          expect(s.nextDate(Date.today()), Date.today());
        });
      });

      test(
          'startDate == today and today is not scheduled -> returns next scheduled day after today',
          () {
        withFixedClock(() {
          const s = WeeklySchedule(daysOfWeek: [3]); // Wed

          expect(s.nextDate(Date.today()),
              Date.today().add(const Duration(days: 2)));
        });
      });

      test('startDate < today and today is scheduled -> returns today', () {
        withFixedClock(() {
          final start = Date.today().subtract(const Duration(days: 14));
          const s = WeeklySchedule(daysOfWeek: [1]); // Mon

          expect(s.nextDate(start), Date.today());
        });
      });

      test(
          'startDate < today and today is not scheduled -> returns next scheduled day after today',
          () {
        withFixedClock(() {
          final start = Date.today().subtract(const Duration(days: 14));
          const s = WeeklySchedule(daysOfWeek: [3]); // Wed

          expect(s.nextDate(start), Date.today().add(const Duration(days: 2)));
        });
      });

      test('multiple daysOfWeek -> returns the earliest match', () {
        withFixedClock(() {
          // testNow Mon. Wed = +2, Fri = +4. Expect Wed.
          const s = WeeklySchedule(daysOfWeek: [3, 5]); // Wed, Fri

          expect(s.nextDate(Date.today()),
              Date.today().add(const Duration(days: 2)));
        });
      });
    });

    group('WeeklySchedule.previousDate', () {
      test('startDate > today -> returns null', () {
        withFixedClock(() {
          final start = Date.today().add(const Duration(days: 7));
          const s = WeeklySchedule(daysOfWeek: [1]);

          expect(s.previousDate(start), isNull);
        });
      });

      test('startDate == today -> returns null', () {
        withFixedClock(() {
          const s = WeeklySchedule(daysOfWeek: [1]);

          expect(s.previousDate(Date.today()), isNull);
        });
      });

      test(
          'today is scheduled -> returns the most recent past scheduled day (a week earlier)',
          () {
        withFixedClock(() {
          final start = Date.today().subtract(const Duration(days: 14));
          const s = WeeklySchedule(daysOfWeek: [1]); // Mon

          expect(s.previousDate(start),
              Date.today().subtract(const Duration(days: 7)));
        });
      });

      test(
          'today is not scheduled -> returns the most recent past scheduled day',
          () {
        withFixedClock(() {
          // testNow Mon. Last Fri = -3 (Mon -> Sun -> Sat -> Fri).
          final start = Date.today().subtract(const Duration(days: 14));
          const s = WeeklySchedule(daysOfWeek: [5]); // Fri

          expect(s.previousDate(start),
              Date.today().subtract(const Duration(days: 3)));
        });
      });

      test(
          'no scheduled day exists between startDate and today -> returns null',
          () {
        withFixedClock(() {
          // testNow Mon. daysOfWeek = Wed. startDate = Sun (yesterday).
          // No Wed in [Sun, Mon).
          final start = Date.today().subtract(const Duration(days: 1));
          const s = WeeklySchedule(daysOfWeek: [3]);

          expect(s.previousDate(start), isNull);
        });
      });

      test(
          'startDate itself is the most recent scheduled day -> returns startDate',
          () {
        withFixedClock(() {
          // testNow Mon. daysOfWeek = Sun. startDate = Sun (yesterday).
          final start = Date.today().subtract(const Duration(days: 1));
          const s = WeeklySchedule(daysOfWeek: [7]);

          expect(s.previousDate(start), start);
        });
      });

      test('multiple daysOfWeek -> returns the most recent match', () {
        withFixedClock(() {
          // testNow Mon. Last Fri = -3. Last Wed = -5. Expect Fri.
          final start = Date.today().subtract(const Duration(days: 14));
          const s = WeeklySchedule(daysOfWeek: [3, 5]); // Wed, Fri

          expect(s.previousDate(start),
              Date.today().subtract(const Duration(days: 3)));
        });
      });
    });

    group('WeeklySchedule.statusFor', () {
      // Today's weekday is Mon (1) under testNow.
      WeeklySchedule scheduledForToday() =>
          const WeeklySchedule(daysOfWeek: [1]);

      Date scheduledForTodayStart() =>
          Date.today().subtract(const Duration(days: 14));

      group('date == today', () {
        test('scheduled for today, taken today -> taken', () {
          withFixedClock(() {
            final s = scheduledForToday();
            expect(
                s.statusFor(
                    startDate: scheduledForTodayStart(),
                    date: Date.today(),
                    lastTaken: Date.today()),
                ScheduleStatus.taken);
          });
        });

        test('scheduled for today, taken in the future -> taken', () {
          withFixedClock(() {
            final s = scheduledForToday();
            expect(
                s.statusFor(
                    startDate: scheduledForTodayStart(),
                    date: Date.today(),
                    lastTaken: Date.today().add(const Duration(days: 1))),
                ScheduleStatus.taken);
          });
        });

        test(
            'scheduled for today, last intake before previous scheduled date -> todayOverdue',
            () {
          withFixedClock(() {
            final s = scheduledForToday();
            final start = scheduledForTodayStart();
            final lastTaken =
                s.previousDate(start)!.subtract(const Duration(days: 1));
            expect(
                s.statusFor(
                    startDate: start, date: Date.today(), lastTaken: lastTaken),
                ScheduleStatus.todayOverdue);
          });
        });

        test('scheduled for today, never taken -> todayOverdue', () {
          withFixedClock(() {
            final s = scheduledForToday();
            expect(
                s.statusFor(
                    startDate: scheduledForTodayStart(), date: Date.today()),
                ScheduleStatus.todayOverdue);
          });
        });

        test(
            'scheduled for today, last intake strictly between previous scheduled date and today -> todayEarly',
            () {
          withFixedClock(() {
            final s = scheduledForToday();
            final start = scheduledForTodayStart();
            final lastTaken =
                s.previousDate(start)!.add(const Duration(days: 1));
            expect(
                s.statusFor(
                    startDate: start, date: Date.today(), lastTaken: lastTaken),
                ScheduleStatus.todayEarly);
          });
        });

        test(
            'scheduled for today, last intake equals previous scheduled date -> today',
            () {
          withFixedClock(() {
            final s = scheduledForToday();
            final start = scheduledForTodayStart();
            expect(
                s.statusFor(
                    startDate: start,
                    date: Date.today(),
                    lastTaken: s.previousDate(start)),
                ScheduleStatus.today);
          });
        });

        test(
            'scheduled for today with no previous date and never taken -> today',
            () {
          withFixedClock(() {
            const s = WeeklySchedule(daysOfWeek: [1]);
            expect(s.previousDate(Date.today()), isNull);
            expect(s.statusFor(startDate: Date.today(), date: Date.today()),
                ScheduleStatus.today);
          });
        });

        test('not scheduled for today, last intake is overdue -> overdue', () {
          withFixedClock(() {
            // Fri schedule. testNow Mon. previousDate = last Fri (-3).
            const s = WeeklySchedule(daysOfWeek: [5]);
            final start = Date.today().subtract(const Duration(days: 14));
            final lastTaken =
                s.previousDate(start)!.subtract(const Duration(days: 1));
            expect(
                s.statusFor(
                    startDate: start, date: Date.today(), lastTaken: lastTaken),
                ScheduleStatus.overdue);
          });
        });

        test('not scheduled for today, never taken and overdue -> overdue', () {
          withFixedClock(() {
            const s = WeeklySchedule(daysOfWeek: [5]); // Fri
            final start = Date.today().subtract(const Duration(days: 14));
            expect(s.statusFor(startDate: start, date: Date.today()),
                ScheduleStatus.overdue);
          });
        });

        test('not scheduled for today, start date in the future -> upcoming',
            () {
          withFixedClock(() {
            const s = WeeklySchedule(daysOfWeek: [5]);
            expect(
                s.statusFor(
                    startDate: Date.today().add(const Duration(days: 5)),
                    date: Date.today()),
                ScheduleStatus.upcoming);
          });
        });

        test(
            'not scheduled for today, last intake on or after previous scheduled date -> upcoming',
            () {
          withFixedClock(() {
            const s = WeeklySchedule(daysOfWeek: [5]);
            final start = Date.today().subtract(const Duration(days: 14));
            expect(
                s.statusFor(
                    startDate: start,
                    date: Date.today(),
                    lastTaken: s.previousDate(start)),
                ScheduleStatus.upcoming);
          });
        });

        test('taken takes priority over todayEarly', () {
          withFixedClock(() {
            final s = scheduledForToday();
            expect(
                s.statusFor(
                    startDate: scheduledForTodayStart(),
                    date: Date.today(),
                    lastTaken: Date.today()),
                ScheduleStatus.taken);
          });
        });
      });

      group('date != today', () {
        test('future date -> upcoming regardless of overdue history', () {
          withFixedClock(() {
            const s = WeeklySchedule(daysOfWeek: [1]);
            final start = Date.today().subtract(const Duration(days: 14));
            expect(
                s.statusFor(
                    startDate: start,
                    date: Date.today().add(const Duration(days: 7))),
                ScheduleStatus.upcoming);
          });
        });

        test('future date -> upcoming even when taken today', () {
          withFixedClock(() {
            final s = scheduledForToday();
            expect(
                s.statusFor(
                    startDate: scheduledForTodayStart(),
                    date: Date.today().add(const Duration(days: 7)),
                    lastTaken: Date.today()),
                ScheduleStatus.upcoming);
          });
        });
      });
    });
  });
}
