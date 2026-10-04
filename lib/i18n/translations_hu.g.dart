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
class TranslationsHu extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsHu(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.hu,
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

  /// Metadata for the translations of <hu>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsHu _root = this; // ignore: unused_field

  @override
  TranslationsHu $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsHu(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'Mona';
  @override
  String get nav_home => 'Mona';
  @override
  String get nav_intakes => 'Bevevések';
  @override
  String get nav_levels => 'Szintek';
  @override
  String get nav_supplies => 'Készlet';
  @override
  String get takeAnIntake => 'Bevevés felírása';
  @override
  String get addAnItem => 'Item hozzáadása';
  @override
  String get empty_home =>
      'Kezdje egy időbeosztás hozzáadásával a Beállításokban';
  @override
  String get allDone => 'Kész!';
  @override
  String get noIntakesDue => 'Nincs mára felírt adag';
  @override
  String get upcoming => 'Következő';
  @override
  String get asNeeded => 'Ahogy szükséges';
  @override
  String get taken => 'Bevéve';
  @override
  String get yesterday => 'tegnap';
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '${count} napja',
        other: '${count} napja',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '${count} nap múlva',
        other: '${count} nap múlva',
      );
}

/// The flat map containing all translations for locale <hu>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsHu {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'Mona',
      'nav_home' => 'Mona',
      'nav_intakes' => 'Bevevések',
      'nav_levels' => 'Szintek',
      'nav_supplies' => 'Készlet',
      'takeAnIntake' => 'Bevevés felírása',
      'addAnItem' => 'Item hozzáadása',
      'empty_home' => 'Kezdje egy időbeosztás hozzáadásával a Beállításokban',
      'allDone' => 'Kész!',
      'noIntakesDue' => 'Nincs mára felírt adag',
      'upcoming' => 'Következő',
      'asNeeded' => 'Ahogy szükséges',
      'taken' => 'Bevéve',
      'yesterday' => 'tegnap',
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '${count} napja',
            other: '${count} napja',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '${count} nap múlva',
            other: '${count} nap múlva',
          ),
      _ => null,
    };
  }
}
