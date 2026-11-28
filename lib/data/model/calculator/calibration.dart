// SPDX-FileCopyrightText: 2026 Alice Lorido "yakissa" <alice@lori.do>
// SPDX-FileContributor: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:math' as math;
import 'package:mona/data/model/blood_test.dart';
import 'package:mona/data/model/units.dart';

enum LabExclusion { notExact, notPositive, lowModel }

class RatioCalibration {
  final double factor;
  final List<BloodTest> used;
  final List<(BloodTest, LabExclusion)> excluded;
  RatioCalibration(this.factor, this.used, this.excluded);
}

RatioCalibration fitRatio(
    List<BloodTest> labs, double Function(DateTime t) level, // pg/mL
    {required double minModel,
    double lambda = 0.2}) {
  var rSum = 0.0;

  for (final lab in usableLabs(labs, minModel)) {
    final value = lab.estradiolLevels!.inUnit(EstradiolUnit.pg_mL).toDouble();
    rSum += math.log(value / level(lab.dateTime));
  }
  final lnfactor = rSum / (usableLabsCount(labs, minModel) + lambda);
  final factor = math.exp(lnfactor).clamp(0.1, 10.0);
  return RatioCalibration(
      factor, usableLabs(labs, minModel), excludedLabs(labs, minModel));
}

bool isUsable(BloodTest test, double minModel) =>
    test.estradiolLevels != null &&
    test.estradiolLevels!.inUnit(EstradiolUnit.pg_mL).toDouble() > minModel &&
    test.estradiolLevels!.inUnit(EstradiolUnit.pg_mL).toDouble() >= 0.0 &&
    test.estradiolLevels!.comparison != ValueComparison.equal;

LabExclusion labExclusion(BloodTest test, double minModel) {
  if (test.estradiolLevels == null) {
    return LabExclusion.notExact;
  }
  final value = test.estradiolLevels!.inUnit(EstradiolUnit.pg_mL).toDouble();
  if (value < minModel) {
    return LabExclusion.lowModel;
  }
  if (value < 0.0 ||
      test.estradiolLevels!.comparison == ValueComparison.equal) {
    return LabExclusion.notPositive;
  }
  return LabExclusion.notExact;
}

List<BloodTest> usableLabs(List<BloodTest> bloodTests, double minModel) =>
    bloodTests.where((test) => isUsable(test, minModel)).toList();

List<(BloodTest, LabExclusion)> excludedLabs(
        List<BloodTest> bloodTests, double minModel) =>
    bloodTests
        .where((test) => !isUsable(test, minModel))
        .map((test) => (test, labExclusion(test, minModel)))
        .toList();

int usableLabsCount(List<BloodTest> bloodTests, double minModel) =>
    usableLabs(bloodTests, minModel).length;
