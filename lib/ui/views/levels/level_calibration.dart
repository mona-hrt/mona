import 'package:mona/data/model/blood_test.dart';
import 'package:mona/data/model/calculator/calibration.dart';
import 'package:mona/data/model/calculator/hormone_simulation.dart';
import 'package:mona/data/model/calculator/injection_params.dart';
import 'package:mona/data/model/hormone.dart';
import 'package:mona/data/model/medication_intake.dart';

double calculateFactor(List<BloodTest> labs, List<MedicationIntake> intakes) {
  final simulation = HormoneSimulation(intakes, defaultInjectionParams);
  return fitRatio(labs, (t) => simulation.levelAt(Hormone.estradiol, t),
          minModel: 0.0)
      .factor;
}
