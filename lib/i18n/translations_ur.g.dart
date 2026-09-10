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
class TranslationsUr extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsUr(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.ur,
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

  /// Metadata for the translations of <ur>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsUr _root = this; // ignore: unused_field

  @override
  TranslationsUr $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsUr(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'Mona';
  @override
  String get nav_home => 'مونا';
  @override
  String get nav_intakes => 'مدخل';
  @override
  String get nav_levels => 'لیولز';
  @override
  String get nav_supplies => 'ادویات';
  @override
  String get takeAnIntake => 'اک مدخل لیجیے';
  @override
  String get addAnItem => 'شے شامل';
  @override
  String get empty_home => 'ترتیبات میں شیڈیول شامل کر کے شروع کیجیے';
  @override
  String get allDone => 'سب مکمل!';
  @override
  String get noIntakesDue => 'آج کوئی مدخل نہیں';
  @override
  String get upcoming => 'عنقریب';
  @override
  String get asNeeded => 'ضرورت کے مطابق';
  @override
  String get taken => 'نوش شدہ';
  @override
  String get yesterday => 'گزشتہ کل';
  @override
  String get tomorrow => 'اگلا کل';
  @override
  String get lastTaken => 'آخری بار نوش شدہ';
  @override
  String get neverTakenYet => 'ابھی تک نوش نہیں کیا';
  @override
  String get scheduleFrequencyDaily => 'یومیہ';
  @override
  String get scheduleFrequencyDailyDescription => 'ہر دن، مقرر اوقات پر';
  @override
  String get scheduleFrequencyInterval => 'انتر';
  @override
  String get scheduleFrequencyIntervalDescription => 'ہر کچھ دن بعد';
  @override
  String get scheduleFrequencyWeekly => 'ہفتہ وار';
  @override
  String get scheduleFrequencyWeeklyDescription => 'ہفتے کے کچھ دن';
  @override
  String get scheduleFrequencyMonthly => 'مہانا';
  @override
  String get scheduleFrequencyMonthlyDescription => 'ہر مہینے ایک ہی دن';
  @override
  String get scheduleFrequencyAsNeeded => 'ضرورت کے تحت';
  @override
  String get scheduleFrequencyAsNeededDescription => 'کوئی مقرر شیڈیول نہیں';
  @override
  String get newUpdateAvailable => 'نئی پیش رفت دستیاب ہے\u202B!';
  @override
  String get goToSettings => 'ترتیبات میں جائیے';
  @override
  String get settingsTitle => 'ترتیبات';
  @override
  String get notifications => 'اطلاعات';
  @override
  String get schedulesAndNotifications => 'شیڈیول اور اطلاعات';
  @override
  String get general => 'عمومی';
  @override
  String get schedules => 'شیڈیولات';
  @override
  String get noSchedules => 'کوئی شیڈیول نہیں';
  @override
  String get language => 'زبان';
  @override
  String get languageFollowDevice => 'زبان آلہ کی پیروی';
  @override
  String get selectLanguage => 'زبان منتخب';
  @override
  String get enableNotifications => 'اطلاعات فاعل';
  @override
  String get enableNotificationsDescription => 'یاد دہانی';
  @override
  String get anchorToLastIntake => 'آخری مدخل کے مطابق دوبارہ حساب';
  @override
  String get anchorToLastIntakeDescription =>
      'دوسرے مدخل کو آخری بار لینے کے پورے انتر کے بعد شیڈیول کرتا ہے';
  @override
  String get notificationsDisabledTitle => 'اطلاعات غیر فاعل ہیں';
  @override
  String get clickToOpenSettings => 'ترتیبات کھولنے کے لئے تھپتھپائیے';
  @override
  String get exactRemindersDisabled => 'ٹھیک یاد دہانی اوقات غیر فاعل ہیں';
  @override
  String get remindersDelayed =>
      'یاد دہانی میں دیر ہو سکتی ہے۔ تھپتھپا کر ترتیبات کھولیے۔';
  @override
  String get medicalSettings => 'طبی ترتیبات';
  @override
  String get theme => 'بناوٹ';
  @override
  String get themeCustomizeColors => 'ایپ کے رنگوں کو حسب ضرورت کیجیے';
  @override
  String get customThemeEnabled => 'حسب ضرورت بناوٹ';
  @override
  String get themeGenerate => 'تخلیق';
  @override
  String get themeVariant => 'منحرف';
  @override
  String get themeContrast => 'کنتر است';
  @override
  String get themeContrastStandard => 'معیاری';
  @override
  String get themeContrastMedium => 'درمیانی';
  @override
  String get themeContrastHigh => 'زیادہ';
  @override
  String get autoUpdate => 'خودکار-پیش رفت';
  @override
  String get autoUpdateDescription =>
      'ایپ کھلنے کے بعد خودکاری سے نئی پیش رفت دیکھتا ہے';
  @override
  String get checkForUpdates => 'پیش رفت کے لئے جانچ';
  @override
  String get checkForUpdatesDescription =>
      'تازہ ورژن کے لئے دستی دیکھیے\n\u202Bیہ آپ کو انٹرنیٹ سے جوڑ دے گا\n(کوئی کوائف نہیں بھیجا جائے گا)';
  @override
  String appVersion({required Object version}) => '\u202B\u202B\u202BMona ورژن ${version}';
  @override
  String backupSavedTo({required Object path}) =>
      'پر آمد \u202B${path} میں محفوظ ہوا';
  @override
  String exportFailed({required Object error}) =>
      'پر آمد کرنا ناکام: \u202B${error}';
  @override
  String get importDataTitle => 'کوائف بر آمد';
  @override
  String get importDataSubtitle => '\u202BJSON ذخیرہ سے کوائف بحال کیجیے';
  @override
  String get importDataOverwriteWarning =>
      'یہ آپکے موجودہ کوائف کو ذخیرہ سے تبدیل کر دے گا۔ اس کاروائی کو سلجھایا نہیں جا سکتا۔ جاری رکھا جائے؟';
  @override
  String get importConfirm => 'بر آمد';
  @override
  String get importSuccessfulTitle => 'بر آمد کامیاب';
  @override
  String get importRestartRequired =>
      'بحال شدہ کوائف کی اطلاق کے لئے ایپ کی تجدید کیجیے۔';
  @override
  String get closeApp => 'ایپ بند';
  @override
  String importFailed({required Object error}) =>
      'بر آمد کرنا ناکام: \u202B${error}';
  @override
  String get updates => 'پیش رافت';
  @override
  String get dataManagement => 'کوائف تنظیمات';
  @override
  String get exportDataTitle => 'کوائف پر آمد';
  @override
  String get exportDataSubtitle => 'اپنے کوائف کو \u202BJSON مسل میں محفوظ کیجیے';
  @override
  String get units => 'اکائی';
  @override
  String get updateNoCompatibleApk =>
      'آپ کے آلہ کے لئے کوئی مطابق پذیر پیش رفت نہیں ملی۔';
  @override
  String get updateAppUpToDate => '\u202B\u202Bآپ کا ایپ جدید ہے!';
  @override
  String get updateCheckNetworkError => 'پیش رفت کے لئے ابھی دیکھا نہ جا سکا۔';
  @override
  String get updateDialogTitle => 'پیش رفت دستیاب';
  @override
  String updateDialogBody({required Object latest, required Object current}) =>
      '\u202B${latest} ورژن دستیاب ہے! (موجودہ: ${current})\n\nآپ کے آلہ کے لئے مطابق پذیر پیش رفت تنصیب کے لئے تیار ہے۔';
  @override
  String get updateDownloadAndInstall => 'ڈاؤنلوڈ اور نصب';
  @override
  String get updateInstallPermissionRequired =>
      'پیش رفت نصب کرنے کے لئے اجازت درکار ہے۔';
  @override
  String get updateDownloadingTitle => 'پیش رفت ڈاؤنلوڈ ہو رہی ہے...';
  @override
  String updateFailedOpenInstaller({required Object message}) =>
      'تنصیب کار کھولنا ناکام: \u202B${message}';
  @override
  String get updateDownloadFailed =>
      'ڈاؤنلوڈ ناکام۔ براہ کرم اپنا رابطہ دیکھیے۔';
  @override
  String notificationMedicationReminderTitle({required Object scheduleName}) =>
      '\u202B${scheduleName} لینے کا وقت';
  @override
  String notificationMedicationReminderBodyDate({required Object date}) =>
      '\u202B${date} کے لئے شیڈیول';
  @override
  String notificationMedicationReminderBodyTime({required Object time}) =>
      '\u202B${time} کے لئے شیڈیول';
  @override
  String notificationMedicationReminderBodyWeekday({required Object weekday}) =>
      '\u202B${weekday} کے لئے شیڈیول';
  @override
  String get addSchedule => 'شیڈیول شمول';
  @override
  String get addScheduleToGetStarted => 'شروع ہونے کے لئے شیڈیول شامل کیجیے۔';
  @override
  String get newSchedule => 'نیا شیڈیول';
  @override
  String get every => 'ہر';
  @override
  String get days => 'دن';
  @override
  String get dayOfMonth => 'مہینے کا دن';
  @override
  String get months => 'مہینے';
  @override
  String get startDate => 'شروع تاریخ';
  @override
  String get pickATime => 'وقت منتخب کیجیے';
  @override
  String get addIntakeTime => 'وقت شامل';
  @override
  String get editScheduleInfo => 'شیڈیول معلومات کی ترمیم';
  @override
  String get scheduling => 'شیڈیول ہورہا ہے';
  @override
  String get editSchedule => 'شیڈیول ترمیم';
  @override
  String deleteSchedule({required Object name}) => '\u202B${name} کو حذف؟';
  @override
  String get addNotification => 'اطلاع شامل';
  @override
  String get empty_intakes => 'نوش شدہ مدخل ادھر نمودار ہوں گی';
  @override
  String get HrtCounter => '\u202BHRT پر وقت';
  @override
  String get HrtCounterDescription =>
      '\u202Bآپ کتنے وقت سے HRT پر ہیں اور اپنی مکمل مدخل دکھائیے\u202B';
  @override
  String get hrtWidgetPlaceholder =>
      '\u202Bاپنی پہلی مدخل لاگ کرنے کے لئے Mona کھولیے';
  @override
  String get hrtWidgetPreviewSample => '\u202B8 مہینوں سے HRT پر';
  @override
  String get hrtWidgetPreviewIntakeSample => '16 مدخل لاگ شدہ';
  @override
  String get startOfDay => 'دن کا شروع';
  @override
  String startOfDayDescription({required Object time}) =>
      '\u202B${time} سے پہلے کا وقت پچھلے دن کی جانب گنا جاتا ہے';
  @override
  String get chooseSchedule => 'شیڈیول منتخب کیجیے';
  @override
  String get addSchedulesFirst => 'پہلے شیڈیولات شامل کیجیے۔';
  @override
  String get editIntake => 'مدخل ترمیم';
  @override
  String get date => 'تاریخ';
  @override
  String get amount => 'مقدار';
  @override
  String get takenAmount => 'نوش شدہ مقدار';
  @override
  String get wastedAmount => 'ضائع شدہ مقدار';
  @override
  String get none => 'کوئی نہیں';
  @override
  String get supplyItem => 'سپلائی شے';
  @override
  String get chooseItem => 'شے منتخب کیجیے';
  @override
  String get noItemsToAdd => 'کوئی شے دستیاب نہیں';
  @override
  String get injectionSide => 'ٹیکا';
  @override
  String get deleteIntake => 'اس مدخل کو حذف کیا جائے؟';
  @override
  String takeMedication({required Object scheduleName}) =>
      '\u202B${scheduleName} لیجیے';
  @override
  String get takeIntake => 'مدخل لیجیے';
  @override
  String get intakeRecorded => 'مدخل ریکارڈ ہوا';
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: '\u202B\u202B\u202B${count} دن قبل',
        other: '\u202B${count} دن قبل',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: '\u202B${count} دن میں\u202B',
        other: '\u202B${count} دنوں میں',
      );
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: 'ہر دن',
        other: 'ہر \u202B${count} دن بعد',
      );
  @override
  String scheduleFrequencyOnDayEveryNMonths(
          {required num count, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: '\u202B${day} دن، ہر مہینے',
        other: '\u202B${day} دن، ہر ${count} مہینے',
      );
  @override
  String schedulesCreated({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: '\u202B${count} بنایا',
        other: '\u202B${count} بنائے',
      );
  @override
  String onHrtForDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: 'اک دن سے \u202BHRT پر',
        other: '\u202B${count} دنوں سے HRT پر',
      );
  @override
  String onHrtForWeeks({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: 'اک ہفتے سے \u202BHRT پر',
        other: '\u202B${count} ہفتوں سے HRT پر',
      );
  @override
  String onHrtForMonths({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: '\u202Aاک مہینے سے \u202B\u202B\u202B\u202BHRT پر',
        other: '\u202B${count} مہینوں سے \u202BHRT پر',
      );
  @override
  String onHrtForYears({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: 'اک سال سے \u202BHRT پر',
        other: '\u202B${count} سال سے HRT پر',
      );
  @override
  String intakesLoggedCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
        count,
        one: 'اک مدخل لاگ شدہ',
        other: '\u202B${count} مدخل لاگ شدہ',
      );
}

/// The flat map containing all translations for locale <ur>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsUr {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'Mona',
      'nav_home' => 'مونا',
      'nav_intakes' => 'مدخل',
      'nav_levels' => 'لیولز',
      'nav_supplies' => 'ادویات',
      'takeAnIntake' => 'اک مدخل لیجیے',
      'addAnItem' => 'شے شامل',
      'empty_home' => 'ترتیبات میں شیڈیول شامل کر کے شروع کیجیے',
      'allDone' => 'سب مکمل!',
      'noIntakesDue' => 'آج کوئی مدخل نہیں',
      'upcoming' => 'عنقریب',
      'asNeeded' => 'ضرورت کے مطابق',
      'taken' => 'نوش شدہ',
      'yesterday' => 'گزشتہ کل',
      'tomorrow' => 'اگلا کل',
      'lastTaken' => 'آخری بار نوش شدہ',
      'neverTakenYet' => 'ابھی تک نوش نہیں کیا',
      'scheduleFrequencyDaily' => 'یومیہ',
      'scheduleFrequencyDailyDescription' => 'ہر دن، مقرر اوقات پر',
      'scheduleFrequencyInterval' => 'انتر',
      'scheduleFrequencyIntervalDescription' => 'ہر کچھ دن بعد',
      'scheduleFrequencyWeekly' => 'ہفتہ وار',
      'scheduleFrequencyWeeklyDescription' => 'ہفتے کے کچھ دن',
      'scheduleFrequencyMonthly' => 'مہانا',
      'scheduleFrequencyMonthlyDescription' => 'ہر مہینے ایک ہی دن',
      'scheduleFrequencyAsNeeded' => 'ضرورت کے تحت',
      'scheduleFrequencyAsNeededDescription' => 'کوئی مقرر شیڈیول نہیں',
      'newUpdateAvailable' => 'نئی پیش رفت دستیاب ہے\u202B!',
      'goToSettings' => 'ترتیبات میں جائیے',
      'settingsTitle' => 'ترتیبات',
      'notifications' => 'اطلاعات',
      'schedulesAndNotifications' => 'شیڈیول اور اطلاعات',
      'general' => 'عمومی',
      'schedules' => 'شیڈیولات',
      'noSchedules' => 'کوئی شیڈیول نہیں',
      'language' => 'زبان',
      'languageFollowDevice' => 'زبان آلہ کی پیروی',
      'selectLanguage' => 'زبان منتخب',
      'enableNotifications' => 'اطلاعات فاعل',
      'enableNotificationsDescription' => 'یاد دہانی',
      'anchorToLastIntake' => 'آخری مدخل کے مطابق دوبارہ حساب',
      'anchorToLastIntakeDescription' =>
        'دوسرے مدخل کو آخری بار لینے کے پورے انتر کے بعد شیڈیول کرتا ہے',
      'notificationsDisabledTitle' => 'اطلاعات غیر فاعل ہیں',
      'clickToOpenSettings' => 'ترتیبات کھولنے کے لئے تھپتھپائیے',
      'exactRemindersDisabled' => 'ٹھیک یاد دہانی اوقات غیر فاعل ہیں',
      'remindersDelayed' =>
        'یاد دہانی میں دیر ہو سکتی ہے۔ تھپتھپا کر ترتیبات کھولیے۔',
      'medicalSettings' => 'طبی ترتیبات',
      'theme' => 'بناوٹ',
      'themeCustomizeColors' => 'ایپ کے رنگوں کو حسب ضرورت کیجیے',
      'customThemeEnabled' => 'حسب ضرورت بناوٹ',
      'themeGenerate' => 'تخلیق',
      'themeVariant' => 'منحرف',
      'themeContrast' => 'کنتر است',
      'themeContrastStandard' => 'معیاری',
      'themeContrastMedium' => 'درمیانی',
      'themeContrastHigh' => 'زیادہ',
      'autoUpdate' => 'خودکار-پیش رفت',
      'autoUpdateDescription' =>
        'ایپ کھلنے کے بعد خودکاری سے نئی پیش رفت دیکھتا ہے',
      'checkForUpdates' => 'پیش رفت کے لئے جانچ',
      'checkForUpdatesDescription' =>
        'تازہ ورژن کے لئے دستی دیکھیے\n\u202Bیہ آپ کو انٹرنیٹ سے جوڑ دے گا\n(کوئی کوائف نہیں بھیجا جائے گا)',
      'appVersion' => ({required Object version}) => '\u202B\u202B\u202BMona ورژن ${version}',
      'backupSavedTo' => ({required Object path}) =>
          'پر آمد \u202B${path} میں محفوظ ہوا',
      'exportFailed' => ({required Object error}) =>
          'پر آمد کرنا ناکام: \u202B${error}',
      'importDataTitle' => 'کوائف بر آمد',
      'importDataSubtitle' => '\u202BJSON ذخیرہ سے کوائف بحال کیجیے',
      'importDataOverwriteWarning' =>
        'یہ آپکے موجودہ کوائف کو ذخیرہ سے تبدیل کر دے گا۔ اس کاروائی کو سلجھایا نہیں جا سکتا۔ جاری رکھا جائے؟',
      'importConfirm' => 'بر آمد',
      'importSuccessfulTitle' => 'بر آمد کامیاب',
      'importRestartRequired' =>
        'بحال شدہ کوائف کی اطلاق کے لئے ایپ کی تجدید کیجیے۔',
      'closeApp' => 'ایپ بند',
      'importFailed' => ({required Object error}) =>
          'بر آمد کرنا ناکام: \u202B${error}',
      'updates' => 'پیش رافت',
      'dataManagement' => 'کوائف تنظیمات',
      'exportDataTitle' => 'کوائف پر آمد',
      'exportDataSubtitle' => 'اپنے کوائف کو \u202BJSON مسل میں محفوظ کیجیے',
      'units' => 'اکائی',
      'updateNoCompatibleApk' =>
        'آپ کے آلہ کے لئے کوئی مطابق پذیر پیش رفت نہیں ملی۔',
      'updateAppUpToDate' => '\u202B\u202Bآپ کا ایپ جدید ہے!',
      'updateCheckNetworkError' => 'پیش رفت کے لئے ابھی دیکھا نہ جا سکا۔',
      'updateDialogTitle' => 'پیش رفت دستیاب',
      'updateDialogBody' => (
              {required Object latest, required Object current}) =>
          '\u202B${latest} ورژن دستیاب ہے! (موجودہ: ${current})\n\nآپ کے آلہ کے لئے مطابق پذیر پیش رفت تنصیب کے لئے تیار ہے۔',
      'updateDownloadAndInstall' => 'ڈاؤنلوڈ اور نصب',
      'updateInstallPermissionRequired' =>
        'پیش رفت نصب کرنے کے لئے اجازت درکار ہے۔',
      'updateDownloadingTitle' => 'پیش رفت ڈاؤنلوڈ ہو رہی ہے...',
      'updateFailedOpenInstaller' => ({required Object message}) =>
          'تنصیب کار کھولنا ناکام: \u202B${message}',
      'updateDownloadFailed' => 'ڈاؤنلوڈ ناکام۔ براہ کرم اپنا رابطہ دیکھیے۔',
      'notificationMedicationReminderTitle' =>
        ({required Object scheduleName}) => '\u202B${scheduleName} لینے کا وقت',
      'notificationMedicationReminderBodyDate' => ({required Object date}) =>
          '\u202B${date} کے لئے شیڈیول',
      'notificationMedicationReminderBodyTime' => ({required Object time}) =>
          '\u202B${time} کے لئے شیڈیول',
      'notificationMedicationReminderBodyWeekday' =>
        ({required Object weekday}) => '\u202B${weekday} کے لئے شیڈیول',
      'addSchedule' => 'شیڈیول شمول',
      'addScheduleToGetStarted' => 'شروع ہونے کے لئے شیڈیول شامل کیجیے۔',
      'newSchedule' => 'نیا شیڈیول',
      'every' => 'ہر',
      'days' => 'دن',
      'dayOfMonth' => 'مہینے کا دن',
      'months' => 'مہینے',
      'startDate' => 'شروع تاریخ',
      'pickATime' => 'وقت منتخب کیجیے',
      'addIntakeTime' => 'وقت شامل',
      'editScheduleInfo' => 'شیڈیول معلومات کی ترمیم',
      'scheduling' => 'شیڈیول ہورہا ہے',
      'editSchedule' => 'شیڈیول ترمیم',
      'deleteSchedule' => ({required Object name}) => '\u202B${name} کو حذف؟',
      'addNotification' => 'اطلاع شامل',
      'empty_intakes' => 'نوش شدہ مدخل ادھر نمودار ہوں گی',
      'HrtCounter' => '\u202BHRT پر وقت',
      'HrtCounterDescription' =>
        '\u202Bآپ کتنے وقت سے HRT پر ہیں اور اپنی مکمل مدخل دکھائیے\u202B',
      'hrtWidgetPlaceholder' => '\u202Bاپنی پہلی مدخل لاگ کرنے کے لئے Mona کھولیے',
      'hrtWidgetPreviewSample' => '\u202B8 مہینوں سے HRT پر',
      'hrtWidgetPreviewIntakeSample' => '16 مدخل لاگ شدہ',
      'startOfDay' => 'دن کا شروع',
      'startOfDayDescription' => ({required Object time}) =>
          '\u202B${time} سے پہلے کا وقت پچھلے دن کی جانب گنا جاتا ہے',
      'chooseSchedule' => 'شیڈیول منتخب کیجیے',
      'addSchedulesFirst' => 'پہلے شیڈیولات شامل کیجیے۔',
      'editIntake' => 'مدخل ترمیم',
      'date' => 'تاریخ',
      'amount' => 'مقدار',
      'takenAmount' => 'نوش شدہ مقدار',
      'wastedAmount' => 'ضائع شدہ مقدار',
      'none' => 'کوئی نہیں',
      'supplyItem' => 'سپلائی شے',
      'chooseItem' => 'شے منتخب کیجیے',
      'noItemsToAdd' => 'کوئی شے دستیاب نہیں',
      'injectionSide' => 'ٹیکا',
      'deleteIntake' => 'اس مدخل کو حذف کیا جائے؟',
      'takeMedication' => ({required Object scheduleName}) =>
          '\u202B${scheduleName} لیجیے',
      'takeIntake' => 'مدخل لیجیے',
      'intakeRecorded' => 'مدخل ریکارڈ ہوا',
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: '\u202B\u202B\u202B${count} دن قبل',
            other: '\u202B${count} دن قبل',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: '\u202B${count} دن میں\u202B',
            other: '\u202B${count} دنوں میں',
          ),
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: 'ہر دن',
            other: 'ہر \u202B${count} دن بعد',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: '\u202B${day} دن، ہر مہینے',
            other: '\u202B${day} دن، ہر ${count} مہینے',
          ),
      'schedulesCreated' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: '\u202B${count} بنایا',
            other: '\u202B${count} بنائے',
          ),
      'onHrtForDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: 'اک دن سے \u202BHRT پر',
            other: '\u202B${count} دنوں سے HRT پر',
          ),
      'onHrtForWeeks' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: 'اک ہفتے سے \u202BHRT پر',
            other: '\u202B${count} ہفتوں سے HRT پر',
          ),
      'onHrtForMonths' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: '\u202Aاک مہینے سے \u202B\u202B\u202B\u202BHRT پر',
            other: '\u202B${count} مہینوں سے \u202BHRT پر',
          ),
      'onHrtForYears' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: 'اک سال سے \u202BHRT پر',
            other: '\u202B${count} سال سے HRT پر',
          ),
      'intakesLoggedCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ur'))(
            count,
            one: 'اک مدخل لاگ شدہ',
            other: '\u202B${count} مدخل لاگ شدہ',
          ),
      _ => null,
    };
  }
}
