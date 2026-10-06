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
class TranslationsIt extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsIt(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.it,
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

  /// Metadata for the translations of <it>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsIt _root = this; // ignore: unused_field

  @override
  TranslationsIt $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsIt(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'Mona';
  @override
  String get nav_home => 'Mona';
  @override
  String get nav_levels => 'Livelli';
  @override
  String get nav_intakes => 'Dosi';
  @override
  String get nav_supplies => 'Scorte';
  @override
  String get takeAnIntake => 'Registra una dose';
  @override
  String get addAnItem => 'Aggiungi qualcosa';
  @override
  String get empty_home => 'Per iniziare, crea una terapia nelle Impostazioni';
  @override
  String get allDone => 'Tutto fatto!';
  @override
  String get noIntakesDue => 'Nessuna dose da prendere oggi';
  @override
  String get upcoming => 'Prossime';
  @override
  String get asNeeded => 'Al bisogno';
  @override
  String get taken => 'Prese';
  @override
  String get yesterday => 'ieri';
  @override
  String get tomorrow => 'domani';
  @override
  String get lastTaken => 'Ultima dose';
  @override
  String get neverTakenYet => 'Ancora nessuna dose';
  @override
  String get scheduleFrequencyDaily => 'Giornaliera';
  @override
  String get scheduleFrequencyDailyDescription =>
      'Ogni giorno, a orari specifici';
  @override
  String get scheduleFrequencyInterval => 'Intervallo';
  @override
  String get scheduleFrequencyIntervalDescription => 'Ogni qualche giorno';
  @override
  String get scheduleFrequencyWeekly => 'Settimanalmente';
  @override
  String get scheduleFrequencyWeeklyDescription =>
      'Alcuni giorni della settimana';
  @override
  String get scheduleFrequencyMonthly => 'Mensile';
  @override
  String get scheduleFrequencyMonthlyDescription =>
      'Lo stesso giorno ogni mese';
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
        count,
        one: '${count} giorno fa',
        many: '${count} giorni fa',
        other: '${count} giorni fa',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
        count,
        one: 'in ${count} giorno',
        many: 'in ${count} giorni',
        other: 'in ${count} giorni',
      );
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
        count,
        one: 'Ogni giorno',
        many: 'Ogni ${count} giorni',
        other: 'Ogni ${count} giorni',
      );
  @override
  String scheduleFrequencyOnDayEveryNMonths(
          {required num count, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
        count,
        one: 'Il giorno ${day}, ogni mese',
        many: 'Il giorno ${day}, ogni ${count} mesi',
        other: 'Il giorno ${day}, ogni ${count} mesi',
      );
}

/// The flat map containing all translations for locale <it>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsIt {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'Mona',
      'nav_home' => 'Mona',
      'nav_levels' => 'Livelli',
      'nav_intakes' => 'Dosi',
      'nav_supplies' => 'Scorte',
      'takeAnIntake' => 'Registra una dose',
      'addAnItem' => 'Aggiungi qualcosa',
      'empty_home' => 'Per iniziare, crea una terapia nelle Impostazioni',
      'allDone' => 'Tutto fatto!',
      'noIntakesDue' => 'Nessuna dose da prendere oggi',
      'upcoming' => 'Prossime',
      'asNeeded' => 'Al bisogno',
      'taken' => 'Prese',
      'yesterday' => 'ieri',
      'tomorrow' => 'domani',
      'lastTaken' => 'Ultima dose',
      'neverTakenYet' => 'Ancora nessuna dose',
      'scheduleFrequencyDaily' => 'Giornaliera',
      'scheduleFrequencyDailyDescription' => 'Ogni giorno, a orari specifici',
      'scheduleFrequencyInterval' => 'Intervallo',
      'scheduleFrequencyIntervalDescription' => 'Ogni qualche giorno',
      'scheduleFrequencyWeekly' => 'Settimanalmente',
      'scheduleFrequencyWeeklyDescription' => 'Alcuni giorni della settimana',
      'scheduleFrequencyMonthly' => 'Mensile',
      'scheduleFrequencyMonthlyDescription' => 'Lo stesso giorno ogni mese',
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
            count,
            one: '${count} giorno fa',
            many: '${count} giorni fa',
            other: '${count} giorni fa',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
            count,
            one: 'in ${count} giorno',
            many: 'in ${count} giorni',
            other: 'in ${count} giorni',
          ),
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
            count,
            one: 'Ogni giorno',
            many: 'Ogni ${count} giorni',
            other: 'Ogni ${count} giorni',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(
            count,
            one: 'Il giorno ${day}, ogni mese',
            many: 'Il giorno ${day}, ogni ${count} mesi',
            other: 'Il giorno ${day}, ogni ${count} mesi',
          ),
      _ => null,
    };
  }
}
