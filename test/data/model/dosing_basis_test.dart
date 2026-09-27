import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/dosing_basis.dart';
import 'package:mona/data/model/molecule.dart';

void main() {
  group('supportsReleaseRate', () {
    final cases = [
      (KnownMolecules.estradiol, AdministrationRoute.patch, true),
      (KnownMolecules.estradiol, AdministrationRoute.oral, false),
      (KnownMolecules.progesterone, AdministrationRoute.patch, false),
    ];

    for (final (molecule, route, expected) in cases) {
      test('${molecule.name} on ${route.name} route is $expected', () {
        // Act
        final result = supportsReleaseRate(molecule, route);

        // Assert
        expect(result, expected);
      });
    }
  });
}
