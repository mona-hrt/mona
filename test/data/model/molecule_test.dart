// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/molecule.dart';

void main() {
  group('Molecule', () {
    test('normalizedName trims spaces and lowercases', () {
      // Arrange
      final molecule = Molecule(name: '  TestMol  ', massUnit: 'mg');

      // Act
      final normalizedName = molecule.normalizedName;

      // Assert
      expect(normalizedName, 'testmol');
    });
  });
}
