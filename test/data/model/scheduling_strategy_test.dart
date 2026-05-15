import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/scheduling_strategy.dart';
import 'package:mona/l10n/app_localizations_en.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('SchedulingStrategy', () {
    group('JSON round-trip', () {
      test('IntervalDaysSchedule encodes and decodes via the discriminator',
          () {
        final original = IntervalDaysSchedule(
          intervalDays: 7,
          notificationTime: const TimeOfDay(hour: 8, minute: 30),
        );

        final json = original.toJson();
        final decoded = SchedulingStrategyMapper.fromJson(json);

        expect(decoded, isA<IntervalDaysSchedule>());
        final round = decoded as IntervalDaysSchedule;
        expect(round.intervalDays, 7);
        expect(round.notificationTime, const TimeOfDay(hour: 8, minute: 30));
      });

      test('IntervalDaysSchedule round-trips with a null notificationTime', () {
        final original = IntervalDaysSchedule(intervalDays: 3);

        final decoded = SchedulingStrategyMapper.fromJson(original.toJson())
            as IntervalDaysSchedule;

        expect(decoded.intervalDays, 3);
        expect(decoded.notificationTime, isNull);
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

      test('discriminator value is `type`', () {
        final map = IntervalDaysSchedule(intervalDays: 7).toMap();
        expect(map['type'], 'intervalDays');

        final dailyMap = DailySchedule(intakeTimes: const []).toMap();
        expect(dailyMap['type'], 'daily');
      });
    });

    group('IntervalDaysSchedule.validateIntervalDays', () {
      test('rejects null, empty, zero, negative, and non-numeric input', () {
        expect(
          [
            IntervalDaysSchedule.validateIntervalDays(l10n, null),
            IntervalDaysSchedule.validateIntervalDays(l10n, ''),
            IntervalDaysSchedule.validateIntervalDays(l10n, '0'),
            IntervalDaysSchedule.validateIntervalDays(l10n, '-2'),
            IntervalDaysSchedule.validateIntervalDays(l10n, 'abc'),
            IntervalDaysSchedule.validateIntervalDays(l10n, '7'),
          ],
          [
            isNotNull,
            isNotNull,
            isNotNull,
            isNotNull,
            isNotNull,
            isNull,
          ],
        );
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

    group('IntervalDaysSchedule.isScheduledForToday', () {
      test('returns true when today is a scheduled date', () {
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.isScheduledForToday(Date.today()), isTrue);
      });

      test('returns false when next scheduled date is in future', () {
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.isScheduledForToday(Date.today().add(Duration(days: 3))),
            isFalse);
      });

      test('returns false when next scheduled date is in past', () {
        final s = IntervalDaysSchedule(intervalDays: 7);

        expect(s.isScheduledForToday(Date.today().subtract(Duration(days: 3))),
            isFalse);
      });
    });

    group('IntervalDaysSchedule.isLate', () {
      final s = IntervalDaysSchedule(intervalDays: 7);
      final start = Date.today().subtract(Duration(days: 14));

      test('returns true when lastTaken is before previousDate', () {
        final lastTaken = s.previousDate(start)!.subtract(Duration(days: 1));
        expect(s.isLate(start, lastTaken), isTrue);
      });

      test('returns false when lastTaken is on previousDate', () {
        expect(s.isLate(start, s.previousDate(start)!), isFalse);
      });

      test('returns false when lastTaken is after previousDate', () {
        final lastTaken = s.previousDate(start)!.add(Duration(days: 1));
        expect(s.isLate(start, lastTaken), isFalse);
      });

      test('returns true when lastTaken is null but schedule is overdue', () {
        expect(s.isLate(start, null), isTrue);
      });

      test('returns false when lastTaken is null but startDate is today', () {
        expect(s.isLate(Date.today(), null), isFalse);
      });

      test('returns false when lastTaken is null but startDate is future', () {
        expect(s.isLate(Date.today().add(Duration(days: 3)), null), isFalse);
      });
    });

    group('IntervalDaysSchedule.lastTakenLate', () {
      final s = IntervalDaysSchedule(intervalDays: 7);
      final start = Date.today().subtract(Duration(days: 14));

      test('returns false when lastTaken is null', () {
        expect(s.lastTakenLate(start, null), isFalse);
      });

      test('returns false when previousDate is null (startDate today)', () {
        expect(s.lastTakenLate(Date.today(), Date.today()), isFalse);
      });

      test('returns false when previousDate is null (startDate in future)', () {
        expect(
            s.lastTakenLate(Date.today().add(Duration(days: 3)), Date.today()),
            isFalse);
      });

      test('returns false when lastTaken is before previousDate', () {
        final lastTaken = s.previousDate(start)!.subtract(Duration(days: 1));
        expect(s.lastTakenLate(start, lastTaken), isFalse);
      });

      test('returns false when lastTaken equals previousDate', () {
        expect(s.lastTakenLate(start, s.previousDate(start)), isFalse);
      });

      test('returns true when lastTaken is after previousDate', () {
        final lastTaken = s.previousDate(start)!.add(Duration(days: 1));
        expect(s.lastTakenLate(start, lastTaken), isTrue);
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

      test('scheduled for today, taken today -> taken', () {
        final s = scheduledForToday();
        expect(s.statusFor(scheduledForTodayStart(), Date.today()),
            ScheduleStatus.taken);
      });

      test('scheduled for today, taken in the future -> taken', () {
        final s = scheduledForToday();
        expect(
            s.statusFor(
                scheduledForTodayStart(), Date.today().add(Duration(days: 1))),
            ScheduleStatus.taken);
      });

      test(
          'scheduled for today, last intake before previous scheduled date -> todayOverdue',
          () {
        final s = scheduledForToday();
        final start = scheduledForTodayStart();
        final lastTaken = s.previousDate(start)!.subtract(Duration(days: 1));
        expect(s.statusFor(start, lastTaken), ScheduleStatus.todayOverdue);
      });

      test('scheduled for today, never taken -> todayOverdue', () {
        final s = scheduledForToday();
        expect(s.statusFor(scheduledForTodayStart(), null),
            ScheduleStatus.todayOverdue);
      });

      test(
          'scheduled for today, last intake strictly between previous scheduled date and today -> todayEarly',
          () {
        final s = scheduledForToday();
        final start = scheduledForTodayStart();
        final lastTaken = s.previousDate(start)!.add(Duration(days: 1));
        expect(s.statusFor(start, lastTaken), ScheduleStatus.todayEarly);
      });

      test(
          'scheduled for today, last intake equals previous scheduled date -> today',
          () {
        final s = scheduledForToday();
        final start = scheduledForTodayStart();
        expect(s.statusFor(start, s.previousDate(start)), ScheduleStatus.today);
      });

      test('scheduled for today with no previous date and never taken -> today',
          () {
        final s = IntervalDaysSchedule(intervalDays: 7);
        expect(s.previousDate(Date.today()), isNull);
        expect(s.statusFor(Date.today(), null), ScheduleStatus.today);
      });

      test('not scheduled for today, last intake is overdue -> overdue', () {
        final s = IntervalDaysSchedule(intervalDays: 7);
        final start = Date.today().subtract(Duration(days: 10));
        expect(s.isScheduledForToday(start), isFalse);

        final lastTaken = s.previousDate(start)!.subtract(Duration(days: 1));
        expect(s.statusFor(start, lastTaken), ScheduleStatus.overdue);
      });

      test('not scheduled for today, never taken and overdue -> overdue', () {
        final s = IntervalDaysSchedule(intervalDays: 7);
        final start = Date.today().subtract(Duration(days: 10));
        expect(s.isScheduledForToday(start), isFalse);

        expect(s.statusFor(start, null), ScheduleStatus.overdue);
      });

      test('not scheduled for today, start date in the future -> upcoming', () {
        final s = IntervalDaysSchedule(intervalDays: 7);
        expect(s.statusFor(Date.today().add(Duration(days: 5)), null),
            ScheduleStatus.upcoming);
      });

      test(
          'not scheduled for today, last intake on or after previous scheduled date -> upcoming',
          () {
        final s = IntervalDaysSchedule(intervalDays: 7);
        final start = Date.today().subtract(Duration(days: 10));
        expect(
            s.statusFor(start, s.previousDate(start)), ScheduleStatus.upcoming);
      });

      test('taken status takes priority over todayEarly', () {
        final s = scheduledForToday();
        expect(s.statusFor(scheduledForTodayStart(), Date.today()),
            ScheduleStatus.taken);
      });
    });
  });
}
