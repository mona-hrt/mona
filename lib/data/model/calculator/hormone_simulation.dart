// SPDX-FileCopyrightText: Alice Lorido "yakissa" <alice@lori.do>
// SPDX-FileContributor: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: alix "a1ix2"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:math' as math;

import 'package:mona/data/model/calculator/injection_params.dart';
import 'package:mona/data/model/ester.dart';

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
const double _equalRatesThreshold = 1e-8;

/// Level in pg/mL, [elapsed] days after one injection of [dose] mg.
double singleInjectionConcentration(
    InjectionParams params, double dose, double elapsed) {
  if (elapsed <= 0 || elapsed >= _inactiveWindow) return 0.0;

  final InjectionParams(:f, :auc, :k1, :k2, :k3) = params;

  final sum = _batemanSum(k1, k2, k3, elapsed);
  return dose * f * auc * k1 * k2 * k3 * sum;
}

/// Bateman sum S for the chain [k1] -> [k2] -> [k3], with t = [elapsed].
double _batemanSum(double k1, double k2, double k3, double elapsed) {
  bool equal(double a, double b) =>
      (a - b).abs() * elapsed <= _equalRatesThreshold;

  final k1k2 = equal(k1, k2);
  final k1k3 = equal(k1, k3);
  final k2k3 = equal(k2, k3);

  if ((k1k2 && k1k3) || (k1k2 && k2k3) || (k1k3 && k2k3)) {
    return _equalRatesLimit(k1, elapsed);
  }
  if (k1k2) return _repeatedRateLimit(k1, k3, elapsed);
  if (k1k3) return _repeatedRateLimit(k1, k2, elapsed);
  if (k2k3) return _repeatedRateLimit(k2, k1, elapsed);

  return _distinctRatesSum(k1, k2, k3, elapsed);
}

// k1, k2 -> k3 = k:  S -> t² e^(−k t) / 2
double _equalRatesLimit(double k, double elapsed) =>
    elapsed * elapsed * math.exp(-k * elapsed) / 2;

// limit of S at rates r, r and s, with r = [repeated] and s = [other]
// S -> (e^(−s t) + e^(−r t) ((s − r) t − 1)) / (s − r)²
double _repeatedRateLimit(double repeated, double other, double elapsed) {
  final gap = other - repeated;
  return (math.exp(-other * elapsed) +
          math.exp(-repeated * elapsed) * (gap * elapsed - 1)) /
      (gap * gap);
}

double _distinctRatesSum(double k1, double k2, double k3, double elapsed) {
  final part1 = math.exp(-k1 * elapsed) / ((k1 - k2) * (k1 - k3));
  final part2 = math.exp(-k2 * elapsed) / ((k1 - k2) * (k2 - k3));
  final part3 = math.exp(-k3 * elapsed) / ((k1 - k3) * (k2 - k3));

  return part1 - part2 + part3;
}

class HormoneSimulation {
  final List<GraphIntake> intakes;
  final Map<Ester, InjectionParams> params;

  const HormoneSimulation(this.intakes, this.params);

  /// Estradiol level in pg/mL at day [t].
  double levelAt(double t) => intakes
      .map((intake) => singleInjectionConcentration(
          params[intake.ester]!, intake.dose, t - intake.time))
      .fold(0.0, (sum, val) => sum + val);
}
