import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/dosing_basis.dart';
import 'package:mona/i18n/helpers/medication_schedule_l10n.dart';

import '../fixtures.dart';

void main() {
  group('MedicationScheduleL10n localizedSummary', () {
    final cases = [
      (DosingBasis.mass, 'mg'),
      (DosingBasis.releaseRate, 'µg/day'),
    ];

    for (final (basis, expectedUnit) in cases) {
      test('$basis uses the "$expectedUnit" unit', () {
        // Arrange
        final schedule = aMedicationSchedule(
          administrationRoute: AdministrationRoute.patch,
          dosingBasis: basis,
        );

        // Act
        final summary = schedule.localizedSummary;

        // Assert
        expect(summary, contains(expectedUnit));
      });
    }
  });
}
