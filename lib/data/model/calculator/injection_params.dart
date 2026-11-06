// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: alix "a1ix2"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:mona/data/model/ester.dart';

class InjectionParams {
  final double f;
  final double auc;
  final double k1;
  final double k2;
  final double k3;

  const InjectionParams({
    required this.f,
    required this.auc,
    required this.k1,
    required this.k2,
    required this.k3,
  });
}

// Inferred with love exclusively for Mona
//                - alix, WHSAH Collective
const Map<Ester, InjectionParams> defaultInjectionParams = {
  Ester.enanthate: InjectionParams(
    f: 0.708,
    auc: 875.4,
    k1: 0.09441,
    k2: 3.354,
    k3: 0.4078,
  ),
  Ester.valerate: InjectionParams(
    f: 0.764,
    auc: 621.3,
    k1: 0.2230,
    k2: 17.62,
    k3: 1.305,
  ),
  Ester.benzoate: InjectionParams(
    f: 0.723,
    auc: 889.9,
    k1: 0.5220,
    k2: 521.9,
    k3: 5.223,
  ),
  Ester.cypionate: InjectionParams(
    f: 0.687,
    auc: 554.5,
    k1: 0.0880,
    k2: 17.95,
    k3: 0.7177,
  ),
  Ester.cypionateSuspension: InjectionParams(
    f: 0.687,
    auc: 852.6,
    k1: 0.0973,
    k2: 218.67,
    k3: 6.624,
  ),
  Ester.undecylate: InjectionParams(
    f: 0.618,
    auc: 385.8,
    k1: 0.02189,
    k2: 183.4,
    k3: 1.564,
  ),
};
