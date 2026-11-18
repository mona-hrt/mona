import 'dart:math' as math;
import 'package:mona/data/model/blood_test.dart';

enum LabExclusion { notExact, notPositive, lowModel }

class RatioCalibration {
  final double factor;
  final List<BloodTest> used;
  final List<BloodTest> excluded;
  RatioCalibration(this.factor, this.used, this.excluded);
}

RatioCalibration fitRatio(
    List<BloodTest> labs, // same unit as model
    double Function(DateTime t) level, // level at day t
    {required double minModel,
    double lambda = 0.2}) {
  var rSum = 0.0;

  for (final lab in usableLabs(labs, minModel)) {
    rSum +=
        math.log(lab.estradiolLevels!.value.toDouble() / level(lab.dateTime));
  }
  final lnfactor = rSum / (usableLabsCount(labs, minModel) + lambda);
  final factor = math.exp(lnfactor).clamp(0.1, 10.0);
  return RatioCalibration(
      factor, usableLabs(labs, minModel), excludedLabs(labs, minModel));
}

bool isUsable(BloodTest test, double minModel) =>
    test.estradiolLevels != null &&
    test.estradiolLevels!.value.toDouble() > minModel;

List<BloodTest> usableLabs(List<BloodTest> bloodTests, double minModel) =>
    bloodTests.where((test) => isUsable(test, minModel)).toList();

List<BloodTest> excludedLabs(List<BloodTest> bloodTests, double minModel) =>
    bloodTests.where((test) => !isUsable(test, minModel)).toList();

int usableLabsCount(List<BloodTest> bloodTests, double minModel) =>
    usableLabs(bloodTests, minModel).length;
