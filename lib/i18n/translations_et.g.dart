///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEt extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsEt(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.et,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ),
        super(
            cardinalResolver: cardinalResolver,
            ordinalResolver: ordinalResolver) {
    super.$meta.setFlatMapFunction(
        $meta.getTranslation); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <et>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsEt _root = this; // ignore: unused_field

  @override
  TranslationsEt $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsEt(meta: meta ?? this.$meta);

  // Translations
  @override
  String get goToSettings => 'Ava seadistused';
  @override
  String get settingsTitle => 'Seadistused';
  @override
  String get notifications => 'Teavitused';
  @override
  String get appTitle => 'Mona';
  @override
  String get nav_home => 'Mona';
  @override
  String get nav_supplies => 'Varud';
  @override
  String get yesterday => 'eile';
  @override
  String get tomorrow => 'homme';
  @override
  String get lastTaken => 'Viimati võetud';
  @override
  String get neverTakenYet => 'Pole kunagi võetud';
  @override
  String get scheduleFrequencyDaily => 'Iga päev';
  @override
  String get scheduleFrequencyDailyDescription => 'Iga päev kindlal ajal';
  @override
  String get scheduleFrequencyInterval => 'Välp';
  @override
  String get scheduleFrequencyIntervalDescription => 'Iga paari päeva järel';
  @override
  String get language => 'Keel';
  @override
  String get languageFollowDevice => 'Järgi seadme keelt';
  @override
  String get selectLanguage => 'Vali keel';
  @override
  String get enableNotifications => 'Võta teavitused kasutusele';
  @override
  String get enableNotificationsDescription => 'Saada meeldetuletusi';
  @override
  String get asNeeded => 'Vastavalt vajadusele';
  @override
  String get taken => 'Võetud';
  @override
  String appVersion({required Object version}) => 'Mona versioon ${version}';
  @override
  String backupSavedTo({required Object path}) =>
      'Varukoopia on salvestatud asukohta: ${path}';
  @override
  String exportFailed({required Object error}) =>
      'Eksportimine ei õnnestunud: ${error}';
  @override
  String get importDataTitle => 'Impordi andmed';
  @override
  String get importDataSubtitle => 'Taasta andmed JSON-vormingus varukoopiast';
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('et'))(
        count,
        one: '${count} päev tagasi',
        other: '${count} päeva tagasi',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('et'))(
        count,
        one: '${count} päeva pärast',
        other: '${count} päeva pärast',
      );
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('et'))(
        count,
        one: 'Iga päev',
        other: 'Iga ${count} päeva järel',
      );
}

/// The flat map containing all translations for locale <et>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEt {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'goToSettings' => 'Ava seadistused',
      'settingsTitle' => 'Seadistused',
      'notifications' => 'Teavitused',
      'appTitle' => 'Mona',
      'nav_home' => 'Mona',
      'nav_supplies' => 'Varud',
      'yesterday' => 'eile',
      'tomorrow' => 'homme',
      'lastTaken' => 'Viimati võetud',
      'neverTakenYet' => 'Pole kunagi võetud',
      'scheduleFrequencyDaily' => 'Iga päev',
      'scheduleFrequencyDailyDescription' => 'Iga päev kindlal ajal',
      'scheduleFrequencyInterval' => 'Välp',
      'scheduleFrequencyIntervalDescription' => 'Iga paari päeva järel',
      'language' => 'Keel',
      'languageFollowDevice' => 'Järgi seadme keelt',
      'selectLanguage' => 'Vali keel',
      'enableNotifications' => 'Võta teavitused kasutusele',
      'enableNotificationsDescription' => 'Saada meeldetuletusi',
      'asNeeded' => 'Vastavalt vajadusele',
      'taken' => 'Võetud',
      'appVersion' => ({required Object version}) => 'Mona versioon ${version}',
      'backupSavedTo' => ({required Object path}) =>
          'Varukoopia on salvestatud asukohta: ${path}',
      'exportFailed' => ({required Object error}) =>
          'Eksportimine ei õnnestunud: ${error}',
      'importDataTitle' => 'Impordi andmed',
      'importDataSubtitle' => 'Taasta andmed JSON-vormingus varukoopiast',
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('et'))(
            count,
            one: '${count} päev tagasi',
            other: '${count} päeva tagasi',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('et'))(
            count,
            one: '${count} päeva pärast',
            other: '${count} päeva pärast',
          ),
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('et'))(
            count,
            one: 'Iga päev',
            other: 'Iga ${count} päeva järel',
          ),
      _ => null,
    };
  }
}
