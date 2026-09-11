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
class TranslationsTok extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsTok(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.tok,
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

  /// Metadata for the translations of <tok>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsTok _root = this; // ignore: unused_field

  @override
  TranslationsTok $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsTok(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'Mona';
  @override
  String get nav_home => 'Mona';
  @override
  String get nav_intakes => 'moku';
  @override
  String get nav_levels => 'nanpa sijelo';
  @override
  String get nav_supplies => 'jo';
  @override
  String get addAnItem => 'misikeke sin';
  @override
  String get empty_home => 'o pana e nasin tenpo lon poki nasin';
  @override
  String get allDone => 'ale li pini!';
  @override
  String get noIntakesDue => 'o moku ala e misikeke lon suno ni';
  @override
  String get upcoming => 'kama';
  @override
  String get yesterday => 'tenpo suno pini';
  @override
  String get tomorrow => 'tenpo suno kama';
  @override
  String get goToSettings => 'o tawa poki nasin';
  @override
  String get settingsTitle => 'poki nasin';
  @override
  String get notifications => 'pana toki';
  @override
  String get schedulesAndNotifications => 'nasin tenpo en pana toki';
  @override
  String get general => 'ale';
  @override
  String get schedules => 'nasin tenpo';
  @override
  String get noSchedules => 'nasin tenpo li lon ala';
  @override
  String get language => 'toki';
  @override
  String get languageFollowDevice => 'o kepeken e toki ilo';
  @override
  String get enableNotifications => 'o open e pana toki';
  @override
  String get notificationsDisabledTitle => 'pana toki li lon ala';
  @override
  String get checkForUpdates => 'o alasa e sin';
  @override
  String get updateDialogTitle => 'sin li lon';
  @override
  String get addSchedule => 'o pana e nasin tenpo sin';
  @override
  String get addScheduleToGetStarted => 'o pana e nasin tenpo sin la o open.';
  @override
  String get newSchedule => 'nasin tenpo sin';
  @override
  String get days => 'tenpo suno';
  @override
  String get startDate => 'tenpo open';
  @override
  String get addIntakeTime => 'o pana e tenpo';
  @override
  String get editScheduleInfo => 'o ante e sona pi nasin tenpo';
  @override
  String get scheduling => 'nasin tenpo';
  @override
  String get editSchedule => 'o ante e nasin tenpo';
  @override
  String deleteSchedule({required Object name}) =>
      'o weka ala weka e nasin tenpo ${name}?';
  @override
  String get addNotification => 'o pana e pana toki sin';
  @override
  String get editIntake => 'o ante e open';
  @override
  String get date => 'tenpo';
  @override
  String get none => 'ala';
  @override
  String get supplyItem => 'ijo jo';
  @override
  String get deleteIntake => 'o weka ala weka e open ni?';
  @override
  String get notes => 'lipu';
  @override
  String get microliters => 'μL';
  @override
  String chartBloodTestLevelTooltip(
          {required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String chartLevelTooltip({required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String get empty_supplies => 'jo li lon ala. o pana e ijo sin la o open.';
  @override
  String get allItemsFilter => 'ale';
  @override
  String get newItem => 'ijo sin';
  @override
  String get adminRoute => 'nasin pana';
  @override
  String get concentration => 'wawa';
  @override
  String get editItem => 'o ante e ijo';
  @override
  String deleteItem({required Object name}) => 'o weka ala weka e ${name}?';
  @override
  String get add => 'o pana e ijo';
  @override
  String get cancel => 'o weka';
  @override
  String get next => 'o tawa lipu kama';
  @override
  String get deleteElement => 'mi o weka ala weka e ijo ni?';
  @override
  String get irreversibleAction => 'mi ken ala weka e wile sina ni.';
  @override
  String get name => 'nimi';
  @override
  String get unitMilligram => 'mg';
  @override
  String get unitPgPerMl => 'pg/mL';
  @override
  String get unitPmolPerL => 'pmol/L';
  @override
  String get unitNgPerDl => 'ng/dL';
  @override
  String get unitNmolPerL => 'nmol/L';
  @override
  String get requiredField => 'poki ni li wile e nimi';
  @override
  String get takeAnIntake => 'moku sin';
  @override
  String get taken => 'pini';
  @override
  String get scheduleFrequencyDaily => 'suno ale';
  @override
  String get scheduleFrequencyInterval => 'sike pi tenpo suno';
  @override
  String get scheduleFrequencyWeekly => 'sike pi tenpo esun';
  @override
  String get scheduleFrequencyMonthly => 'sike pi tenpo mun';
  @override
  String get theme => 'nasin kule';
  @override
  String get themeGenerate => 'o kama e kule sin';
  @override
  String get themeVariant => 'o wile e kule nasin ni wan';
  @override
  String get themeContrastStandard => 'ante lili';
  @override
  String get themeContrastMedium => 'ante mute';
  @override
  String get themeContrastHigh => 'ante mute a';
  @override
  String notificationMedicationReminderTitle({required Object scheduleName}) =>
      'o moku e ${scheduleName}';
  @override
  String notificationMedicationReminderBodyDate({required Object date}) =>
      'sina o ni lon ${date}';
  @override
  String notificationMedicationReminderBodyTime({required Object time}) =>
      'sina o ni lon tenpo ${time}';
  @override
  String notificationMedicationReminderBodyWeekday({required Object weekday}) =>
      'sina o ni lon ${weekday}';
  @override
  String get totalAmount => 'ale poki la';
  @override
  String get save => 'o awen e ni';
  @override
  String get delete => 'o weka e ona';
  @override
  String get injection => 'palisa li insa e ona lon selo sijelo';
  @override
  String get oral => 'uta la mi moku e ona';
  @override
  String get sublingual => 'ona li awen lon uta li kama telo';
  @override
  String get patch => 'lipu li lon selo sijelo li awen pana e ona';
  @override
  String get gel => 'mi pana e ko tawa selo. ona li kama lon insa';
  @override
  String get transdermalSpray =>
      'mi pana e telo kon tawa selo. ona li kama lon insa';
  @override
  String get transdermalDrops =>
      'mi pana e telo tawa selo. ona li kama lon insa';
  @override
  String get placementLeft => 'poka sijelo nanpa wan';
  @override
  String get placementRight => 'poka sijelo nanpa tu';
  @override
  String get placementLeftThigh => 'poka noka nanpa wan';
  @override
  String get placementRightThigh => 'poka noka nanpa tu';
  @override
  String get placementRightArm => 'poka luka nanpa tu';
  @override
  String get placementLeftArm => 'poka luka nanpa wan';
  @override
  String get placementRightButtock => 'monsi la poka nanpa tu';
  @override
  String get placementLeftAbdomen => 'sinpin la poka nanpa wan';
  @override
  String get placementRightAbdomen => 'sinpin la poka nanpa tu';
  @override
  String get injectionSitesDescription =>
      'ma seme pi sijelo sina la palisa li ken insa e telo';
  @override
  String get addInjectionSite => 'ma sijelo sin';
  @override
  String get noInjectionSitesYet => 'ma sijelo ala li lon';
  @override
  String get noInjectionAddOneToGetStarted => 'open la o pana e ma sijelo sin.';
  @override
  String get mustBePositiveNumber => 'nanpa o lon o suli tawa 0';
  @override
  String get mustBeBetween1And28 => '1 en 28 la nanpa o lon insa';
  @override
  String get placementLeftButtock => 'monsi la poka nanpa wan';
  @override
  String get customSiteLabel => 'ma sijelo nimi';
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tok'))(
        count,
        other: 'suno ${count} la ona wan',
      );
}

/// The flat map containing all translations for locale <tok>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsTok {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'Mona',
      'nav_home' => 'Mona',
      'nav_intakes' => 'moku',
      'nav_levels' => 'nanpa sijelo',
      'nav_supplies' => 'jo',
      'addAnItem' => 'misikeke sin',
      'empty_home' => 'o pana e nasin tenpo lon poki nasin',
      'allDone' => 'ale li pini!',
      'noIntakesDue' => 'o moku ala e misikeke lon suno ni',
      'upcoming' => 'kama',
      'yesterday' => 'tenpo suno pini',
      'tomorrow' => 'tenpo suno kama',
      'goToSettings' => 'o tawa poki nasin',
      'settingsTitle' => 'poki nasin',
      'notifications' => 'pana toki',
      'schedulesAndNotifications' => 'nasin tenpo en pana toki',
      'general' => 'ale',
      'schedules' => 'nasin tenpo',
      'noSchedules' => 'nasin tenpo li lon ala',
      'language' => 'toki',
      'languageFollowDevice' => 'o kepeken e toki ilo',
      'enableNotifications' => 'o open e pana toki',
      'notificationsDisabledTitle' => 'pana toki li lon ala',
      'checkForUpdates' => 'o alasa e sin',
      'updateDialogTitle' => 'sin li lon',
      'addSchedule' => 'o pana e nasin tenpo sin',
      'addScheduleToGetStarted' => 'o pana e nasin tenpo sin la o open.',
      'newSchedule' => 'nasin tenpo sin',
      'days' => 'tenpo suno',
      'startDate' => 'tenpo open',
      'addIntakeTime' => 'o pana e tenpo',
      'editScheduleInfo' => 'o ante e sona pi nasin tenpo',
      'scheduling' => 'nasin tenpo',
      'editSchedule' => 'o ante e nasin tenpo',
      'deleteSchedule' => ({required Object name}) =>
          'o weka ala weka e nasin tenpo ${name}?',
      'addNotification' => 'o pana e pana toki sin',
      'editIntake' => 'o ante e open',
      'date' => 'tenpo',
      'none' => 'ala',
      'supplyItem' => 'ijo jo',
      'deleteIntake' => 'o weka ala weka e open ni?',
      'notes' => 'lipu',
      'microliters' => 'μL',
      'chartBloodTestLevelTooltip' =>
        ({required Object date, required Object level}) => '${date}: ${level}',
      'chartLevelTooltip' => ({required Object date, required Object level}) =>
          '${date}: ${level}',
      'empty_supplies' => 'jo li lon ala. o pana e ijo sin la o open.',
      'allItemsFilter' => 'ale',
      'newItem' => 'ijo sin',
      'adminRoute' => 'nasin pana',
      'concentration' => 'wawa',
      'editItem' => 'o ante e ijo',
      'deleteItem' => ({required Object name}) => 'o weka ala weka e ${name}?',
      'add' => 'o pana e ijo',
      'cancel' => 'o weka',
      'next' => 'o tawa lipu kama',
      'deleteElement' => 'mi o weka ala weka e ijo ni?',
      'irreversibleAction' => 'mi ken ala weka e wile sina ni.',
      'name' => 'nimi',
      'unitMilligram' => 'mg',
      'unitPgPerMl' => 'pg/mL',
      'unitPmolPerL' => 'pmol/L',
      'unitNgPerDl' => 'ng/dL',
      'unitNmolPerL' => 'nmol/L',
      'requiredField' => 'poki ni li wile e nimi',
      'takeAnIntake' => 'moku sin',
      'taken' => 'pini',
      'scheduleFrequencyDaily' => 'suno ale',
      'scheduleFrequencyInterval' => 'sike pi tenpo suno',
      'scheduleFrequencyWeekly' => 'sike pi tenpo esun',
      'scheduleFrequencyMonthly' => 'sike pi tenpo mun',
      'theme' => 'nasin kule',
      'themeGenerate' => 'o kama e kule sin',
      'themeVariant' => 'o wile e kule nasin ni wan',
      'themeContrastStandard' => 'ante lili',
      'themeContrastMedium' => 'ante mute',
      'themeContrastHigh' => 'ante mute a',
      'notificationMedicationReminderTitle' =>
        ({required Object scheduleName}) => 'o moku e ${scheduleName}',
      'notificationMedicationReminderBodyDate' => ({required Object date}) =>
          'sina o ni lon ${date}',
      'notificationMedicationReminderBodyTime' => ({required Object time}) =>
          'sina o ni lon tenpo ${time}',
      'notificationMedicationReminderBodyWeekday' =>
        ({required Object weekday}) => 'sina o ni lon ${weekday}',
      'totalAmount' => 'ale poki la',
      'save' => 'o awen e ni',
      'delete' => 'o weka e ona',
      'injection' => 'palisa li insa e ona lon selo sijelo',
      'oral' => 'uta la mi moku e ona',
      'sublingual' => 'ona li awen lon uta li kama telo',
      'patch' => 'lipu li lon selo sijelo li awen pana e ona',
      'gel' => 'mi pana e ko tawa selo. ona li kama lon insa',
      'transdermalSpray' =>
        'mi pana e telo kon tawa selo. ona li kama lon insa',
      'transdermalDrops' => 'mi pana e telo tawa selo. ona li kama lon insa',
      'placementLeft' => 'poka sijelo nanpa wan',
      'placementRight' => 'poka sijelo nanpa tu',
      'placementLeftThigh' => 'poka noka nanpa wan',
      'placementRightThigh' => 'poka noka nanpa tu',
      'placementRightArm' => 'poka luka nanpa tu',
      'placementLeftArm' => 'poka luka nanpa wan',
      'placementRightButtock' => 'monsi la poka nanpa tu',
      'placementLeftAbdomen' => 'sinpin la poka nanpa wan',
      'placementRightAbdomen' => 'sinpin la poka nanpa tu',
      'injectionSitesDescription' =>
        'ma seme pi sijelo sina la palisa li ken insa e telo',
      'addInjectionSite' => 'ma sijelo sin',
      'noInjectionSitesYet' => 'ma sijelo ala li lon',
      'noInjectionAddOneToGetStarted' => 'open la o pana e ma sijelo sin.',
      'mustBePositiveNumber' => 'nanpa o lon o suli tawa 0',
      'mustBeBetween1And28' => '1 en 28 la nanpa o lon insa',
      'placementLeftButtock' => 'monsi la poka nanpa wan',
      'customSiteLabel' => 'ma sijelo nimi',
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tok'))(
            count,
            other: 'suno ${count} la ona wan',
          ),
      _ => null,
    };
  }
}
