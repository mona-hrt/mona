enum MoleculeUnit {
  mg;

  factory MoleculeUnit.fromJson(Object? value) {
    if (value is String) {
      for (final unit in MoleculeUnit.values) {
        if (unit.name == value) return unit;
      }
    }
    return MoleculeUnit.mg;
  }

  String toJson() => name;
}

class Molecule {
  final String name;
  final MoleculeUnit unit;

  const Molecule({
    required this.name,
    required this.unit,
  });

  factory Molecule.fromJson(Map<String, dynamic> json) {
    return Molecule(
      name: json['name'],
      unit: MoleculeUnit.fromJson(json['unit']),
    );
  }

  String get normalizedName => name.trim().toLowerCase();

  Map<String, dynamic> toJson() => {
        'name': name,
        'unit': unit.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Molecule &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class KnownMolecules {
  // Estrogens
  static const estradiol = Molecule(name: 'estradiol', unit: MoleculeUnit.mg);

  // Progestogens
  static const progesterone =
      Molecule(name: 'progesterone', unit: MoleculeUnit.mg);

  // Androgens
  static const testosterone =
      Molecule(name: 'testosterone', unit: MoleculeUnit.mg);
  static const nandrolone = Molecule(name: 'nandrolone', unit: MoleculeUnit.mg);
  static const dihydrotestosterone =
      Molecule(name: 'dihydrotestosterone', unit: MoleculeUnit.mg);

  // Anti-androgens
  static const spironolactone =
      Molecule(name: 'spironolactone', unit: MoleculeUnit.mg);
  static const cyproteroneAcetate =
      Molecule(name: 'cyproterone acetate', unit: MoleculeUnit.mg);
  static const leuprorelinAcetate =
      Molecule(name: 'leuprorelin acetate', unit: MoleculeUnit.mg);
  static const bicalutamide =
      Molecule(name: 'bicalutamide', unit: MoleculeUnit.mg);
  static const decapeptyl = Molecule(name: 'decapeptyl', unit: MoleculeUnit.mg);

  // SERMs
  static const raloxifene = Molecule(name: 'Raloxifene', unit: MoleculeUnit.mg);
  static const tamoxifen = Molecule(name: 'Tamoxifen', unit: MoleculeUnit.mg);

  // Other
  static const finasteride =
      Molecule(name: 'finasteride', unit: MoleculeUnit.mg);
  static const dutasteride =
      Molecule(name: 'dutasteride', unit: MoleculeUnit.mg);
  static const minoxidil = Molecule(name: 'minoxidil', unit: MoleculeUnit.mg);
  static const pioglitazone =
      Molecule(name: 'pioglitazone', unit: MoleculeUnit.mg);

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
