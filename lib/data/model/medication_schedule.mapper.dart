// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medication_schedule.dart';

class MedicationScheduleMapper extends ClassMapperBase<MedicationSchedule> {
  MedicationScheduleMapper._();

  static MedicationScheduleMapper? _instance;
  static MedicationScheduleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicationScheduleMapper._());
      IntervalDaysScheduleMapper.ensureInitialized();
      DailyScheduleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MedicationSchedule';

  static int _$id(MedicationSchedule v) => v.id;
  static const Field<MedicationSchedule, int> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String _$name(MedicationSchedule v) => v.name;
  static const Field<MedicationSchedule, String> _f$name = Field(
    'name',
    _$name,
  );
  static Decimal _$dose(MedicationSchedule v) => v.dose;
  static const Field<MedicationSchedule, Decimal> _f$dose = Field(
    'dose',
    _$dose,
  );
  static Date _$startDate(MedicationSchedule v) => v.startDate;
  static const Field<MedicationSchedule, Date> _f$startDate = Field(
    'startDate',
    _$startDate,
    opt: true,
  );
  static Molecule _$molecule(MedicationSchedule v) => v.molecule;
  static const Field<MedicationSchedule, Molecule> _f$molecule = Field(
    'molecule',
    _$molecule,
    key: r'moleculeJson',
  );
  static AdministrationRoute _$administrationRoute(MedicationSchedule v) =>
      v.administrationRoute;
  static const Field<MedicationSchedule, AdministrationRoute>
      _f$administrationRoute = Field(
    'administrationRoute',
    _$administrationRoute,
    key: r'administrationRouteName',
  );
  static Ester? _$ester(MedicationSchedule v) => v.ester;
  static const Field<MedicationSchedule, Ester> _f$ester = Field(
    'ester',
    _$ester,
    key: r'esterName',
    opt: true,
  );
  static List<TimeOfDay> _$notificationTimes(MedicationSchedule v) =>
      v.notificationTimes;
  static const Field<MedicationSchedule, List<TimeOfDay>> _f$notificationTimes =
      Field('notificationTimes', _$notificationTimes);

  @override
  final MappableFields<MedicationSchedule> fields = const {
    #id: _f$id,
    #name: _f$name,
    #dose: _f$dose,
    #startDate: _f$startDate,
    #molecule: _f$molecule,
    #administrationRoute: _f$administrationRoute,
    #ester: _f$ester,
    #notificationTimes: _f$notificationTimes,
  };

  static MedicationSchedule _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'MedicationSchedule',
      'type',
      '${data.value['type']}',
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MedicationSchedule fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicationSchedule>(map);
  }

  static MedicationSchedule fromJson(String json) {
    return ensureInitialized().decodeJson<MedicationSchedule>(json);
  }
}

mixin MedicationScheduleMappable {
  String toJson();
  Map<String, dynamic> toMap();
  MedicationScheduleCopyWith<MedicationSchedule, MedicationSchedule,
      MedicationSchedule> get copyWith;
}

abstract class MedicationScheduleCopyWith<$R, $In extends MedicationSchedule,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TimeOfDay, ObjectCopyWith<$R, TimeOfDay, TimeOfDay>>
      get notificationTimes;
  $R call({
    int? id,
    String? name,
    Decimal? dose,
    Date? startDate,
    Molecule? molecule,
    AdministrationRoute? administrationRoute,
    Ester? ester,
    List<TimeOfDay>? notificationTimes,
  });
  MedicationScheduleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class IntervalDaysScheduleMapper
    extends SubClassMapperBase<IntervalDaysSchedule> {
  IntervalDaysScheduleMapper._();

  static IntervalDaysScheduleMapper? _instance;
  static IntervalDaysScheduleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntervalDaysScheduleMapper._());
      MedicationScheduleMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals.useAll([
        MoleculeJsonMapper(),
        AdministrationRouteNameMapper(),
        EsterNameMapper(),
        DecimalStringMapper(),
        DateStringMapper(),
        TimeOfDayStringMapper(),
        JsonListMapper<TimeOfDay>(),
      ]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntervalDaysSchedule';

  static int _$id(IntervalDaysSchedule v) => v.id;
  static const Field<IntervalDaysSchedule, int> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String _$name(IntervalDaysSchedule v) => v.name;
  static const Field<IntervalDaysSchedule, String> _f$name = Field(
    'name',
    _$name,
  );
  static Decimal _$dose(IntervalDaysSchedule v) => v.dose;
  static const Field<IntervalDaysSchedule, Decimal> _f$dose = Field(
    'dose',
    _$dose,
  );
  static int _$intervalDays(IntervalDaysSchedule v) => v.intervalDays;
  static const Field<IntervalDaysSchedule, int> _f$intervalDays = Field(
    'intervalDays',
    _$intervalDays,
  );
  static Date _$startDate(IntervalDaysSchedule v) => v.startDate;
  static const Field<IntervalDaysSchedule, Date> _f$startDate = Field(
    'startDate',
    _$startDate,
    opt: true,
  );
  static Molecule _$molecule(IntervalDaysSchedule v) => v.molecule;
  static const Field<IntervalDaysSchedule, Molecule> _f$molecule = Field(
    'molecule',
    _$molecule,
    key: r'moleculeJson',
  );
  static AdministrationRoute _$administrationRoute(IntervalDaysSchedule v) =>
      v.administrationRoute;
  static const Field<IntervalDaysSchedule, AdministrationRoute>
      _f$administrationRoute = Field(
    'administrationRoute',
    _$administrationRoute,
    key: r'administrationRouteName',
  );
  static Ester? _$ester(IntervalDaysSchedule v) => v.ester;
  static const Field<IntervalDaysSchedule, Ester> _f$ester = Field(
    'ester',
    _$ester,
    key: r'esterName',
    opt: true,
  );
  static List<TimeOfDay> _$notificationTimes(IntervalDaysSchedule v) =>
      v.notificationTimes;
  static const Field<IntervalDaysSchedule, List<TimeOfDay>>
      _f$notificationTimes = Field('notificationTimes', _$notificationTimes);

  @override
  final MappableFields<IntervalDaysSchedule> fields = const {
    #id: _f$id,
    #name: _f$name,
    #dose: _f$dose,
    #intervalDays: _f$intervalDays,
    #startDate: _f$startDate,
    #molecule: _f$molecule,
    #administrationRoute: _f$administrationRoute,
    #ester: _f$ester,
    #notificationTimes: _f$notificationTimes,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'intervalDays';
  @override
  late final ClassMapperBase superMapper =
      MedicationScheduleMapper.ensureInitialized();

  static IntervalDaysSchedule _instantiate(DecodingData data) {
    return IntervalDaysSchedule(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      dose: data.dec(_f$dose),
      intervalDays: data.dec(_f$intervalDays),
      startDate: data.dec(_f$startDate),
      molecule: data.dec(_f$molecule),
      administrationRoute: data.dec(_f$administrationRoute),
      ester: data.dec(_f$ester),
      notificationTimes: data.dec(_f$notificationTimes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static IntervalDaysSchedule fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntervalDaysSchedule>(map);
  }

  static IntervalDaysSchedule fromJson(String json) {
    return ensureInitialized().decodeJson<IntervalDaysSchedule>(json);
  }
}

mixin IntervalDaysScheduleMappable {
  String toJson() {
    return IntervalDaysScheduleMapper.ensureInitialized()
        .encodeJson<IntervalDaysSchedule>(this as IntervalDaysSchedule);
  }

  Map<String, dynamic> toMap() {
    return IntervalDaysScheduleMapper.ensureInitialized()
        .encodeMap<IntervalDaysSchedule>(this as IntervalDaysSchedule);
  }

  IntervalDaysScheduleCopyWith<IntervalDaysSchedule, IntervalDaysSchedule,
      IntervalDaysSchedule> get copyWith => _IntervalDaysScheduleCopyWithImpl<
          IntervalDaysSchedule, IntervalDaysSchedule>(
      this as IntervalDaysSchedule, $identity, $identity);
  @override
  String toString() {
    return IntervalDaysScheduleMapper.ensureInitialized().stringifyValue(
      this as IntervalDaysSchedule,
    );
  }

  @override
  bool operator ==(Object other) {
    return IntervalDaysScheduleMapper.ensureInitialized().equalsValue(
      this as IntervalDaysSchedule,
      other,
    );
  }

  @override
  int get hashCode {
    return IntervalDaysScheduleMapper.ensureInitialized().hashValue(
      this as IntervalDaysSchedule,
    );
  }
}

extension IntervalDaysScheduleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntervalDaysSchedule, $Out> {
  IntervalDaysScheduleCopyWith<$R, IntervalDaysSchedule, $Out>
      get $asIntervalDaysSchedule => $base.as(
            (v, t, t2) => _IntervalDaysScheduleCopyWithImpl<$R, $Out>(v, t, t2),
          );
}

abstract class IntervalDaysScheduleCopyWith<
    $R,
    $In extends IntervalDaysSchedule,
    $Out> implements MedicationScheduleCopyWith<$R, $In, $Out> {
  @override
  ListCopyWith<$R, TimeOfDay, ObjectCopyWith<$R, TimeOfDay, TimeOfDay>>
      get notificationTimes;
  @override
  $R call({
    int? id,
    String? name,
    Decimal? dose,
    int? intervalDays,
    Date? startDate,
    Molecule? molecule,
    AdministrationRoute? administrationRoute,
    Ester? ester,
    List<TimeOfDay>? notificationTimes,
  });
  IntervalDaysScheduleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _IntervalDaysScheduleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntervalDaysSchedule, $Out>
    implements IntervalDaysScheduleCopyWith<$R, IntervalDaysSchedule, $Out> {
  _IntervalDaysScheduleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntervalDaysSchedule> $mapper =
      IntervalDaysScheduleMapper.ensureInitialized();
  @override
  ListCopyWith<$R, TimeOfDay, ObjectCopyWith<$R, TimeOfDay, TimeOfDay>>
      get notificationTimes => ListCopyWith(
            $value.notificationTimes,
            (v, t) => ObjectCopyWith(v, $identity, t),
            (v) => call(notificationTimes: v),
          );
  @override
  $R call({
    Object? id = $none,
    String? name,
    Decimal? dose,
    int? intervalDays,
    Object? startDate = $none,
    Molecule? molecule,
    AdministrationRoute? administrationRoute,
    Object? ester = $none,
    List<TimeOfDay>? notificationTimes,
  }) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != null) #name: name,
          if (dose != null) #dose: dose,
          if (intervalDays != null) #intervalDays: intervalDays,
          if (startDate != $none) #startDate: startDate,
          if (molecule != null) #molecule: molecule,
          if (administrationRoute != null)
            #administrationRoute: administrationRoute,
          if (ester != $none) #ester: ester,
          if (notificationTimes != null) #notificationTimes: notificationTimes,
        }),
      );
  @override
  IntervalDaysSchedule $make(CopyWithData data) => IntervalDaysSchedule(
        id: data.get(#id, or: $value.id),
        name: data.get(#name, or: $value.name),
        dose: data.get(#dose, or: $value.dose),
        intervalDays: data.get(#intervalDays, or: $value.intervalDays),
        startDate: data.get(#startDate, or: $value.startDate),
        molecule: data.get(#molecule, or: $value.molecule),
        administrationRoute: data.get(
          #administrationRoute,
          or: $value.administrationRoute,
        ),
        ester: data.get(#ester, or: $value.ester),
        notificationTimes: data.get(
          #notificationTimes,
          or: $value.notificationTimes,
        ),
      );

  @override
  IntervalDaysScheduleCopyWith<$R2, IntervalDaysSchedule, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _IntervalDaysScheduleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DailyScheduleMapper extends SubClassMapperBase<DailySchedule> {
  DailyScheduleMapper._();

  static DailyScheduleMapper? _instance;
  static DailyScheduleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DailyScheduleMapper._());
      MedicationScheduleMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals.useAll([
        MoleculeJsonMapper(),
        AdministrationRouteNameMapper(),
        EsterNameMapper(),
        DecimalStringMapper(),
        DateStringMapper(),
        TimeOfDayStringMapper(),
        JsonListMapper<TimeOfDay>(),
      ]);
    }
    return _instance!;
  }

  @override
  final String id = 'DailySchedule';

  static int _$id(DailySchedule v) => v.id;
  static const Field<DailySchedule, int> _f$id = Field('id', _$id, opt: true);
  static String _$name(DailySchedule v) => v.name;
  static const Field<DailySchedule, String> _f$name = Field('name', _$name);
  static Decimal _$dose(DailySchedule v) => v.dose;
  static const Field<DailySchedule, Decimal> _f$dose = Field('dose', _$dose);
  static Date _$startDate(DailySchedule v) => v.startDate;
  static const Field<DailySchedule, Date> _f$startDate = Field(
    'startDate',
    _$startDate,
    opt: true,
  );
  static Molecule _$molecule(DailySchedule v) => v.molecule;
  static const Field<DailySchedule, Molecule> _f$molecule = Field(
    'molecule',
    _$molecule,
    key: r'moleculeJson',
  );
  static AdministrationRoute _$administrationRoute(DailySchedule v) =>
      v.administrationRoute;
  static const Field<DailySchedule, AdministrationRoute>
      _f$administrationRoute = Field(
    'administrationRoute',
    _$administrationRoute,
    key: r'administrationRouteName',
  );
  static Ester? _$ester(DailySchedule v) => v.ester;
  static const Field<DailySchedule, Ester> _f$ester = Field(
    'ester',
    _$ester,
    key: r'esterName',
    opt: true,
  );
  static List<TimeOfDay> _$notificationTimes(DailySchedule v) =>
      v.notificationTimes;
  static const Field<DailySchedule, List<TimeOfDay>> _f$notificationTimes =
      Field('notificationTimes', _$notificationTimes);

  @override
  final MappableFields<DailySchedule> fields = const {
    #id: _f$id,
    #name: _f$name,
    #dose: _f$dose,
    #startDate: _f$startDate,
    #molecule: _f$molecule,
    #administrationRoute: _f$administrationRoute,
    #ester: _f$ester,
    #notificationTimes: _f$notificationTimes,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'daily';
  @override
  late final ClassMapperBase superMapper =
      MedicationScheduleMapper.ensureInitialized();

  static DailySchedule _instantiate(DecodingData data) {
    return DailySchedule(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      dose: data.dec(_f$dose),
      startDate: data.dec(_f$startDate),
      molecule: data.dec(_f$molecule),
      administrationRoute: data.dec(_f$administrationRoute),
      ester: data.dec(_f$ester),
      notificationTimes: data.dec(_f$notificationTimes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DailySchedule fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DailySchedule>(map);
  }

  static DailySchedule fromJson(String json) {
    return ensureInitialized().decodeJson<DailySchedule>(json);
  }
}

mixin DailyScheduleMappable {
  String toJson() {
    return DailyScheduleMapper.ensureInitialized().encodeJson<DailySchedule>(
      this as DailySchedule,
    );
  }

  Map<String, dynamic> toMap() {
    return DailyScheduleMapper.ensureInitialized().encodeMap<DailySchedule>(
      this as DailySchedule,
    );
  }

  DailyScheduleCopyWith<DailySchedule, DailySchedule, DailySchedule>
      get copyWith => _DailyScheduleCopyWithImpl<DailySchedule, DailySchedule>(
            this as DailySchedule,
            $identity,
            $identity,
          );
  @override
  String toString() {
    return DailyScheduleMapper.ensureInitialized().stringifyValue(
      this as DailySchedule,
    );
  }

  @override
  bool operator ==(Object other) {
    return DailyScheduleMapper.ensureInitialized().equalsValue(
      this as DailySchedule,
      other,
    );
  }

  @override
  int get hashCode {
    return DailyScheduleMapper.ensureInitialized().hashValue(
      this as DailySchedule,
    );
  }
}

extension DailyScheduleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DailySchedule, $Out> {
  DailyScheduleCopyWith<$R, DailySchedule, $Out> get $asDailySchedule =>
      $base.as((v, t, t2) => _DailyScheduleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DailyScheduleCopyWith<$R, $In extends DailySchedule, $Out>
    implements MedicationScheduleCopyWith<$R, $In, $Out> {
  @override
  ListCopyWith<$R, TimeOfDay, ObjectCopyWith<$R, TimeOfDay, TimeOfDay>>
      get notificationTimes;
  @override
  $R call({
    int? id,
    String? name,
    Decimal? dose,
    Date? startDate,
    Molecule? molecule,
    AdministrationRoute? administrationRoute,
    Ester? ester,
    List<TimeOfDay>? notificationTimes,
  });
  DailyScheduleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DailyScheduleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DailySchedule, $Out>
    implements DailyScheduleCopyWith<$R, DailySchedule, $Out> {
  _DailyScheduleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DailySchedule> $mapper =
      DailyScheduleMapper.ensureInitialized();
  @override
  ListCopyWith<$R, TimeOfDay, ObjectCopyWith<$R, TimeOfDay, TimeOfDay>>
      get notificationTimes => ListCopyWith(
            $value.notificationTimes,
            (v, t) => ObjectCopyWith(v, $identity, t),
            (v) => call(notificationTimes: v),
          );
  @override
  $R call({
    Object? id = $none,
    String? name,
    Decimal? dose,
    Object? startDate = $none,
    Molecule? molecule,
    AdministrationRoute? administrationRoute,
    Object? ester = $none,
    List<TimeOfDay>? notificationTimes,
  }) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != null) #name: name,
          if (dose != null) #dose: dose,
          if (startDate != $none) #startDate: startDate,
          if (molecule != null) #molecule: molecule,
          if (administrationRoute != null)
            #administrationRoute: administrationRoute,
          if (ester != $none) #ester: ester,
          if (notificationTimes != null) #notificationTimes: notificationTimes,
        }),
      );
  @override
  DailySchedule $make(CopyWithData data) => DailySchedule(
        id: data.get(#id, or: $value.id),
        name: data.get(#name, or: $value.name),
        dose: data.get(#dose, or: $value.dose),
        startDate: data.get(#startDate, or: $value.startDate),
        molecule: data.get(#molecule, or: $value.molecule),
        administrationRoute: data.get(
          #administrationRoute,
          or: $value.administrationRoute,
        ),
        ester: data.get(#ester, or: $value.ester),
        notificationTimes: data.get(
          #notificationTimes,
          or: $value.notificationTimes,
        ),
      );

  @override
  DailyScheduleCopyWith<$R2, DailySchedule, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) =>
      _DailyScheduleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
