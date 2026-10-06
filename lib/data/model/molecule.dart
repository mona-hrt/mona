import 'package:dart_mappable/dart_mappable.dart';

part 'molecule.mapper.dart';

@MappableClass(
  generateMethods: GenerateMethods.all,
)
class Molecule with MoleculeMappable {
  final String name;
  final String massUnit;
  final String? rateUnit;

  const Molecule({
    required this.name,
    required this.massUnit,
    this.rateUnit,
  });

  String get normalizedName => name.trim().toLowerCase();
}

class KnownMolecules {
  // Estrogens
  static const estradiol =
      Molecule(name: 'estradiol', massUnit: 'mg', rateUnit: 'µg/day');

  // Progestogens
  static const progesterone = Molecule(name: 'progesterone', massUnit: 'mg');

  // Androgens
  static const testosterone = Molecule(name: 'testosterone', massUnit: 'mg');
  static const nandrolone = Molecule(name: 'nandrolone', massUnit: 'mg');
  static const dihydrotestosterone =
      Molecule(name: 'dihydrotestosterone', massUnit: 'mg');

  // Anti-androgens
  static const spironolactone =
      Molecule(name: 'spironolactone', massUnit: 'mg');
  static const cyproteroneAcetate =
      Molecule(name: 'cyproterone acetate', massUnit: 'mg');
  static const leuprorelinAcetate =
      Molecule(name: 'leuprorelin acetate', massUnit: 'mg');
  static const bicalutamide = Molecule(name: 'bicalutamide', massUnit: 'mg');
  static const decapeptyl = Molecule(name: 'decapeptyl', massUnit: 'mg');

  // SERMs
  static const raloxifene = Molecule(name: 'Raloxifene', massUnit: 'mg');
  static const tamoxifen = Molecule(name: 'Tamoxifen', massUnit: 'mg');

  // Other
  static const finasteride = Molecule(name: 'finasteride', massUnit: 'mg');
  static const dutasteride = Molecule(name: 'dutasteride', massUnit: 'mg');
  static const minoxidil = Molecule(name: 'minoxidil', massUnit: 'mg');
  static const pioglitazone = Molecule(name: 'pioglitazone', massUnit: 'mg');

  static const all = [
    estradiol,
    progesterone,
    testosterone,
    nandrolone,
    dihydrotestosterone,
    spironolactone,
    cyproteroneAcetate,
    leuprorelinAcetate,
    bicalutamide,
    decapeptyl,
    raloxifene,
    tamoxifen,
    finasteride,
    dutasteride,
    minoxidil,
    pioglitazone,
  ];
}
