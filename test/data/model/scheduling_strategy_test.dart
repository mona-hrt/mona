import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/molecule.dart';
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

    group('IntervalDaysSchedule.slotInfoFor', () {
      IntervalDaysSchedule scheduledForToday() =>
          IntervalDaysSchedule(intervalDays: 7);

      Date scheduledForTodayStart() =>
          Date.today().subtract(Duration(days: 14));

      ScheduleStatus statusFrom(
        IntervalDaysSchedule s, {
        required Date startDate,
        Date? lastTakenLocalDate,
      }) =>
          s
              .slotInfoFor(
                startDate: startDate,
                lastTakenLocalDate: lastTakenLocalDate,
              )
              .status;

      group('status', () {
        test('scheduled for today, taken today -> taken', () {
          final s = scheduledForToday();
          expect(
              statusFrom(s,
                  startDate: scheduledForTodayStart(),
                  lastTakenLocalDate: Date.today()),
              ScheduleStatus.taken);
        });

        test('scheduled for today, taken in the future -> taken', () {
          final s = scheduledForToday();
          expect(
              statusFrom(s,
                  startDate: scheduledForTodayStart(),
                  lastTakenLocalDate: Date.today().add(Duration(days: 1))),
              ScheduleStatus.taken);
        });

        test(
            'scheduled for today, last intake before previous scheduled date -> todayOverdue',
            () {
          final s = scheduledForToday();
          final start = scheduledForTodayStart();
          final lastTaken = s.previousDate(start)!.subtract(Duration(days: 1));
          expect(statusFrom(s, startDate: start, lastTakenLocalDate: lastTaken),
              ScheduleStatus.todayOverdue);
        });

        test('scheduled for today, never taken -> todayOverdue', () {
          final s = scheduledForToday();
          expect(statusFrom(s, startDate: scheduledForTodayStart()),
              ScheduleStatus.todayOverdue);
        });

        test(
            'scheduled for today, last intake strictly between previous scheduled date and today -> todayEarly',
            () {
          final s = scheduledForToday();
          final start = scheduledForTodayStart();
          final lastTaken = s.previousDate(start)!.add(Duration(days: 1));
          expect(statusFrom(s, startDate: start, lastTakenLocalDate: lastTaken),
              ScheduleStatus.todayEarly);
        });

        test(
            'scheduled for today, last intake equals previous scheduled date -> today',
            () {
          final s = scheduledForToday();
          final start = scheduledForTodayStart();
          expect(
              statusFrom(s,
                  startDate: start, lastTakenLocalDate: s.previousDate(start)),
              ScheduleStatus.today);
        });

        test(
            'scheduled for today with no previous date and never taken -> today',
            () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          expect(s.previousDate(Date.today()), isNull);
          expect(statusFrom(s, startDate: Date.today()), ScheduleStatus.today);
        });

        test('not scheduled for today, last intake is overdue -> overdue', () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          final start = Date.today().subtract(Duration(days: 10));
          final lastTaken = s.previousDate(start)!.subtract(Duration(days: 1));
          expect(statusFrom(s, startDate: start, lastTakenLocalDate: lastTaken),
              ScheduleStatus.overdue);
        });

        test('not scheduled for today, never taken and overdue -> overdue', () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          final start = Date.today().subtract(Duration(days: 10));
          expect(statusFrom(s, startDate: start), ScheduleStatus.overdue);
        });

        test('not scheduled for today, start date in the future -> upcoming',
            () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          expect(statusFrom(s, startDate: Date.today().add(Duration(days: 5))),
              ScheduleStatus.upcoming);
        });

        test(
            'not scheduled for today, last intake on or after previous scheduled date -> upcoming',
            () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          final start = Date.today().subtract(Duration(days: 10));
          expect(
              statusFrom(s,
                  startDate: start, lastTakenLocalDate: s.previousDate(start)),
              ScheduleStatus.upcoming);
        });

        test('taken takes priority over todayEarly', () {
          final s = scheduledForToday();
          expect(
              statusFrom(s,
                  startDate: scheduledForTodayStart(),
                  lastTakenLocalDate: Date.today()),
              ScheduleStatus.taken);
        });
      });

      group('shape', () {
        test('always emits a slot with a null time', () {
          final s = IntervalDaysSchedule(intervalDays: 7);
          final slot = s.slotInfoFor(startDate: Date.today());

          expect(slot.time, isNull);
        });
      });

      group('intake attachment', () {
        final intake = MedicationIntake(
          id: 1,
          dose: Decimal.one,
          takenDateTime: DateTime.utc(2025, 1, 1, 12),
          takenTimeZone: 'Etc/UTC',
          molecule: KnownMolecules.estradiol,
          administrationRoute: AdministrationRoute.oral,
        );

        test('attaches lastTakenIntake when status is taken', () {
          final s = scheduledForToday();
          final slot = s.slotInfoFor(
            startDate: scheduledForTodayStart(),
            lastTakenLocalDate: Date.today(),
            lastTakenIntake: intake,
          );

          expect(slot.status, ScheduleStatus.taken);
          expect(slot.intake, intake);
        });

        test('does not attach lastTakenIntake when status is not taken', () {
          final s = scheduledForToday();
          final slot = s.slotInfoFor(
            startDate: scheduledForTodayStart(),
            lastTakenIntake: intake,
          );

          expect(slot.status, isNot(ScheduleStatus.taken));
          expect(slot.intake, isNull);
        });
      });
    });

    group('DailySchedule.slotInfosFor', () {
      const morning = TimeOfDay(hour: 8, minute: 0);
      const afternoon = TimeOfDay(hour: 14, minute: 0);
      const evening = TimeOfDay(hour: 20, minute: 30);

      MedicationIntake intakeAt(TimeOfDay time) => MedicationIntake(
            id: time.hour * 60 + time.minute,
            dose: Decimal.one,
            takenDateTime: DateTime.utc(2025, 1, 1, time.hour, time.minute),
            takenTimeZone: 'Etc/UTC',
            molecule: KnownMolecules.estradiol,
            administrationRoute: AdministrationRoute.oral,
            scheduledTime: time,
          );

      test('emits one slot per intakeTime, preserving order', () {
        const s = DailySchedule(intakeTimes: [evening, morning, afternoon]);

        final slots = s.slotInfosFor();

        expect(slots.map((s) => s.time), [evening, morning, afternoon]);
      });

      test('empty intakeTimes -> empty list', () {
        const s = DailySchedule(intakeTimes: []);

        expect(s.slotInfosFor(), isEmpty);
      });

      test('no taken intakes -> every slot is today with no intake attached',
          () {
        const s = DailySchedule(intakeTimes: [morning, afternoon, evening]);

        final slots = s.slotInfosFor();

        expect(slots.map((s) => s.status), everyElement(ScheduleStatus.today));
        expect(slots.map((s) => s.intake), everyElement(isNull));
      });

      test('a matching intake -> that slot becomes taken with the intake', () {
        const s = DailySchedule(intakeTimes: [morning, afternoon, evening]);
        final morningIntake = intakeAt(morning);

        final slots = s.slotInfosFor(takenIntakesToday: [morningIntake]);

        expect(
          {for (final s in slots) s.time: s.status},
          {
            morning: ScheduleStatus.taken,
            afternoon: ScheduleStatus.today,
            evening: ScheduleStatus.today,
          },
        );
        expect(
          {for (final s in slots) s.time: s.intake},
          {morning: morningIntake, afternoon: null, evening: null},
        );
      });

      test('intake whose scheduledTime is unknown to the schedule is ignored',
          () {
        const s = DailySchedule(intakeTimes: [morning, evening]);
        final strayIntake = intakeAt(afternoon);

        final slots = s.slotInfosFor(takenIntakesToday: [strayIntake]);

        expect(slots.map((s) => s.status), everyElement(ScheduleStatus.today));
        expect(slots.map((s) => s.intake), everyElement(isNull));
      });
    });
  });
}
