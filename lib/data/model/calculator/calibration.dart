import 'dart:math' as math;
import 'package:mona/data/model/blood_test.dart';

class RatioCalibration {
  final double factor;
  final List<BloodTest> used;
  RatioCalibration(this.factor, this.used);
}

RatioCalibration fitRatio(
    List<BloodTest> labs, // same unit as model
    double Function(DateTime t) level, // level at day t
    {required double minModel,
    double lambda = 0.2}) {
  var rSum = 0.0;

  for (final lab in usableLabs(labs)) {
    rSum +=
        math.log(lab.estradiolLevels!.value.toDouble() / level(lab.dateTime));
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
