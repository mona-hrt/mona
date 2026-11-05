// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Alice Lorido "yakissa" <alice@lori.do>
// SPDX-FileContributor: alix "a1ix2"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mona/data/model/pk/injection_params.dart';
import 'package:mona/data/model/pk/simulation.dart';
import 'package:mona/data/model/units.dart';

class GraphBloodTest {
  final double level;
  final double offset;
  final ValueComparison comparison;

  const GraphBloodTest({
    required this.level,
    required this.offset,
    this.comparison = ValueComparison.equal,
  });
}

extension GraphBloodTestLookup on List<GraphBloodTest> {
  ValueComparison comparisonAt(double offset) =>
      firstWhereOrNull((test) => test.offset == offset)?.comparison ??
      ValueComparison.equal;
}

class GraphCalculator {
  static const double tMaxOffset = 40.0;

  double totalConcentrationAtTime(
      double t, List<GraphIntake> intakes, EstradiolUnit unit) {
    if (intakes.isEmpty) return 0.0;

    final concentration =
        Simulation(intakes, defaultInjectionParams).levelAt(t);
    return EstradiolUnit.pg_mL
        .convert(Decimal.parse(concentration.toString()), unit)
        .toDouble();
  }

  List<FlSpot> generateLevelsSpots(
      List<GraphIntake> intakes, EstradiolUnit unit,
      {double tMin = 0, double? tMax, int numPoints = 1000}) {
    if (intakes.isEmpty) return <FlSpot>[];

    tMax ??= intakes.map((i) => i.time).reduce(math.max) + tMaxOffset;
    final List<math.Point> points = [];

    for (int i = 0; i <= numPoints; i++) {
      final t = tMin + ((tMax - tMin) / numPoints) * i;
      final concentration = totalConcentrationAtTime(t, intakes, unit);
      points.add(math.Point(t, concentration));
    }

    return points.map((p) => FlSpot(p.x.toDouble(), p.y.toDouble())).toList();
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
