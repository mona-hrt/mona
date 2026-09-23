import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import '../../fixtures.dart';
import 'generic_repository_mock.dart';

void main() {
  late MedicationIntakeProvider provider;
  late GenericRepositoryMock<MedicationIntake> repo;

  setUpAll(() {
    tz.initializeTimeZones();
  });

  setUp(() {
    repo = GenericRepositoryMock<MedicationIntake>();
    provider = MedicationIntakeProvider(repository: repo);
  });

  group('MedicationIntakeProvider Tests', () {
    test('initialization loads intakes', () async {
      repo.insert(aMedicationIntake(id: 1));
      repo.insert(aMedicationIntake(id: 2));
      await provider.fetchIntakes();
      expect(provider.intakes.length, repo.items.length);
    });

    test('add inserts a new item', () async {
      // Arrange
      final newDose = Decimal.parse('2.5');

      // Act
      await provider.add(aMedicationIntake(
        id: 100,
        dose: newDose,
        takenDateTime: DateTime.utc(2025, 9, 13, 8, 10),
      ));

      // Assert
      expect(
        provider.intakes.any((i) => i.takenDose == newDose),
        true,
      );
    });

    test('updateIntake updates an existing item', () async {
      // Arrange
      repo.insert(aMedicationIntake(id: 1));
      final intakeToUpdate = repo.items.first;
      final updatedIntake = aMedicationIntake(
        id: intakeToUpdate.id,
        dose: Decimal.parse('99.9'),
        takenDateTime: intakeToUpdate.takenDateTime,
      );

      // Act
      await provider.updateIntake(updatedIntake);

      // Assert
      final fetchedIntake =
          provider.intakes.firstWhere((i) => i.id == intakeToUpdate.id);
      expect(fetchedIntake.takenDose, Decimal.parse('99.9'));
    });

    test('deleteIntakeFromId removes the item', () async {
      // Arrange
      repo.insert(aMedicationIntake(id: 1));
      repo.insert(aMedicationIntake(id: 2));

      // Act
      await provider.deleteIntakeFromId(1);

      // Assert
      expect(
        [provider.intakes.length, provider.intakes.first.id],
        [1, 2],
      );
    });

    test('deleteIntake removes the item by object', () async {
      // Arrange
      repo.insert(aMedicationIntake(id: 1));
      repo.insert(aMedicationIntake(id: 2));
      final intakeToDelete = repo.items.first;

      // Act
      await provider.deleteIntake(intakeToDelete);

      // Assert
      expect(
        [provider.intakes.length, provider.intakes.first.id],
        [1, 2],
      );
    });

    test('takenIntakes and notTakenIntakes return correct subsets', () async {
      repo.insert(aMedicationIntake(id: 1));
      repo.insert(aMedicationIntake(id: 2, taken: false));
      await provider.fetchIntakes();
      expect(
        [provider.takenIntakes, provider.notTakenIntakes],
        [
          repo.items.where((i) => i.isTaken).toList(),
          repo.items.where((i) => !i.isTaken).toList()
        ],
      );
    });

    test('takenIntakesSortedDesc returns taken intakes sorted descending',
        () async {
      await provider.fetchIntakes();
      provider.add(aMedicationIntake(
          id: 100, takenDateTime: DateTime.utc(2025, 9, 14, 8, 10)));
      provider.add(aMedicationIntake(id: 101, taken: false));
      provider.add(aMedicationIntake(
          id: 102, takenDateTime: DateTime.utc(2025, 9, 16, 8, 10)));

      final sorted = provider.takenIntakesSortedDesc;

      expect(
        sorted.asMap().entries.every((entry) {
          final i = entry.key;
          final intake = entry.value;
          if (!intake.isTaken) return false;
          if (i < sorted.length - 1) {
            final next = sorted[i + 1];
            if (intake.takenDateTime!.isBefore(next.takenDateTime!)) {
              return false;
            }
          }
          return true;
        }),
        true,
      );

      provider.deleteIntakeFromId(100);
      provider.deleteIntakeFromId(101);
      provider.deleteIntakeFromId(102);
    });

    group('getTakenIntakesForSchedule', () {
      test('returns only taken intakes for the given schedule', () async {
        repo.insert(aMedicationIntake(scheduleId: 100));
        repo.insert(aMedicationIntake(scheduleId: 200));
        await provider.fetchIntakes();

        expect(provider.getTakenIntakesDescForSchedule(100).length, 1);
      });

      test('returns empty list if no taken intakes for schedule', () async {
        repo.insert(aMedicationIntake(scheduleId: 42));
        await provider.fetchIntakes();

        expect(provider.getTakenIntakesDescForSchedule(3), isEmpty);
      });
    });

    group('getLastIntakeDateFromList', () {
      test('returns null if the list is empty', () {
        final result = provider.getLastIntakeLocalDateFromList([]);
        expect(result, isNull);
      });

      test('returns the only takenDateTime if list has one intake', () {
        final intake =
            aMedicationIntake(takenDateTime: DateTime.utc(2025, 9, 12, 8, 15));

        final result = provider.getLastIntakeLocalDateFromList([intake]);
        expect(result, intake.takenLocalDate);
      });

      test('returns the latest takenDateTime if list has multiple intakes', () {
        final intake1 =
            aMedicationIntake(takenDateTime: DateTime.utc(2025, 9, 12, 8, 15));

        final intake2 =
            aMedicationIntake(takenDateTime: DateTime.utc(2025, 9, 12, 20, 10));

        final intake3 =
            aMedicationIntake(takenDateTime: DateTime.utc(2025, 9, 13, 8, 5));

        final result = provider
            .getLastIntakeLocalDateFromList([intake1, intake2, intake3]);
        expect(result, intake3.takenLocalDate);
      });

      test('handles intakes with same takenDateTime correctly', () {
        final dt = DateTime.utc(2025, 9, 12, 8, 0);
        final intake1 = aMedicationIntake(takenDateTime: dt);

        final intake2 = aMedicationIntake(takenDateTime: dt);

        final result =
            provider.getLastIntakeLocalDateFromList([intake1, intake2]);
        expect(result, intake1.takenLocalDate);
      });
    });

    group('getTakenIntakesForScheduleOn', () {
      test('returns only taken intakes for the given schedule on given date',
          () async {
        // Arrange
        repo.insert(aMedicationIntake(
            id: 100,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 13, 8, 15)));
        repo.insert(aMedicationIntake(
            id: 101,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 13, 20, 30)));
        repo.insert(aMedicationIntake(
            id: 102,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 14, 8, 15)));
        repo.insert(aMedicationIntake(
            id: 103,
            scheduleId: 99,
            takenDateTime: DateTime.utc(2025, 9, 13, 8, 15)));
        await provider.fetchIntakes();
        final targetDate = Date(year: 2025, month: 9, day: 13);

        // Act
        final result = provider.getTakenIntakesForScheduleOn(42, targetDate);

        // Assert
        expect(result.map((i) => i.id).toList(), [101, 100]);
      });

      test('returns empty list when no intakes match the date', () async {
        // Arrange
        repo.insert(aMedicationIntake(
            id: 100,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 13, 8, 15)));
        await provider.fetchIntakes();
        final otherDate = Date(year: 2025, month: 9, day: 14);

        // Act
        final result = provider.getTakenIntakesForScheduleOn(42, otherDate);

        // Assert
        expect(result, isEmpty);
      });

      test('returns empty list when no intakes match the schedule', () async {
        // Arrange
        repo.insert(aMedicationIntake(
            id: 100,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 13, 8, 15)));
        await provider.fetchIntakes();
        final targetDate = Date(year: 2025, month: 9, day: 13);

        // Act
        final result = provider.getTakenIntakesForScheduleOn(999, targetDate);

        // Assert
        expect(result, isEmpty);
      });
    });

    group('getLastTakenIntakeForSchedule', () {
      test('returns null when no taken intakes exist for schedule', () async {
        // Arrange
        repo.insert(aMedicationIntake(scheduleId: 42));
        await provider.fetchIntakes();

        // Act
        final result = provider.getLastTakenIntakeForSchedule(999);

        // Assert
        expect(result, isNull);
      });

      test('returns the only intake when schedule has a single taken intake',
          () async {
        // Arrange
        repo.insert(aMedicationIntake(
            id: 100,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 13, 8, 15)));
        await provider.fetchIntakes();

        // Act
        final result = provider.getLastTakenIntakeForSchedule(42);

        // Assert
        expect(result?.id, 100);
      });

      test('returns the latest taken intake among multiple for the schedule',
          () async {
        // Arrange
        repo.insert(aMedicationIntake(
            id: 100,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 12, 8, 15)));
        repo.insert(aMedicationIntake(
            id: 101,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 14, 20, 30)));
        repo.insert(aMedicationIntake(
            id: 102,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 13, 9, 0)));
        await provider.fetchIntakes();

        // Act
        final result = provider.getLastTakenIntakeForSchedule(42);

        // Assert
        expect(result?.id, 101);
      });

      test('ignores intakes belonging to other schedules', () async {
        // Arrange
        repo.insert(aMedicationIntake(
            id: 100,
            scheduleId: 42,
            takenDateTime: DateTime.utc(2025, 9, 12, 8, 15)));
        repo.insert(aMedicationIntake(
            id: 200,
            scheduleId: 99,
            takenDateTime: DateTime.utc(2025, 9, 20, 20, 30)));
        await provider.fetchIntakes();

        // Act
        final result = provider.getLastTakenIntakeForSchedule(42);

        // Assert
        expect(result?.id, 100);
      });
    });

    group('getLastTakenInjectionIntake', () {
      test('returns null when no taken intakes exist', () async {
        // Arrange
        await provider.fetchIntakes();

        // Act
        final result = provider.getLastTakenInjectionIntake();

        // Assert
        expect(result, isNull);
      });

      test('returns null when no injection intakes exist', () async {
        // Arrange
        repo.insert(aMedicationIntake());
        await provider.fetchIntakes();

        // Act
        final result = provider.getLastTakenInjectionIntake();

        // Assert
        expect(result, isNull);
      });

      test('returns the only injection intake', () async {
        // Arrange
        repo.insert(anInjection(
            id: 100, takenDateTime: DateTime.utc(2025, 9, 13, 8, 15)));
        await provider.fetchIntakes();

        // Act
        final result = provider.getLastTakenInjectionIntake();

        // Assert
        expect(result?.id, 100);
      });

      test('returns the latest injection among multiple injection intakes',
          () async {
        // Arrange
        repo.insert(anInjection(
            id: 100, takenDateTime: DateTime.utc(2025, 9, 12, 8, 15)));
        repo.insert(anInjection(
            id: 101, takenDateTime: DateTime.utc(2025, 9, 14, 20, 30)));
        repo.insert(anInjection(
            id: 102, takenDateTime: DateTime.utc(2025, 9, 13, 9, 0)));
        await provider.fetchIntakes();

        // Act
        final result = provider.getLastTakenInjectionIntake();

        // Assert
        expect(result?.id, 101);
      });

      test('ignores non-injection intakes even if they are more recent',
          () async {
        // Arrange
        repo.insert(anInjection(
            id: 100, takenDateTime: DateTime.utc(2025, 9, 12, 8, 15)));
        repo.insert(aMedicationIntake(
            id: 200, takenDateTime: DateTime.utc(2025, 9, 20, 8, 15)));
        await provider.fetchIntakes();

        // Act
        final result = provider.getLastTakenInjectionIntake();

        // Assert
        expect(result?.id, 100);
      });
    });

    group('graph intake pipeline', () {
      test('getFirstGraphIntakeInstant returns the earliest UTC instant',
          () async {
        // Arrange
        repo.insert(anInjection(
            id: 10, takenDateTime: DateTime.utc(2025, 6, 2, 20, 0)));
        repo.insert(anInjection(
            id: 11, takenDateTime: DateTime.utc(2025, 6, 1, 8, 30)));
        await provider.fetchIntakes();

        // Act
        final first = provider.getFirstGraphIntakeInstant();

        // Assert
        expect(first, DateTime.utc(2025, 6, 1, 8, 30));
      });

      test('getFirstGraphIntakeInstant is null when no plottable intakes',
          () async {
        // Arrange
        repo.insert(aMedicationIntake());
        await provider.fetchIntakes();

        // Act
        final first = provider.getFirstGraphIntakeInstant();

        // Assert
        expect(first, isNull);
      });

      test('getGraphLocalStart is at midnight in the local timezone', () async {
        // Arrange
        repo.insert(anInjection(
            id: 10, takenDateTime: DateTime.utc(2025, 6, 1, 8, 30)));
        await provider.fetchIntakes();

        // Act
        final start = provider.getGraphLocalStart()!;

        // Assert
        expect([start.hour, start.minute, start.second, start.millisecond],
            everyElement(0));
      });

      test('getGraphLocalStart lands on the first intake local day', () async {
        // Arrange
        repo.insert(anInjection(
            id: 10, takenDateTime: DateTime.utc(2025, 6, 2, 20, 0)));
        repo.insert(anInjection(
            id: 11, takenDateTime: DateTime.utc(2025, 6, 1, 8, 30)));
        await provider.fetchIntakes();

        // Act
        final start = provider.getGraphLocalStart()!;
        final firstLocal = provider.getFirstGraphIntakeInstant()!.toLocal();

        // Assert
        expect([start.year, start.month, start.day],
            [firstLocal.year, firstLocal.month, firstLocal.day]);
      });

      test('getGraphLocalStart never sits after the first intake', () async {
        // Arrange
        repo.insert(anInjection(
            id: 10, takenDateTime: DateTime.utc(2025, 6, 1, 8, 30)));
        await provider.fetchIntakes();

        // Act
        final start = provider.getGraphLocalStart()!;

        // Assert
        expect(start.isAfter(provider.getFirstGraphIntakeInstant()!), isFalse);
      });

      test('getGraphLocalStart is null when no plottable intakes', () async {
        // Arrange
        repo.insert(aMedicationIntake());
        await provider.fetchIntakes();

        // Act
        final start = provider.getGraphLocalStart();

        // Assert
        expect(start, isNull);
      });

      test('excludes non-injection intakes from the graph', () async {
        // Arrange
        repo.insert(aMedicationIntake());
        repo.insert(
            anInjection(id: 10, takenDateTime: DateTime.utc(2025, 6, 1, 8, 0)));
        await provider.fetchIntakes();
        final baseline = provider.getFirstGraphIntakeInstant()!;

        // Act
        final intakes = provider.getIntakesForGraph(baseline);

        // Assert
        expect(intakes.length, 1);
      });

      test('the baseline injection has offset zero', () async {
        // Arrange
        repo.insert(anInjection(
            id: 10, takenDateTime: DateTime.utc(2025, 6, 1, 23, 39)));
        await provider.fetchIntakes();
        final baseline = provider.getFirstGraphIntakeInstant()!;

        // Act
        final intakes = provider.getIntakesForGraph(baseline);

        // Assert
        expect(intakes.single.time, closeTo(0.0, 1e-9));
      });

      test('a later injection gets its exact fractional offset', () async {
        // Arrange: 12h after the baseline -> 0.5 days
        repo.insert(anInjection(
            id: 10, takenDateTime: DateTime.utc(2025, 6, 1, 23, 39)));
        repo.insert(anInjection(
            id: 11, takenDateTime: DateTime.utc(2025, 6, 2, 11, 39)));
        await provider.fetchIntakes();
        final baseline = provider.getFirstGraphIntakeInstant()!;

        // Act
        final intakes = provider.getIntakesForGraph(baseline);

        // Assert
        expect(intakes[1].time, closeTo(0.5, 1e-9));
      });
    });

    group('firstTakenLocalDate', () {
      test('returns null when there are no taken intakes', () async {
        // Arrange
        repo.insert(aMedicationIntake(taken: false));
        await provider.fetchIntakes();

        // Act
        final result = provider.firstTakenLocalDate;

        // Assert
        expect(result, isNull);
      });

      test('returns the local date of the earliest taken intake', () async {
        // Arrange
        repo.insert(aMedicationIntake(
            id: 100, takenDateTime: DateTime.utc(2025, 1, 5, 8, 0)));
        repo.insert(aMedicationIntake(
            id: 101, takenDateTime: DateTime.utc(2025, 3, 20, 8, 0)));
        await provider.fetchIntakes();

        // Act
        final result = provider.firstTakenLocalDate;

        // Assert
        expect(result, Date(year: 2025, month: 1, day: 5));
      });
    });
  });
}
