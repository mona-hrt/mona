// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter_test/flutter_test.dart';
import 'package:mona/util/timezone_location.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;

void main() {
  setUpAll(tzdata.initializeTimeZones);

  test('known IANA id returns that location', () {
    final loc = timeZoneLocation('Europe/Paris');
    expect(loc.name, 'Europe/Paris');
  });

  test('unknown id falls back to Etc/UTC', () {
    final loc = timeZoneLocation('Not/ARealZone');
    expect(loc.name, 'Etc/UTC');
  });
}
