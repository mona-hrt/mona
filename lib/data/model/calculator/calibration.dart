// SPDX-FileCopyrightText: 2026 Alice Lorido "yakissa" <alice@lori.do>
// SPDX-FileContributor: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:math' as math;
import 'package:mona/data/model/blood_test.dart';
import 'package:mona/data/model/units.dart';

class RatioCalibration {
  final double factor;
  final List<BloodTest> used;
  RatioCalibration(this.factor, this.used);
}

RatioCalibration fitRatio(
    List<BloodTest> labs, // converted to pg/mL
    double Function(DateTime t) level, // pg/mL
    {required double minModel,
    double lambda = 0.2}) {
  var rSum = 0.0;

  for (final lab in usableLabs(labs)) {
    final value = lab.estradiolLevels!.inUnit(EstradiolUnit.pg_mL).toDouble();
    rSum += math.log(value / level(lab.dateTime));
  }
  final lnfactor = rSum / (usableLabsCount(labs) + lambda);
  final factor = math.exp(lnfactor).clamp(0.1, 10.0);
  return RatioCalibration(factor, usableLabs(labs));
}

bool isUsable(BloodTest test) => test.estradiolLevels != null;

List<BloodTest> usableLabs(List<BloodTest> bloodTests) =>
    bloodTests.where(isUsable).toList();

int usableLabsCount(List<BloodTest> bloodTests) =>
    usableLabs(bloodTests).length;
