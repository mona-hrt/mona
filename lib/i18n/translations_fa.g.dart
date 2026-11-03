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
class TranslationsFa extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsFa(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.fa,
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

  /// Metadata for the translations of <fa>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsFa _root = this; // ignore: unused_field

  @override
  TranslationsFa $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsFa(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'مونا';
  @override
  String get nav_home => 'مونا';
  @override
  String get tomorrow => 'فردا';
  @override
  String get scheduleFrequencyDaily => 'روزانه';
  @override
  String get nav_intakes => 'ورودی‌ها';
  @override
  String get nav_levels => 'سطوح';
  @override
  String get addAnItem => 'یک مورد اضافه کنید';
  @override
  String get allDone => 'تمام شد!';
  @override
  String get month => 'ماه';
  @override
  String get year => 'سال';
  @override
  String get estradiol => 'استرادیول';
  @override
  String get patch => 'پچ';
  @override
  String get gel => 'ژل';
  @override
  String get implant => 'ایمپلنت';
  @override
  String get settingsTitle => 'تنظیمات';
  @override
  String get notifications => 'اعلان‌ها';
  @override
  String get save => 'ذخیره';
  @override
  String get cancel => 'لغو';
  @override
  String get next => 'بعدی';
  @override
  String get delete => 'حذف';
  @override
  String get deleteElement => 'آیا این مورد حذف شود؟';
  @override
  String get theme => 'تم';
  @override
  String get themeCustomizeColors => 'شخصی‌سازی کردن رنگ های برنامه';
  @override
  String get customThemeEnabled => 'تم شخصی';
  @override
  String get themeGenerate => 'تولید کردن';
  @override
  String get unitNmolPerL => 'nmol/L';
  @override
  String get unitNgPerMl => 'ng/ml';
  @override
  String get add => 'اضافه کردن';
  @override
  String get placementRightArm => 'بازو راست';
  @override
  String get placementLeftArm => 'بازو چپ';
  @override
  String get progesterone => 'پروژسترون';
  @override
  String get testosterone => 'تستوسترون';
  @override
  String get nandrolone => 'ناندرولون';
  @override
  String get dihydrotestosterone => 'دی‌هیدروتستوسترون­';
  @override
  String get spironolactone => 'اسپیرونولاکتون';
  @override
  String get cyproteroneAcetate => 'سیپروترون استات';
  @override
  String get leuprorelinAcetate => 'لوپرورلین استات';
  @override
  String get bicalutamide => 'بیکالوتامید';
  @override
  String get finasteride => 'فیناستراید';
  @override
  String get dutasteride => 'دوتاستراید';
  @override
  String get minoxidil => 'ماینوکسیدیل';
  @override
  String get enanthate => 'انانتات';
  @override
  String get valerate => 'والرات';
  @override
  String get cypionate => 'سیپونات';
  @override
  String get benzoate => 'بنزوات';
  @override
  String get medicationEstradiolEnanthate => 'استرادیول انانتات';
  @override
  String get medicationEstradiolValerate => 'استرادیول والرات';
  @override
  String get medicationEstradiolCypionate => 'استرادیول سیپونات';
  @override
  String get medicationEstradiolBenzoate => 'استرادیول بنزوات';
  @override
  String get medicationTestosteroneEnanthate => 'تستوسترون انانتات';
  @override
  String get medicationTestosteroneValerate => 'تستوسترون والرات';
  @override
  String get medicationTestosteroneCypionate => 'تستوسترون سیپونات';
  @override
  String get medicationTestosteroneBenzoate => 'تستوسترون بنزوات';
  @override
  String get injection => 'تزریقی';
  @override
  String get oral => 'خوراکی';
  @override
  String get tamoxifen => 'تاموکسیفن';
  @override
  String get estradiolLevelLabel => 'سطح استرادیول';
  @override
  String get testosteroneLevelLabel => 'سطح تستوسترون';
  @override
  String get bloodTestsTitle => 'آزمایش خون';
  @override
  String get estradiolLevelsTitle => 'سطوح استرادیول';
  @override
  String get week => 'هفته';
  @override
  String get twoWeeks => 'دو هفته';
  @override
  String get threeMonths => 'سه ماه';
  @override
  String get sixMonths => 'شش ماه';
  @override
  String get editBloodTest => 'ویرایش کردن آزمایش خون';
  @override
  String get newBloodTest => 'آزمایش خون جدید';
  @override
  String get deleteBloodTest => 'آیا این آزمایش خون حذف شود؟';
  @override
  String get newItem => 'مورد جدید';
  @override
  String get allItemsFilter => 'همه';
  @override
  String get medicationItemsFilter => 'دارو';
  @override
  String get medicationItemType => 'دارو';
  @override
  String get updateDownloadAndInstall => 'دانلود و نصب';
  @override
  String get deliveryFormSachet => 'ساشه';
  @override
  String get supplyType => 'نوع';
  @override
  String get milliliters => 'mL';
  @override
  String get empty_levels =>
      'یک آزمایش خون اضافه کنید یا تزریق استرادیول وارد کنید تا شروع به کار کنید';
  @override
  String get injectionType => 'نوع تزریق';
  @override
  String get intramuscular => 'ماهیچه‌ای';
  @override
  String get subcutaneous => 'زیرپوستی';
  @override
  String get microliters => 'μL';
  @override
  String get empty_blood_tests =>
      'آزمایش خون در اینجا ظاهر خواهد شد. با استفاده از گزینه (اضافه کردن) شروع کنید!';
  @override
  String get addBloodTest => 'اضافه کردن آزمایش خون';
  @override
  String get yesterday => 'دیروز';
  @override
  String get takeAnIntake => 'شرح حال بگیرید';
  @override
  String get empty_home => 'با افزودن یک زمان‌بندی در بخش تنظیمات شروع کنید';
  @override
  String get scheduleFrequencyWeekly => 'هفتگی';
  @override
  String get scheduleFrequencyWeeklyDescription => 'روزهای خاصی از هفته';
  @override
  String get scheduleFrequencyMonthly => 'ماهانه';
  @override
  String get language => 'زبان';
  @override
  String get languageFollowDevice => 'مطابق با زبان دستگاه';
  @override
  String get enableNotifications => 'فعال کردن اعلان';
  @override
  String get upcoming => 'در پیش رو';
  @override
  String get asNeeded => 'در صورت نیاز';
  @override
  String get taken => 'گرفته‌شده';
  @override
  String get updateDialogTitle => 'به‌روزرسانی موجود است';
  @override
  String updateDialogBody({required Object latest, required Object current}) =>
      'نسخه ${latest} در دسترس است! (نسخه فعلی: ${current})\n\nیک به‌روزرسانیِ سازگار با دستگاه شما آماده نصب است.';
  @override
  String get importConfirm => 'وارد کردن';
  @override
  String get importSuccessfulTitle => 'واردسازی با موفقیت انجام شد';
  @override
  String get importRestartRequired =>
      'لطفاً برای اعمال داده‌های بازیابی‌شده، برنامه را مجدداً راه‌اندازی کنید.';
  @override
  String importFailed({required Object error}) =>
      'وارد کردن ناموفق بود: ${error}';
  @override
  String get updates => 'بروزرسانی‌ها';
  @override
  String get dataManagement => 'مدیریت داده ها';
  @override
  String get exportDataTitle => 'صدور داده‌ها';
  @override
  String get exportDataSubtitle => 'داده‌های خود را در یک فایل JSON ذخیره کنید';
  @override
  String get units => 'واحدهای اندازه‌گیری';
  @override
  String get updateNoCompatibleApk =>
      '­هیچ به‌روزرسانی سازگاری، برای دستگاه شما یافت نشد.';
  @override
  String get updateAppUpToDate => 'برنامه شما بروز است!';
  @override
  String get updateCheckNetworkError =>
      'در حال حاضر نمی توان به روز رسانی را بررسی کرد.';
  @override
  String get importDataSubtitle =>
      'داده‌ها از یک نسخه پشتیبان JSON بازیابی کنید';
  @override
  String get importDataOverwriteWarning =>
      'این کار تمام داده‌های فعلی شما را با نسخه پشتیبان جایگزین می‌کند. این عمل قابل بازگشت نیست. آیا می‌خواهید ادامه دهید؟';
  @override
  String get reportBug => 'گزارش دادن مشکل';
  @override
  String get neverTakenYet => 'هنوز گرفته نشده';
  @override
  String get placementRightButtock => 'باسن راست';
  @override
  String get placementLeftButtock => 'باسن چپ';
  @override
  String get injectionSideLeft => 'چپ';
  @override
  String get injectionSideRight => 'راست';
  @override
  String get placementLeft => 'سمت چپ';
  @override
  String get placementRight => 'سمت راست';
  @override
  String get placementLeftThigh => 'ران چپ';
  @override
  String get placementRightThigh => 'ران راست';
  @override
  String get placementLeftAbdomen => 'سمت چپ شکم';
  @override
  String get placementRightAbdomen => 'سمت راست شکم';
  @override
  String appVersion({required Object version}) => 'نسخه مونا ${version}';
  @override
  String get checkForUpdates => 'بررسی به‌روزرسانی';
  @override
  String get cypionateSuspension => 'سوسپانسیون سیپونات';
  @override
  String get medicationTestosteroneCypionateSuspension =>
      'سوسپانسیون تستوسترون سیپیونات';
  @override
  String get days => 'روز';
  @override
  String get nav_supplies => 'تدارکات';
  @override
  String get newUpdateAvailable => 'بروزرسانی جدید در دسترس است!';
  @override
  String get goToSettings => 'به تنظیمات بروید';
  @override
  String get HrtCounter => 'مدت زمان هورمون درمانی';
  @override
  String get HrtCounterDescription =>
      'مدت زمانی را که تحت هورمون درمانی بوده‌اید و مجموع مقادیر دریافتی شما را نشان می‌دهد.';
  @override
  String get hrtWidgetPreviewSample => '۸ ماه هورمون درمانی';
  @override
  String get hrtWidgetPreviewIntakeSample => '۱۶ مورد ثبت شده';
  @override
  String get startOfDay => 'شروع از روز';
  @override
  String get schedules => 'برنامه‌ریزی';
  @override
  String get noSchedules => 'بدون برنامه زمانی';
  @override
  String get scheduling => 'زمان‌بندی';
  @override
  String get donate => 'اهدا کردن';
  @override
  String get donateDescription => 'از مونا در Ko-fi حمایت کنید';
  @override
  String get backupSaved => 'نسخه پشتیبان ذخیره شد';
  @override
  String get cannotExceedTotalCapacity => 'نمی‌توان از ظرفیت کل فراتر رفت';
  @override
  String get applicationSitesDescription =>
      'مدیریت سایت‌هایی که بین آنها جابجا می‌شوید';
  @override
  String get applicationSitesInstructions =>
      'جاهایی که به‌طور چرخشی از آن‌ها استفاده می‌کنید، مدیریت نمایید. این مکان ها بر اساس سابقهٔ استفادهٔ شما پیشنهاد می‌شوند. برای تغییر ترتیب، آن‌ها را فشار داده و نگه دارید.';
  @override
  String get suppository => 'شیاف';
  @override
  String get transdermalSpray => 'اسپری پوستی';
  @override
  String get transdermalDrops => 'قطره‌ پوستی';
  @override
  String get deliveryFormPump => 'پمپ';
  @override
  String get unitMilligram => 'میلی‌گرم';
  @override
  String get unitMicrogramPerDay => 'µg/day';
  @override
  String get unitPgPerMl => 'pg/mL';
  @override
  String get unitPmolPerL => 'pmol/L';
  @override
  String get unitNgPerDl => 'ng/dL';
  @override
  String get noIntakesDue => '­امروز نیاز به مصرف نیست';
  @override
  String get lastTaken => 'آخرین بار گرفته شده';
  @override
  String get scheduleFrequencyDailyDescription => 'هر روز، در زمان‌های مشخص';
  @override
  String get scheduleFrequencyInterval => 'فاصله مصرف';
  @override
  String get scheduleFrequencyIntervalDescription => 'هر چند روز یک‌بار';
  @override
  String get scheduleFrequencyMonthlyDescription => 'همان روز در هر ماه';
  @override
  String get scheduleFrequencyAsNeeded => '­در صورت نیاز';
  @override
  String get scheduleFrequencyAsNeededDescription => 'بدون برنامه زمانی ثابت';
  @override
  String get schedulesAndNotifications => 'برنامه‌های زمانی و اعلان‌ها';
  @override
  String get general => 'عمومی';
  @override
  String get clickToOpenSettings => 'برای باز کردن تنظیمات کلیک کنید';
  @override
  String get exactRemindersDisabled => 'زمان‌های دقیق یادآوری غیرفعال شده‌اند';
  @override
  String get remindersDelayed =>
      'ممکن است یادآوری‌ها با کمی تأخیر همراه باشند. برای باز کردن تنظیمات، ضربه بزنید.';
  @override
  String get medicalSettings => 'تنظیمات دارویی';
  @override
  String get themeVariant => 'نوع تم';
  @override
  String get themeContrast => 'کنتراست';
  @override
  String get themeContrastStandard => 'استاندارد';
  @override
  String get themeContrastMedium => 'متوسط';
  @override
  String get themeContrastHigh => 'بالا';
  @override
  String get autoUpdate => 'بروزرسانی خودکار';
  @override
  String get translateAppDescription => 'به ترجمه مونا در Weblate کمک کنید';
  @override
  String get missingTranslation => 'آیا ترجمه‌ای جا افتاده است؟';
  @override
  String get checkForUpdatesDescription =>
      'بررسی دستی برای یافتن آخرین نسخه، این کار شما را به اینترنت متصل می‌کند. (هیچ‌گونه داده‌ای ارسال نخواهد شد)';
  @override
  String get autoUpdateDescription =>
      'بررسی خودکار به‌روزرسانی‌های جدید هنگام اجرای برنامه';
  @override
  String get chooseItem => 'یک مورد را انتخاب کنید';
  @override
  String get noItemsToAdd => 'هیچ موردی موجود نیست';
  @override
  String startOfDayDescription({required Object time}) =>
      'زمانِ پیش از ${time} جزو روز قبل محسوب می‌شود';
  @override
  String get chooseSchedule => '­یک برنامه زمانی انتخاب کنید';
  @override
  String get addSchedulesFirst => 'ابتدا برنامه‌های زمانی را اضافه کنید';
  @override
  String get editIntake => 'ویرایش ورودی';
  @override
  String get date => 'تاریخ';
  @override
  String get amount => 'مقدار';
  @override
  String get takenAmount => 'میزان برداشتی';
  @override
  String get wastedAmount => 'مقدار هدر رفته';
  @override
  String get none => 'هیچ‌کدام';
  @override
  String get injectionSide => 'محل تزریق';
  @override
  String get deleteIntake => 'این ورودی حذف شود؟';
  @override
  String administrationRouteUnitImplant({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'ایمپلنت',
        other: 'ایمپلنت',
      );
  @override
  String administrationRouteUnitGram({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'گرم',
        other: 'گرم',
      );
  @override
  String onHrtForDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک روز تحت هورمون درمانی',
        other: 'به مدت ${count} روز تحت هورمون درمانی',
      );
  @override
  String onHrtForWeeks({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک هفته تحت هورمون درمانی',
        other: '${count} هفته تحت هورمون درمانی',
      );
  @override
  String onHrtForMonths({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک ماه تحت هورمون درمانی',
        other: '${count} ماه تحت هورمون درمانی',
      );
  @override
  String onHrtForYears({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک سال تحت هورمون درمانی',
        other: '${count} سال تحت هورمون درمانی',
      );
  @override
  String administrationRouteUnitMl({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'میلی‌لیتر',
        other: 'میلی‌لیتر',
      );
  @override
  String administrationRouteUnitSachet({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'ساشه',
        other: 'ساشه',
      );
  @override
  String administrationRouteUnitSuppository({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'شیاف',
        other: 'شیاف',
      );
  @override
  String administrationRouteUnitSpray({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'اسپری',
        other: 'اسپری',
      );
  @override
  String administrationRouteUnitPill({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'قرص',
        other: 'قرص',
      );
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: '${count} روز پیش',
        other: '${count} روز پیش',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'در ${count} روز',
        other: 'در ${count} روز',
      );
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'هرروز',
        other: 'هر ${count} روز',
      );
  @override
  String scheduleFrequencyOnDayEveryNMonths(
          {required num count, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'روز ${day}، هر ماه',
        other: '­روز ${day}، هر ماه',
      );
}

/// The flat map containing all translations for locale <fa>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFa {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'مونا',
      'nav_home' => 'مونا',
      'tomorrow' => 'فردا',
      'scheduleFrequencyDaily' => 'روزانه',
      'nav_intakes' => 'ورودی‌ها',
      'nav_levels' => 'سطوح',
      'addAnItem' => 'یک مورد اضافه کنید',
      'allDone' => 'تمام شد!',
      'month' => 'ماه',
      'year' => 'سال',
      'estradiol' => 'استرادیول',
      'patch' => 'پچ',
      'gel' => 'ژل',
      'implant' => 'ایمپلنت',
      'settingsTitle' => 'تنظیمات',
      'notifications' => 'اعلان‌ها',
      'save' => 'ذخیره',
      'cancel' => 'لغو',
      'next' => 'بعدی',
      'delete' => 'حذف',
      'deleteElement' => 'آیا این مورد حذف شود؟',
      'theme' => 'تم',
      'themeCustomizeColors' => 'شخصی‌سازی کردن رنگ های برنامه',
      'customThemeEnabled' => 'تم شخصی',
      'themeGenerate' => 'تولید کردن',
      'unitNmolPerL' => 'nmol/L',
      'unitNgPerMl' => 'ng/ml',
      'add' => 'اضافه کردن',
      'placementRightArm' => 'بازو راست',
      'placementLeftArm' => 'بازو چپ',
      'progesterone' => 'پروژسترون',
      'testosterone' => 'تستوسترون',
      'nandrolone' => 'ناندرولون',
      'dihydrotestosterone' => 'دی‌هیدروتستوسترون­',
      'spironolactone' => 'اسپیرونولاکتون',
      'cyproteroneAcetate' => 'سیپروترون استات',
      'leuprorelinAcetate' => 'لوپرورلین استات',
      'bicalutamide' => 'بیکالوتامید',
      'finasteride' => 'فیناستراید',
      'dutasteride' => 'دوتاستراید',
      'minoxidil' => 'ماینوکسیدیل',
      'enanthate' => 'انانتات',
      'valerate' => 'والرات',
      'cypionate' => 'سیپونات',
      'benzoate' => 'بنزوات',
      'medicationEstradiolEnanthate' => 'استرادیول انانتات',
      'medicationEstradiolValerate' => 'استرادیول والرات',
      'medicationEstradiolCypionate' => 'استرادیول سیپونات',
      'medicationEstradiolBenzoate' => 'استرادیول بنزوات',
      'medicationTestosteroneEnanthate' => 'تستوسترون انانتات',
      'medicationTestosteroneValerate' => 'تستوسترون والرات',
      'medicationTestosteroneCypionate' => 'تستوسترون سیپونات',
      'medicationTestosteroneBenzoate' => 'تستوسترون بنزوات',
      'injection' => 'تزریقی',
      'oral' => 'خوراکی',
      'tamoxifen' => 'تاموکسیفن',
      'estradiolLevelLabel' => 'سطح استرادیول',
      'testosteroneLevelLabel' => 'سطح تستوسترون',
      'bloodTestsTitle' => 'آزمایش خون',
      'estradiolLevelsTitle' => 'سطوح استرادیول',
      'week' => 'هفته',
      'twoWeeks' => 'دو هفته',
      'threeMonths' => 'سه ماه',
      'sixMonths' => 'شش ماه',
      'editBloodTest' => 'ویرایش کردن آزمایش خون',
      'newBloodTest' => 'آزمایش خون جدید',
      'deleteBloodTest' => 'آیا این آزمایش خون حذف شود؟',
      'newItem' => 'مورد جدید',
      'allItemsFilter' => 'همه',
      'medicationItemsFilter' => 'دارو',
      'medicationItemType' => 'دارو',
      'updateDownloadAndInstall' => 'دانلود و نصب',
      'deliveryFormSachet' => 'ساشه',
      'supplyType' => 'نوع',
      'milliliters' => 'mL',
      'empty_levels' =>
        'یک آزمایش خون اضافه کنید یا تزریق استرادیول وارد کنید تا شروع به کار کنید',
      'injectionType' => 'نوع تزریق',
      'intramuscular' => 'ماهیچه‌ای',
      'subcutaneous' => 'زیرپوستی',
      'microliters' => 'μL',
      'empty_blood_tests' =>
        'آزمایش خون در اینجا ظاهر خواهد شد. با استفاده از گزینه (اضافه کردن) شروع کنید!',
      'addBloodTest' => 'اضافه کردن آزمایش خون',
      'yesterday' => 'دیروز',
      'takeAnIntake' => 'شرح حال بگیرید',
      'empty_home' => 'با افزودن یک زمان‌بندی در بخش تنظیمات شروع کنید',
      'scheduleFrequencyWeekly' => 'هفتگی',
      'scheduleFrequencyWeeklyDescription' => 'روزهای خاصی از هفته',
      'scheduleFrequencyMonthly' => 'ماهانه',
      'language' => 'زبان',
      'languageFollowDevice' => 'مطابق با زبان دستگاه',
      'enableNotifications' => 'فعال کردن اعلان',
      'upcoming' => 'در پیش رو',
      'asNeeded' => 'در صورت نیاز',
      'taken' => 'گرفته‌شده',
      'updateDialogTitle' => 'به‌روزرسانی موجود است',
      'updateDialogBody' => (
              {required Object latest, required Object current}) =>
          'نسخه ${latest} در دسترس است! (نسخه فعلی: ${current})\n\nیک به‌روزرسانیِ سازگار با دستگاه شما آماده نصب است.',
      'importConfirm' => 'وارد کردن',
      'importSuccessfulTitle' => 'واردسازی با موفقیت انجام شد',
      'importRestartRequired' =>
        'لطفاً برای اعمال داده‌های بازیابی‌شده، برنامه را مجدداً راه‌اندازی کنید.',
      'importFailed' => ({required Object error}) =>
          'وارد کردن ناموفق بود: ${error}',
      'updates' => 'بروزرسانی‌ها',
      'dataManagement' => 'مدیریت داده ها',
      'exportDataTitle' => 'صدور داده‌ها',
      'exportDataSubtitle' => 'داده‌های خود را در یک فایل JSON ذخیره کنید',
      'units' => 'واحدهای اندازه‌گیری',
      'updateNoCompatibleApk' =>
        '­هیچ به‌روزرسانی سازگاری، برای دستگاه شما یافت نشد.',
      'updateAppUpToDate' => 'برنامه شما بروز است!',
      'updateCheckNetworkError' =>
        'در حال حاضر نمی توان به روز رسانی را بررسی کرد.',
      'importDataSubtitle' => 'داده‌ها از یک نسخه پشتیبان JSON بازیابی کنید',
      'importDataOverwriteWarning' =>
        'این کار تمام داده‌های فعلی شما را با نسخه پشتیبان جایگزین می‌کند. این عمل قابل بازگشت نیست. آیا می‌خواهید ادامه دهید؟',
      'reportBug' => 'گزارش دادن مشکل',
      'neverTakenYet' => 'هنوز گرفته نشده',
      'placementRightButtock' => 'باسن راست',
      'placementLeftButtock' => 'باسن چپ',
      'injectionSideLeft' => 'چپ',
      'injectionSideRight' => 'راست',
      'placementLeft' => 'سمت چپ',
      'placementRight' => 'سمت راست',
      'placementLeftThigh' => 'ران چپ',
      'placementRightThigh' => 'ران راست',
      'placementLeftAbdomen' => 'سمت چپ شکم',
      'placementRightAbdomen' => 'سمت راست شکم',
      'appVersion' => ({required Object version}) => 'نسخه مونا ${version}',
      'checkForUpdates' => 'بررسی به‌روزرسانی',
      'cypionateSuspension' => 'سوسپانسیون سیپونات',
      'medicationTestosteroneCypionateSuspension' =>
        'سوسپانسیون تستوسترون سیپیونات',
      'days' => 'روز',
      'nav_supplies' => 'تدارکات',
      'newUpdateAvailable' => 'بروزرسانی جدید در دسترس است!',
      'goToSettings' => 'به تنظیمات بروید',
      'HrtCounter' => 'مدت زمان هورمون درمانی',
      'HrtCounterDescription' =>
        'مدت زمانی را که تحت هورمون درمانی بوده‌اید و مجموع مقادیر دریافتی شما را نشان می‌دهد.',
      'hrtWidgetPreviewSample' => '۸ ماه هورمون درمانی',
      'hrtWidgetPreviewIntakeSample' => '۱۶ مورد ثبت شده',
      'startOfDay' => 'شروع از روز',
      'schedules' => 'برنامه‌ریزی',
      'noSchedules' => 'بدون برنامه زمانی',
      'scheduling' => 'زمان‌بندی',
      'donate' => 'اهدا کردن',
      'donateDescription' => 'از مونا در Ko-fi حمایت کنید',
      'backupSaved' => 'نسخه پشتیبان ذخیره شد',
      'cannotExceedTotalCapacity' => 'نمی‌توان از ظرفیت کل فراتر رفت',
      'applicationSitesDescription' =>
        'مدیریت سایت‌هایی که بین آنها جابجا می‌شوید',
      'applicationSitesInstructions' =>
        'جاهایی که به‌طور چرخشی از آن‌ها استفاده می‌کنید، مدیریت نمایید. این مکان ها بر اساس سابقهٔ استفادهٔ شما پیشنهاد می‌شوند. برای تغییر ترتیب، آن‌ها را فشار داده و نگه دارید.',
      'suppository' => 'شیاف',
      'transdermalSpray' => 'اسپری پوستی',
      'transdermalDrops' => 'قطره‌ پوستی',
      'deliveryFormPump' => 'پمپ',
      'unitMilligram' => 'میلی‌گرم',
      'unitMicrogramPerDay' => 'µg/day',
      'unitPgPerMl' => 'pg/mL',
      'unitPmolPerL' => 'pmol/L',
      'unitNgPerDl' => 'ng/dL',
      'noIntakesDue' => '­امروز نیاز به مصرف نیست',
      'lastTaken' => 'آخرین بار گرفته شده',
      'scheduleFrequencyDailyDescription' => 'هر روز، در زمان‌های مشخص',
      'scheduleFrequencyInterval' => 'فاصله مصرف',
      'scheduleFrequencyIntervalDescription' => 'هر چند روز یک‌بار',
      'scheduleFrequencyMonthlyDescription' => 'همان روز در هر ماه',
      'scheduleFrequencyAsNeeded' => '­در صورت نیاز',
      'scheduleFrequencyAsNeededDescription' => 'بدون برنامه زمانی ثابت',
      'schedulesAndNotifications' => 'برنامه‌های زمانی و اعلان‌ها',
      'general' => 'عمومی',
      'clickToOpenSettings' => 'برای باز کردن تنظیمات کلیک کنید',
      'exactRemindersDisabled' => 'زمان‌های دقیق یادآوری غیرفعال شده‌اند',
      'remindersDelayed' =>
        'ممکن است یادآوری‌ها با کمی تأخیر همراه باشند. برای باز کردن تنظیمات، ضربه بزنید.',
      'medicalSettings' => 'تنظیمات دارویی',
      'themeVariant' => 'نوع تم',
      'themeContrast' => 'کنتراست',
      'themeContrastStandard' => 'استاندارد',
      'themeContrastMedium' => 'متوسط',
      'themeContrastHigh' => 'بالا',
      'autoUpdate' => 'بروزرسانی خودکار',
      'translateAppDescription' => 'به ترجمه مونا در Weblate کمک کنید',
      'missingTranslation' => 'آیا ترجمه‌ای جا افتاده است؟',
      'checkForUpdatesDescription' =>
        'بررسی دستی برای یافتن آخرین نسخه، این کار شما را به اینترنت متصل می‌کند. (هیچ‌گونه داده‌ای ارسال نخواهد شد)',
      'autoUpdateDescription' =>
        'بررسی خودکار به‌روزرسانی‌های جدید هنگام اجرای برنامه',
      'chooseItem' => 'یک مورد را انتخاب کنید',
      'noItemsToAdd' => 'هیچ موردی موجود نیست',
      'startOfDayDescription' => ({required Object time}) =>
          'زمانِ پیش از ${time} جزو روز قبل محسوب می‌شود',
      'chooseSchedule' => '­یک برنامه زمانی انتخاب کنید',
      'addSchedulesFirst' => 'ابتدا برنامه‌های زمانی را اضافه کنید',
      'editIntake' => 'ویرایش ورودی',
      'date' => 'تاریخ',
      'amount' => 'مقدار',
      'takenAmount' => 'میزان برداشتی',
      'wastedAmount' => 'مقدار هدر رفته',
      'none' => 'هیچ‌کدام',
      'injectionSide' => 'محل تزریق',
      'deleteIntake' => 'این ورودی حذف شود؟',
      'administrationRouteUnitImplant' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'ایمپلنت',
            other: 'ایمپلنت',
          ),
      'administrationRouteUnitGram' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'گرم',
            other: 'گرم',
          ),
      'onHrtForDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک روز تحت هورمون درمانی',
            other: 'به مدت ${count} روز تحت هورمون درمانی',
          ),
      'onHrtForWeeks' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک هفته تحت هورمون درمانی',
            other: '${count} هفته تحت هورمون درمانی',
          ),
      'onHrtForMonths' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک ماه تحت هورمون درمانی',
            other: '${count} ماه تحت هورمون درمانی',
          ),
      'onHrtForYears' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک سال تحت هورمون درمانی',
            other: '${count} سال تحت هورمون درمانی',
          ),
      'administrationRouteUnitMl' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'میلی‌لیتر',
            other: 'میلی‌لیتر',
          ),
      'administrationRouteUnitSachet' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'ساشه',
            other: 'ساشه',
          ),
      'administrationRouteUnitSuppository' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'شیاف',
            other: 'شیاف',
          ),
      'administrationRouteUnitSpray' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'اسپری',
            other: 'اسپری',
          ),
      'administrationRouteUnitPill' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'قرص',
            other: 'قرص',
          ),
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: '${count} روز پیش',
            other: '${count} روز پیش',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'در ${count} روز',
            other: 'در ${count} روز',
          ),
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'هرروز',
            other: 'هر ${count} روز',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'روز ${day}، هر ماه',
            other: '­روز ${day}، هر ماه',
          ),
      _ => null,
    };
  }
}
