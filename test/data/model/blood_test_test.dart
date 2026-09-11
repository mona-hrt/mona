import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/blood_test.dart';

void main() {
  group('BloodTest', () {
    test('constructor throws if dateTime is not UTC', () {
      // Arrange
      final localDateTime = DateTime(2024, 1, 1);

      // Act & Assert
      expect(
        () => BloodTest(
          id: 1,
          dateTime: localDateTime,
          timeZone: 'Etc/UTC',
        ),
        throwsArgumentError,
      );
    });
  });
}
