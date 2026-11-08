// SPDX-FileCopyrightText: Alice Lorido "yakissa" <alice@lori.do>
// SPDX-FileContributor: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: alix "a1ix2"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mona/data/model/calculator/hormone_simulation.dart';
import 'package:mona/data/model/calculator/injection_params.dart';
import 'package:mona/data/model/graph_blood_test.dart';
import 'package:mona/data/model/hormone.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/units.dart';

extension GraphBloodTestLookup on List<GraphBloodTest> {
  ValueComparison comparisonAt(double offset) =>
      firstWhereOrNull((test) => test.offset == offset)?.comparison ??
      ValueComparison.equal;
}

class GraphCalculator {
  double totalConcentrationAtTime(double t, List<MedicationIntake> intakes,
      DateTime origin, EstradiolUnit unit) {
    if (intakes.isEmpty) return 0.0;

    return _levelAt(
        HormoneSimulation(intakes, defaultInjectionParams, origin), t, unit);
  }

  List<FlSpot> generateLevelsSpots(
      List<MedicationIntake> intakes, DateTime origin, EstradiolUnit unit,
      {double tMin = 0, required double tMax, int numPoints = 1000}) {
    if (intakes.isEmpty) return <FlSpot>[];

    final simulation =
        HormoneSimulation(intakes, defaultInjectionParams, origin);
    final List<math.Point> points = [];

    for (int i = 0; i <= numPoints; i++) {
      final t = tMin + ((tMax - tMin) / numPoints) * i;
      points.add(math.Point(t, _levelAt(simulation, t, unit)));
    }

    return points.map((p) => FlSpot(p.x.toDouble(), p.y.toDouble())).toList();
  }

  double _levelAt(HormoneSimulation simulation, double t, EstradiolUnit unit) {
    final concentration = simulation.levelAt(Hormone.estradiol, t);
    return EstradiolUnit.pg_mL
        .convert(Decimal.parse(concentration.toString()), unit)
        .toDouble();
  }

  List<FlSpot> generateBloodSpots(List<GraphBloodTest> bloodTests,
      {double tMin = double.negativeInfinity, double tMax = double.infinity}) {
    if (bloodTests.isEmpty) return <FlSpot>[];

    return bloodTests
        .where(
            (bloodTest) => bloodTest.offset >= tMin && bloodTest.offset <= tMax)
        .map((bloodTest) => FlSpot(bloodTest.offset, bloodTest.level))
        .toList();
  }
}
