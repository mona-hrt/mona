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
import 'package:mona/ui/views/levels/chart_time_axis.dart';

extension GraphBloodTestLookup on List<GraphBloodTest> {
  ValueComparison comparisonAt(double offset) =>
      firstWhereOrNull((test) => chartX(test.dateTime) == offset)?.comparison ??
      ValueComparison.equal;
}

class GraphCalculator {
  double totalConcentrationAtTime(
      DateTime t, List<MedicationIntake> intakes, EstradiolUnit unit) {
    if (intakes.isEmpty) return 0.0;

    return _levelAt(
        HormoneSimulation(intakes, defaultInjectionParams), t, unit);
  }

  List<FlSpot> generateLevelsSpots(
      List<MedicationIntake> intakes, EstradiolUnit unit,
      {required DateTime tMin, required DateTime tMax, int numPoints = 1000}) {
    if (intakes.isEmpty) return <FlSpot>[];

    final simulation = HormoneSimulation(intakes, defaultInjectionParams);
    final List<math.Point> points = [];

    for (int i = 0; i <= numPoints; i++) {
      final t = tMin.add(tMax.difference(tMin) * (i / numPoints));
      points.add(math.Point(chartX(t), _levelAt(simulation, t, unit)));
    }

    return points.map((p) => FlSpot(p.x.toDouble(), p.y.toDouble())).toList();
  }

  double _levelAt(
      HormoneSimulation simulation, DateTime t, EstradiolUnit unit) {
    final concentration = simulation.levelAt(Hormone.estradiol, t);
    return EstradiolUnit.pg_mL
        .convert(Decimal.parse(concentration.toString()), unit)
        .toDouble();
  }

  List<FlSpot> generateBloodSpots(List<GraphBloodTest> bloodTests,
      {required DateTime tMin, required DateTime tMax}) {
    if (bloodTests.isEmpty) return <FlSpot>[];

    return bloodTests
        .where((bloodTest) =>
            !bloodTest.dateTime.isBefore(tMin) &&
            !bloodTest.dateTime.isAfter(tMax))
        .map((bloodTest) => FlSpot(chartX(bloodTest.dateTime), bloodTest.level))
        .toList();
  }
}
