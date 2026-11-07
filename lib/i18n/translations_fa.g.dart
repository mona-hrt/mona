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
  String get nav_intakes => 'نوبت های مصرف';
  @override
  String get nav_levels => 'سطح هورمون‌ها';
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
  String get placementRightArm => 'بازوی راست';
  @override
  String get placementLeftArm => 'بازوی چپ';
  @override
  String get progesterone => 'پروژسترون';
  @override
  String get testosterone => 'تستوسترون';
  @override
  String get nandrolone => 'ناندرولون';
  @override
  String get dihydrotestosterone => 'دی‌هیدروتستوسترون';
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
  String get cypionate => 'سیپیونات';
  @override
  String get benzoate => 'بنزوات';
  @override
  String get medicationEstradiolEnanthate => 'استرادیول انانتات';
  @override
  String get medicationEstradiolValerate => 'استرادیول والرات';
  @override
  String get medicationEstradiolCypionate => 'استرادیول سیپیونات';
  @override
  String get medicationEstradiolBenzoate => 'استرادیول بنزوات';
  @override
  String get medicationTestosteroneEnanthate => 'تستوسترون انانتات';
  @override
  String get medicationTestosteroneValerate => 'تستوسترون والرات';
  @override
  String get medicationTestosteroneCypionate => 'تستوسترون سیپیونات';
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
  String get takeAnIntake => 'ثبت نوبت مصرف';
  @override
  String get empty_home => 'با افزودن یک زمان‌بندی در بخش تنظیمات شروع کنید';
  @override
  String get scheduleFrequencyWeekly => 'هفتگی';
  @override
  String get scheduleFrequencyWeeklyDescription => 'روزهای خاصی از هفته';
  @override
  String get scheduleFrequencyMonthly => 'ماهانه';
  @override
  String get language => 'زبان برنامه';
  @override
  String get languageFollowDevice => 'مطابق با زبان دستگاه';
  @override
  String get enableNotifications => 'فعال کردن اعلان';
  @override
  String get upcoming => 'برنامهٔ پیش رو';
  @override
  String get asNeeded => 'در صورت نیاز';
  @override
  String get taken => 'مصرف‌شده';
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
  String get updateAppUpToDate => 'برنامه شما به‌روز است!';
  @override
  String get updateCheckNetworkError =>
      'در حال حاضر نمی توان به روز رسانی را بررسی کرد.';
  @override
  String get importDataSubtitle =>
      'داده‌ها را از یک نسخهٔ پشتیبان JSON بازیابی کنید';
  @override
  String get importDataOverwriteWarning =>
      'این کار تمام داده‌های فعلی شما را با نسخه پشتیبان جایگزین می‌کند. این عمل قابل بازگشت نیست. آیا می‌خواهید ادامه دهید؟';
  @override
  String get reportBug => 'گزارش دادن مشکل';
  @override
  String get neverTakenYet => 'هنوز مصرف نشده';
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
  String get cypionateSuspension => 'سوسپانسیون سیپیونات';
  @override
  String get medicationTestosteroneCypionateSuspension =>
      'سوسپانسیون تستوسترون سیپیونات';
  @override
  String get days => 'روز';
  @override
  String get nav_supplies => 'موجودی داروها';
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
  String get noIntakesDue => 'امروز نیاز به مصرف نیست';
  @override
  String get lastTaken => 'آخرین نوبت مصرف';
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
  String get clickToOpenSettings => 'برای باز کردن تنظیمات ضربه بزنید';
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
  String get editIntake => 'ویرایش نوبت مصرف';
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
  String get irreversibleAction => 'این عمل قابل بازگشت نیست.';
  @override
  String get name => 'نام';
  @override
  String get molecule => 'نام رسمی دارو';
  @override
  String get ester => 'نوع استر';
  @override
  String get decapeptyl => 'دکاپپتیل';
  @override
  String get raloxifene => 'رالوکسیفن';
  @override
  String get pioglitazone => 'پی‌اوگلیتازون';
  @override
  String get medicationEstradiolUndecylate => 'استرادیول آندسیلات';
  @override
  String get medicationTestosteroneUndecylate => 'تستوسترون آندسیلات';
  @override
  String get sublingual => 'زیرزبانی';
  @override
  String get medicationEstradiolCypionateSuspension =>
      'سوسپانسیون استرادیول سیپیونات';
  @override
  String get undecylate => 'آندسیلات';
  @override
  String get applicationSites => 'محل مصرف دارو';
  @override
  String get placementSuggestionPerScheduleDescription =>
      'پیشنهاد محل مصرف دارو بعدی را صرفاً بر اساس سوابق این برنامه زمانی قرار دهید.';
  @override
  String get importDataTitle => 'وارد کردن داده‌ها';
  @override
  String get genericItems => 'وسایل مصرفی';
  @override
  String get totalAmount => 'کل مانده';
  @override
  String get usedAmount => 'مقدار استفاده‌ شده';
  @override
  String deleteItem({required Object name}) => 'آیا ${name} حذف شود؟';
  @override
  String get empty_supplies =>
      'هیچ دارو یا وسیله‌ای ثبت نشده است. برای شروع، یک مورد را اضافه کنید.';
  @override
  String get adminRoute => 'چگونگی مصرف';
  @override
  String get concentration => 'غلظت‌';
  @override
  String get syringe => 'سرنگ‌';
  @override
  String get wipe => 'دستمال‌ مرطوب';
  @override
  String get needle => 'سوزن';
  @override
  String get gloves => 'دستکش‌';
  @override
  String get bandage => 'بانداژ';
  @override
  String get enableNotificationsDescription => 'ارسال یادآوری‌ها';
  @override
  String get anchorToLastIntake => 'محاسبه مجدد بر اساس آخرین میزان دریافتی';
  @override
  String get anchorToLastIntakeDescription =>
      'نوبت بعدی مصرف را دقیقاً به اندازه یک بازه زمانی پس از آخرین باری که دارو را مصرف کردید، تعیین می‌کند.';
  @override
  String get notificationsDisabledTitle => 'اعلان‌ها غیرفعال هستند';
  @override
  String get getInvolved => 'مشارکت کنید';
  @override
  String get reportBugDescription => 'در گیت‌هاب یک issue باز کنید';
  @override
  String get translateApp => 'برنامه را ترجمه کنید';
  @override
  String exportFailed({required Object error}) =>
      'صدور داده‌ها انجام نشد: ${error}';
  @override
  String get closeApp => 'بستن برنامه';
  @override
  String get updateInstallPermissionRequired =>
      'برای نصب به‌روزرسانی‌ها، دادن اجازه لازم است.';
  @override
  String get updateDownloadingTitle => 'در حال دانلود به‌روزرسانی...';
  @override
  String get updateDownloadFailed =>
      'دانلود ناموفق بود. لطفاً اتصال خود را بررسی کنید.';
  @override
  String get newSchedule => 'برنامه زمانی جدید';
  @override
  String get every => 'هر';
  @override
  String get addSchedule => 'یک برنامه زمانی اضافه کنید';
  @override
  String get addScheduleToGetStarted =>
      'برای شروع، یک برنامه زمانی اضافه کنید.';
  @override
  String get addNotification => 'افزودن اعلان';
  @override
  String get empty_intakes => 'موارد مصرف‌شده در اینجا نمایش داده خواهند شد';
  @override
  String get months => 'ماه';
  @override
  String get secretSettings => 'تنظیمات مخفی';
  @override
  String updateFailedOpenInstaller({required Object message}) =>
      'اجرای نصب‌کننده ناموفق بود: ${message}';
  @override
  String notificationMedicationReminderTitle({required Object scheduleName}) =>
      'زمان مصرف ${scheduleName}';
  @override
  String notificationMedicationReminderBodyDate({required Object date}) =>
      'برنامه‌ریزی‌شده برای ${date}';
  @override
  String notificationMedicationReminderBodyTime({required Object time}) =>
      'برنامه‌ریزی‌شده برای ${time}';
  @override
  String notificationMedicationReminderBodyWeekday({required Object weekday}) =>
      'برنامه‌ریزی‌شده برای ${weekday}';
  @override
  String takeMedication({required Object scheduleName}) =>
      '${scheduleName} را انتخاب کنید';
  @override
  String get takeIntake => 'ثبت نوبت مصرف';
  @override
  String get mustBeBetween1And28 => 'باید بین ۱ و ۲۸ باشد';
  @override
  String mustBeAtMost({required Object max}) => 'باید حداکثر ${max} باشد';
  @override
  String get invalidTotalAmount => 'مقدار کل نامعتبر';
  @override
  String get bloodTestDateLabel => 'تاریخ آزمایش خون';
  @override
  String chartBloodTestLevelTooltip(
          {required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String chartLevelTooltip({required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String get needleDeadSpace => 'حجم باقی‌مانده در سوزن و اتصال آن';
  @override
  String get notes => 'یادداشت‌';
  @override
  String get intakeRecorded => 'مصرف دارو ثبت شد';
  @override
  String get addApplicationSite => 'افزودن محل مصرف دارو';
  @override
  String get customSiteLabel => 'نام سفارشی محل مصرف دارو';
  @override
  String get noApplicationSitesYet => 'هنوز محل مصرف دارویی وجود ندارد';
  @override
  String get addSiteToGetStarted =>
      'برای شروع، یک محل مصرف دارو از زیر اضافه کنید.';
  @override
  String get placementSuggestionPerScheduleTitle =>
      'طبق برنامه زمانی پیشنهاد داده شود';
  @override
  String get requiredField => 'فیلد الزامی';
  @override
  String get mustBePositiveNumber => 'باید یک عدد مثبت باشد';
  @override
  String get slimeMode => 'حالت حرکت نرم نمودار';
  @override
  String get dayOfMonth => 'روزِ ماه';
  @override
  String get startDate => 'تاریخ شروع';
  @override
  String get pickATime => 'انتخاب ساعت';
  @override
  String get addIntakeTime => 'افزودن ساعت';
  @override
  String get editScheduleInfo => 'ویرایش اطلاعات زمان‌بندی';
  @override
  String get editSchedule => 'ویرایش زمان‌بندی';
  @override
  String deleteSchedule({required Object name}) => 'آیا ${name} حذف شود؟';
  @override
  String get hrtWidgetPlaceholder =>
      'برای ثبت اولین نوبت مصرف، مونا را باز کنید';
  @override
  String chartNowConcentration({required Object value}) => 'اکنون ${value}';
  @override
  String dosePerUnitLabel({required Object unit}) =>
      'مقدار دارو به‌ازای هر ${unit}';
  @override
  String get editItem => 'ویرایش مورد';
  @override
  String get deliveryForm => 'شکل دارویی';
  @override
  String get deliveryFormGram => 'تیوب';
  @override
  String get supplyItem => 'مورد موجودی';
  @override
  String get genericItemType => 'مورد مصرفی';
  @override
  String get unitNgPerL => 'ng/L';
  @override
  String get unitMicrogramPerL => 'µg/L';
  @override
  String get valueComparisonEqual => 'برابر با';
  @override
  String get valueComparisonAbove => 'مساوی یا بالاتر از آن';
  @override
  String get valueComparisonBelow => 'مساوی یا پایین‌تر از آن';
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
        one: 'هر روز',
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
  @override
  String administrationRouteUnitPatch({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'پچ پوستی',
        other: 'پچ پوستی',
      );
  @override
  String administrationRouteUnitPump({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'پمپ',
        other: 'پمپ',
      );
  @override
  String schedulesCreated({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: '${count} مورد ایجاد شد',
        other: '${count} مورد ایجاد شد',
      );
  @override
  String syringeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک سرنگ باقی‌مانده است',
        other: '${count} سرنگ باقی‌مانده',
      );
  @override
  String wipeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک عدد دستمال مرطوب باقی‌مانده',
        other: '${count} عدد دستمال مرطوب باقی‌مانده',
      );
  @override
  String needleRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک عدد سوزن باقی‌مانده',
        other: '${count} عدد سوزن باقی‌مانده',
      );
  @override
  String glovesRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک عدد دستکش باقی‌مانده',
        other: '${count} عدد دستکش باقی‌مانده',
      );
  @override
  String bandageRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک عدد بانداژ باقی‌مانده',
        other: '${count} عدد بانداژ باقی‌مانده',
      );
  @override
  String remaining({required num count, required Object unit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: '${count} ${unit} باقی‌مانده',
        other: '­${count} ${unit} باقی‌مانده',
      );
  @override
  String intakesLoggedCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
        count,
        one: 'یک نوبت مصرف ثبت شد',
        other: '${count} نوبت مصرف ثبت شد',
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
      'nav_intakes' => 'نوبت های مصرف',
      'nav_levels' => 'سطح هورمون‌ها',
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
      'placementRightArm' => 'بازوی راست',
      'placementLeftArm' => 'بازوی چپ',
      'progesterone' => 'پروژسترون',
      'testosterone' => 'تستوسترون',
      'nandrolone' => 'ناندرولون',
      'dihydrotestosterone' => 'دی‌هیدروتستوسترون',
      'spironolactone' => 'اسپیرونولاکتون',
      'cyproteroneAcetate' => 'سیپروترون استات',
      'leuprorelinAcetate' => 'لوپرورلین استات',
      'bicalutamide' => 'بیکالوتامید',
      'finasteride' => 'فیناستراید',
      'dutasteride' => 'دوتاستراید',
      'minoxidil' => 'ماینوکسیدیل',
      'enanthate' => 'انانتات',
      'valerate' => 'والرات',
      'cypionate' => 'سیپیونات',
      'benzoate' => 'بنزوات',
      'medicationEstradiolEnanthate' => 'استرادیول انانتات',
      'medicationEstradiolValerate' => 'استرادیول والرات',
      'medicationEstradiolCypionate' => 'استرادیول سیپیونات',
      'medicationEstradiolBenzoate' => 'استرادیول بنزوات',
      'medicationTestosteroneEnanthate' => 'تستوسترون انانتات',
      'medicationTestosteroneValerate' => 'تستوسترون والرات',
      'medicationTestosteroneCypionate' => 'تستوسترون سیپیونات',
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
      'takeAnIntake' => 'ثبت نوبت مصرف',
      'empty_home' => 'با افزودن یک زمان‌بندی در بخش تنظیمات شروع کنید',
      'scheduleFrequencyWeekly' => 'هفتگی',
      'scheduleFrequencyWeeklyDescription' => 'روزهای خاصی از هفته',
      'scheduleFrequencyMonthly' => 'ماهانه',
      'language' => 'زبان برنامه',
      'languageFollowDevice' => 'مطابق با زبان دستگاه',
      'enableNotifications' => 'فعال کردن اعلان',
      'upcoming' => 'برنامهٔ پیش رو',
      'asNeeded' => 'در صورت نیاز',
      'taken' => 'مصرف‌شده',
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
      'updateAppUpToDate' => 'برنامه شما به‌روز است!',
      'updateCheckNetworkError' =>
        'در حال حاضر نمی توان به روز رسانی را بررسی کرد.',
      'importDataSubtitle' =>
        'داده‌ها را از یک نسخهٔ پشتیبان JSON بازیابی کنید',
      'importDataOverwriteWarning' =>
        'این کار تمام داده‌های فعلی شما را با نسخه پشتیبان جایگزین می‌کند. این عمل قابل بازگشت نیست. آیا می‌خواهید ادامه دهید؟',
      'reportBug' => 'گزارش دادن مشکل',
      'neverTakenYet' => 'هنوز مصرف نشده',
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
      'cypionateSuspension' => 'سوسپانسیون سیپیونات',
      'medicationTestosteroneCypionateSuspension' =>
        'سوسپانسیون تستوسترون سیپیونات',
      'days' => 'روز',
      'nav_supplies' => 'موجودی داروها',
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
      'noIntakesDue' => 'امروز نیاز به مصرف نیست',
      'lastTaken' => 'آخرین نوبت مصرف',
      'scheduleFrequencyDailyDescription' => 'هر روز، در زمان‌های مشخص',
      'scheduleFrequencyInterval' => 'فاصله مصرف',
      'scheduleFrequencyIntervalDescription' => 'هر چند روز یک‌بار',
      'scheduleFrequencyMonthlyDescription' => 'همان روز در هر ماه',
      'scheduleFrequencyAsNeeded' => '­در صورت نیاز',
      'scheduleFrequencyAsNeededDescription' => 'بدون برنامه زمانی ثابت',
      'schedulesAndNotifications' => 'برنامه‌های زمانی و اعلان‌ها',
      'general' => 'عمومی',
      'clickToOpenSettings' => 'برای باز کردن تنظیمات ضربه بزنید',
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
      'editIntake' => 'ویرایش نوبت مصرف',
      'date' => 'تاریخ',
      'amount' => 'مقدار',
      'takenAmount' => 'میزان برداشتی',
      'wastedAmount' => 'مقدار هدر رفته',
      'none' => 'هیچ‌کدام',
      'injectionSide' => 'محل تزریق',
      'deleteIntake' => 'این ورودی حذف شود؟',
      'irreversibleAction' => 'این عمل قابل بازگشت نیست.',
      'name' => 'نام',
      'molecule' => 'نام رسمی دارو',
      'ester' => 'نوع استر',
      'decapeptyl' => 'دکاپپتیل',
      'raloxifene' => 'رالوکسیفن',
      'pioglitazone' => 'پی‌اوگلیتازون',
      'medicationEstradiolUndecylate' => 'استرادیول آندسیلات',
      'medicationTestosteroneUndecylate' => 'تستوسترون آندسیلات',
      'sublingual' => 'زیرزبانی',
      'medicationEstradiolCypionateSuspension' =>
        'سوسپانسیون استرادیول سیپیونات',
      'undecylate' => 'آندسیلات',
      'applicationSites' => 'محل مصرف دارو',
      'placementSuggestionPerScheduleDescription' =>
        'پیشنهاد محل مصرف دارو بعدی را صرفاً بر اساس سوابق این برنامه زمانی قرار دهید.',
      'importDataTitle' => 'وارد کردن داده‌ها',
      'genericItems' => 'وسایل مصرفی',
      'totalAmount' => 'کل مانده',
      'usedAmount' => 'مقدار استفاده‌ شده',
      'deleteItem' => ({required Object name}) => 'آیا ${name} حذف شود؟',
      'empty_supplies' =>
        'هیچ دارو یا وسیله‌ای ثبت نشده است. برای شروع، یک مورد را اضافه کنید.',
      'adminRoute' => 'چگونگی مصرف',
      'concentration' => 'غلظت‌',
      'syringe' => 'سرنگ‌',
      'wipe' => 'دستمال‌ مرطوب',
      'needle' => 'سوزن',
      'gloves' => 'دستکش‌',
      'bandage' => 'بانداژ',
      'enableNotificationsDescription' => 'ارسال یادآوری‌ها',
      'anchorToLastIntake' => 'محاسبه مجدد بر اساس آخرین میزان دریافتی',
      'anchorToLastIntakeDescription' =>
        'نوبت بعدی مصرف را دقیقاً به اندازه یک بازه زمانی پس از آخرین باری که دارو را مصرف کردید، تعیین می‌کند.',
      'notificationsDisabledTitle' => 'اعلان‌ها غیرفعال هستند',
      'getInvolved' => 'مشارکت کنید',
      'reportBugDescription' => 'در گیت‌هاب یک issue باز کنید',
      'translateApp' => 'برنامه را ترجمه کنید',
      'exportFailed' => ({required Object error}) =>
          'صدور داده‌ها انجام نشد: ${error}',
      'closeApp' => 'بستن برنامه',
      'updateInstallPermissionRequired' =>
        'برای نصب به‌روزرسانی‌ها، دادن اجازه لازم است.',
      'updateDownloadingTitle' => 'در حال دانلود به‌روزرسانی...',
      'updateDownloadFailed' =>
        'دانلود ناموفق بود. لطفاً اتصال خود را بررسی کنید.',
      'newSchedule' => 'برنامه زمانی جدید',
      'every' => 'هر',
      'addSchedule' => 'یک برنامه زمانی اضافه کنید',
      'addScheduleToGetStarted' => 'برای شروع، یک برنامه زمانی اضافه کنید.',
      'addNotification' => 'افزودن اعلان',
      'empty_intakes' => 'موارد مصرف‌شده در اینجا نمایش داده خواهند شد',
      'months' => 'ماه',
      'secretSettings' => 'تنظیمات مخفی',
      'updateFailedOpenInstaller' => ({required Object message}) =>
          'اجرای نصب‌کننده ناموفق بود: ${message}',
      'notificationMedicationReminderTitle' =>
        ({required Object scheduleName}) => 'زمان مصرف ${scheduleName}',
      'notificationMedicationReminderBodyDate' => ({required Object date}) =>
          'برنامه‌ریزی‌شده برای ${date}',
      'notificationMedicationReminderBodyTime' => ({required Object time}) =>
          'برنامه‌ریزی‌شده برای ${time}',
      'notificationMedicationReminderBodyWeekday' =>
        ({required Object weekday}) => 'برنامه‌ریزی‌شده برای ${weekday}',
      'takeMedication' => ({required Object scheduleName}) =>
          '${scheduleName} را انتخاب کنید',
      'takeIntake' => 'ثبت نوبت مصرف',
      'mustBeBetween1And28' => 'باید بین ۱ و ۲۸ باشد',
      'mustBeAtMost' => ({required Object max}) => 'باید حداکثر ${max} باشد',
      'invalidTotalAmount' => 'مقدار کل نامعتبر',
      'bloodTestDateLabel' => 'تاریخ آزمایش خون',
      'chartBloodTestLevelTooltip' =>
        ({required Object date, required Object level}) => '${date}: ${level}',
      'chartLevelTooltip' => ({required Object date, required Object level}) =>
          '${date}: ${level}',
      'needleDeadSpace' => 'حجم باقی‌مانده در سوزن و اتصال آن',
      'notes' => 'یادداشت‌',
      'intakeRecorded' => 'مصرف دارو ثبت شد',
      'addApplicationSite' => 'افزودن محل مصرف دارو',
      'customSiteLabel' => 'نام سفارشی محل مصرف دارو',
      'noApplicationSitesYet' => 'هنوز محل مصرف دارویی وجود ندارد',
      'addSiteToGetStarted' => 'برای شروع، یک محل مصرف دارو از زیر اضافه کنید.',
      'placementSuggestionPerScheduleTitle' =>
        'طبق برنامه زمانی پیشنهاد داده شود',
      'requiredField' => 'فیلد الزامی',
      'mustBePositiveNumber' => 'باید یک عدد مثبت باشد',
      'slimeMode' => 'حالت حرکت نرم نمودار',
      'dayOfMonth' => 'روزِ ماه',
      'startDate' => 'تاریخ شروع',
      'pickATime' => 'انتخاب ساعت',
      'addIntakeTime' => 'افزودن ساعت',
      'editScheduleInfo' => 'ویرایش اطلاعات زمان‌بندی',
      'editSchedule' => 'ویرایش زمان‌بندی',
      'deleteSchedule' => ({required Object name}) => 'آیا ${name} حذف شود؟',
      'hrtWidgetPlaceholder' => 'برای ثبت اولین نوبت مصرف، مونا را باز کنید',
      'chartNowConcentration' => ({required Object value}) => 'اکنون ${value}',
      'dosePerUnitLabel' => ({required Object unit}) =>
          'مقدار دارو به‌ازای هر ${unit}',
      'editItem' => 'ویرایش مورد',
      'deliveryForm' => 'شکل دارویی',
      'deliveryFormGram' => 'تیوب',
      'supplyItem' => 'مورد موجودی',
      'genericItemType' => 'مورد مصرفی',
      'unitNgPerL' => 'ng/L',
      'unitMicrogramPerL' => 'µg/L',
      'valueComparisonEqual' => 'برابر با',
      'valueComparisonAbove' => 'مساوی یا بالاتر از آن',
      'valueComparisonBelow' => 'مساوی یا پایین‌تر از آن',
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
            one: 'هر روز',
            other: 'هر ${count} روز',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'روز ${day}، هر ماه',
            other: '­روز ${day}، هر ماه',
          ),
      'administrationRouteUnitPatch' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'پچ پوستی',
            other: 'پچ پوستی',
          ),
      'administrationRouteUnitPump' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'پمپ',
            other: 'پمپ',
          ),
      'schedulesCreated' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: '${count} مورد ایجاد شد',
            other: '${count} مورد ایجاد شد',
          ),
      'syringeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک سرنگ باقی‌مانده است',
            other: '${count} سرنگ باقی‌مانده',
          ),
      'wipeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک عدد دستمال مرطوب باقی‌مانده',
            other: '${count} عدد دستمال مرطوب باقی‌مانده',
          ),
      'needleRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک عدد سوزن باقی‌مانده',
            other: '${count} عدد سوزن باقی‌مانده',
          ),
      'glovesRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک عدد دستکش باقی‌مانده',
            other: '${count} عدد دستکش باقی‌مانده',
          ),
      'bandageRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک عدد بانداژ باقی‌مانده',
            other: '${count} عدد بانداژ باقی‌مانده',
          ),
      'remaining' => ({required num count, required Object unit}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: '${count} ${unit} باقی‌مانده',
            other: '­${count} ${unit} باقی‌مانده',
          ),
      'intakesLoggedCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fa'))(
            count,
            one: 'یک نوبت مصرف ثبت شد',
            other: '${count} نوبت مصرف ثبت شد',
          ),
      _ => null,
    };
  }
}
