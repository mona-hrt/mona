import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/medication_schedule.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import '../../fixtures.dart';
import 'generic_repository_mock.dart';

void main() {
  late MedicationScheduleProvider provider;
  late GenericRepositoryMock<MedicationSchedule> repo;

  setUp(() {
    repo = GenericRepositoryMock<MedicationSchedule>(
      withId: (i, id) => i.copyWith(id: id),
    );
    provider = MedicationScheduleProvider(repository: repo);

    repo.insert(aMedicationSchedule(id: 1));
    repo.insert(aMedicationSchedule(id: 2));
  });

  group('MedicationScheduleProvider Tests', () {
    test('initialization loads schedules', () async {
      await provider.fetchSchedules();
      expect(provider.schedules.length, repo.items.length);
    });

    test('add inserts a new schedule', () async {
      // Arrange
      final schedule = aMedicationSchedule(id: 3);

      // Act
      await provider.add(schedule);

      // Assert
      expect(provider.schedules, contains(schedule));
    });

    test('updateSchedule updates an existing item', () async {
      // Arrange
      final scheduleToUpdate = repo.items.first;
      final updatedSchedule =
          scheduleToUpdate.copyWith(dose: Decimal.parse('5.0'));

      // Act
      await provider.updateSchedule(updatedSchedule);

      // Assert
      expect(provider.schedules.first.dose, Decimal.parse('5.0'));
    });

    test('deleteScheduleFromId removes the item', () async {
      // Act
      await provider.deleteScheduleFromId(1);

      // Assert
      expect(
        [provider.schedules.length, provider.schedules.first.id],
        [1, 2],
      );
    });

    test('deleteSchedule removes the item by object', () async {
      // Arrange
      final scheduleToDelete = repo.items.first;

      // Act
      await provider.deleteSchedule(scheduleToDelete);

      // Assert
      expect(
        [provider.schedules.length, provider.schedules.first.id],
        [1, 2],
      );
    });
  });
}
