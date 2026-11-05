// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Alice Lorido "yakissa" <alice@lori.do>
// SPDX-FileContributor: alix "a1ix2"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:math' as math;

import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/pk/injection_params.dart';

class GraphIntake {
  final double dose;
  final Ester ester;
  final double time; // in days

  const GraphIntake({
    required this.dose,
    required this.ester,
    required this.time,
  });
}

const double _inactiveWindow = 365.0;

/// Level in pg/mL, [elapsed] days after one injection of [dose] mg.
double singleInjectionConcentration(
    InjectionParams params, double dose, double elapsed) {
  if (elapsed <= 0 || elapsed >= _inactiveWindow) return 0.0;

  final InjectionParams(:f, :auc, :k1, :k2, :k3) = params;

  final part1 = math.exp(-k1 * elapsed) / ((k1 - k2) * (k1 - k3));
  final part2 = math.exp(-k2 * elapsed) / ((k1 - k2) * (k2 - k3));
  final part3 = math.exp(-k3 * elapsed) / ((k1 - k3) * (k2 - k3));

  return dose * f * auc * k1 * k2 * k3 * (part1 - part2 + part3);
}

class Simulation {
  final List<GraphIntake> intakes;
  final Map<Ester, InjectionParams> params;

  const Simulation(this.intakes, this.params);

  /// Estradiol level in pg/mL at day [t].
  double levelAt(double t) => intakes
      .map((intake) => singleInjectionConcentration(
          params[intake.ester]!, intake.dose, t - intake.time))
      .fold(0.0, (sum, val) => sum + val);
}
