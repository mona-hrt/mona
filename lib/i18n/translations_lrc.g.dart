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
class TranslationsLrc extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsLrc(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.lrc,
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

  /// Metadata for the translations of <lrc>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsLrc _root = this; // ignore: unused_field

  @override
  TranslationsLrc $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsLrc(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'مونا';
  @override
  String get nav_home => 'مونا';
  @override
  String get nav_intakes => 'نوبت‌های مصرف';
  @override
  String get nav_levels => 'سطح هورمون‌ها';
  @override
  String get nav_supplies => 'موجودی دواها';
  @override
  String get takeAnIntake => 'ثبت نوبت مصرف';
  @override
  String get addAnItem => 'یه مورد اضافه بکنین';
  @override
  String get empty_home => 'سی شروع، از تنظیمات یه وقت‌بندی اضافه بکنین';
  @override
  String get allDone => 'تموم بی!';
  @override
  String get noIntakesDue => 'امرو نوبت مصرف نیه';
  @override
  String get upcoming => 'پیش رو';
  @override
  String get asNeeded => 'موقع نیاز';
  @override
  String get taken => 'مصرف‌بیه';
  @override
  String get yesterday => 'دیرو';
  @override
  String get tomorrow => 'سوا';
  @override
  String get lastTaken => 'آخرین مصرف';
  @override
  String get neverTakenYet => 'هنی مصرف نشده';
  @override
  String get scheduleFrequencyDaily => 'هر روز';
  @override
  String get scheduleFrequencyDailyDescription => 'هر روز، سر ساعت‌های مشخص';
  @override
  String get scheduleFrequencyInterval => 'فاصله‌دار';
  @override
  String get scheduleFrequencyIntervalDescription => 'هر چند روز یه بار';
  @override
  String get scheduleFrequencyWeekly => 'هفتگی';
  @override
  String get scheduleFrequencyWeeklyDescription => 'روزهای مشخصی از هفته';
  @override
  String get scheduleFrequencyMonthly => 'ماهانه';
  @override
  String get scheduleFrequencyMonthlyDescription => 'همون روز، هر ماه';
  @override
  String get scheduleFrequencyAsNeeded => 'موقع نیاز';
  @override
  String get scheduleFrequencyAsNeededDescription => 'بی وقت‌بندی ثابت';
  @override
  String get newUpdateAvailable => 'یه به‌روزرسانی تازه هس!';
  @override
  String get goToSettings => 'برین به تنظیمات';
  @override
  String get settingsTitle => 'تنظیمات';
  @override
  String get notifications => 'اعلان‌ها';
  @override
  String get schedulesAndNotifications => 'وقت‌بندی و اعلان‌ها';
  @override
  String get general => 'عمومی';
  @override
  String get schedules => 'وقت‌بندی مصرف دوا';
  @override
  String get noSchedules => 'وقت‌بندی نیه';
  @override
  String get language => 'زبان برنامه';
  @override
  String get languageFollowDevice => 'همون زبان گوشی';
  @override
  String get enableNotifications => 'روشن کردن اعلان‌ها';
  @override
  String get enableNotificationsDescription => 'فرستادن یادآوری';
  @override
  String get anchorToLastIntake => 'حساب دوباره از آخرین مصرف';
  @override
  String get anchorToLastIntakeDescription =>
      'نوبت بعدی درست یه فاصلهٔ کامل بعد از آخرین مصرف می‌افته.';
  @override
  String get notificationsDisabledTitle => 'اعلان‌ها خاموشن';
  @override
  String get clickToOpenSettings => 'سی باز کردن تنظیمات بزنین';
  @override
  String get exactRemindersDisabled => 'یادآوری سر ساعت دقیق خاموش هس';
  @override
  String get remindersDelayed =>
      'ممکنه یادآوری‌ها یه کم با تأخیر بیاد. سی باز کردن تنظیمات بزنین.';
  @override
  String get medicalSettings => 'تنظیمات دوایی';
  @override
  String get theme => 'تم';
  @override
  String get themeCustomizeColors => 'سی دلخواه کردن رنگ‌های برنامه';
  @override
  String get customThemeEnabled => 'تم دست‌ساز';
  @override
  String get themeGenerate => 'ساختن';
  @override
  String get themeVariant => 'جور تم';
  @override
  String get themeContrast => 'کنتراست';
  @override
  String get themeContrastStandard => 'معمولی';
  @override
  String get themeContrastMedium => 'متوسط';
  @override
  String get themeContrastHigh => 'زیاد';
  @override
  String get autoUpdate => 'به‌روزرسانی خودکار';
  @override
  String get autoUpdateDescription =>
      'هر وخت برنامه باز ببو، خودش چک کنه به‌روزرسانی تازه هس یا نه';
  @override
  String get checkForUpdates => 'چک کردن به‌روزرسانی';
  @override
  String get checkForUpdatesDescription =>
      'آخرین نسخه خودتون چک بکنین. با این کار وصل اینترنت می‌بوین. (هیچ داده‌ای فرستاده نمی‌بو)';
  @override
  String appVersion({required Object version}) => 'نسخهٔ مونا ${version}';
  @override
  String get getInvolved => 'همراهی بکنین';
  @override
  String get reportBug => 'گزارش اشکال';
  @override
  String get reportBugDescription => 'توی گیت‌هاب یه issue باز بکنین';
  @override
  String get translateApp => 'برنامه ترجمه بکنین';
  @override
  String get translateAppDescription => 'توی Weblate به ترجمهٔ مونا کمک بکنین';
  @override
  String get missingTranslation => 'ترجمه‌ای جامونده؟';
  @override
  String get donate => 'اهدا کردن';
  @override
  String get donateDescription => 'توی Ko-fi از مونا حمایت بکنین';
  @override
  String get backupSaved => 'نسخهٔ پشتیبان ذخیره بی';
  @override
  String exportFailed({required Object error}) => 'خروجی گرفتن نشد: ${error}';
  @override
  String get importDataTitle => 'وارد کردن داده‌ها';
  @override
  String get importDataSubtitle => 'برگردوندن داده‌ها از یه پشتیبان JSON';
  @override
  String get importDataOverwriteWarning =>
      'این کار همهٔ داده‌هایی که ایسه دارید با نسخهٔ پشتیبان عوض می‌کنه. این کار واپس نمی‌گرده. ادامه می‌دین؟';
  @override
  String get importConfirm => 'وارد کردن';
  @override
  String get importSuccessfulTitle => 'وارد کردن درست انجام بی';
  @override
  String get importRestartRequired =>
      'تا داده‌هایی که برگردوندین بیاد سرجاش، برنامه ببندین و دوباره باز بکنین.';
  @override
  String get closeApp => 'بستن برنامه';
  @override
  String importFailed({required Object error}) => 'وارد کردن نشد: ${error}';
  @override
  String get updates => 'به‌روزرسانی‌ها';
  @override
  String get dataManagement => 'کار با داده‌ها';
  @override
  String get exportDataTitle => 'خروجی گرفتن از داده‌ها';
  @override
  String get exportDataSubtitle =>
      'ذخیره کردن داده‌های خودتون توی یه فایل JSON';
  @override
  String get units => 'واحدها';
  @override
  String get updateNoCompatibleApk => 'به‌روزرسانی جور دستگاه شما پیدا نشد.';
  @override
  String get updateAppUpToDate => 'برنامهٔ شما به‌روز هس!';
  @override
  String get updateCheckNetworkError => 'ایسه نمی‌تونیم به‌روزرسانی چک بکنیم.';
  @override
  String get updateDialogTitle => 'به‌روزرسانی هس';
  @override
  String updateDialogBody({required Object latest, required Object current}) =>
      'نسخهٔ ${latest} آماده هس! (نسخهٔ ایسه: ${current})\nیه به‌روزرسانی جور دستگاه شما آمادهٔ نصب هس.';
  @override
  String get updateDownloadAndInstall => 'دانلود و نصب';
  @override
  String get updateInstallPermissionRequired =>
      'سی نصب به‌روزرسانی اجازه لازمه.';
  @override
  String get updateDownloadingTitle => 'به‌روزرسانی داره دانلود می‌بو...';
  @override
  String updateFailedOpenInstaller({required Object message}) =>
      'نصب‌کننده باز نشد: ${message}';
  @override
  String get updateDownloadFailed => 'دانلود نشد. اتصال اینترنت چک بکنین.';
  @override
  String get secretSettings => 'تنظیمات قایم';
  @override
  String get slimeMode => 'حالت حرکت نرم نمودار';
  @override
  String notificationMedicationReminderTitle({required Object scheduleName}) =>
      'وقت مصرف ${scheduleName}';
  @override
  String notificationMedicationReminderBodyDate({required Object date}) =>
      'سی ${date} وقت‌بندی بیه';
  @override
  String notificationMedicationReminderBodyTime({required Object time}) =>
      'سی ${time} وقت‌بندی بیه';
  @override
  String notificationMedicationReminderBodyWeekday({required Object weekday}) =>
      'سی ${weekday} وقت‌بندی بیه';
  @override
  String get addSchedule => 'یه برنامهٔ مصرف اضافه بکنین';
  @override
  String get addScheduleToGetStarted => 'سی شروع، یه وقت‌بندی اضافه بکنین.';
  @override
  String get newSchedule => 'وقت‌بندی تازه';
  @override
  String get every => 'هر';
  @override
  String get days => 'روز';
  @override
  String get dayOfMonth => 'روز ماه';
  @override
  String get months => 'ماه';
  @override
  String get startDate => 'تاریخ شروع';
  @override
  String get pickATime => 'انتخاب ساعت';
  @override
  String get addIntakeTime => 'اضافه کردن ساعت';
  @override
  String get editScheduleInfo => 'ویرایش اطلاعات وقت‌بندی';
  @override
  String get scheduling => 'وقت‌بندی';
  @override
  String get editSchedule => 'ویرایش وقت‌بندی';
  @override
  String deleteSchedule({required Object name}) => '${name} پاک ببو؟';
  @override
  String get addNotification => 'اضافه کردن اعلان';
  @override
  String get empty_intakes => 'نوبت‌های مصرف‌بیه ایچه نشون داده می‌بون';
  @override
  String get HrtCounter => 'مدت هورمون‌درمانی';
  @override
  String get HrtCounterDescription =>
      'نشون می‌ده از شروع هورمون‌درمانی شما چقدر گذشته و روی هم چند نوبت مصرف ثبت بیه.';
  @override
  String get hrtWidgetPlaceholder => 'سی ثبت اولین نوبت مصرف، مونا باز بکنین';
  @override
  String get hrtWidgetPreviewSample => '۸ ماه هورمون‌درمانی';
  @override
  String get hrtWidgetPreviewIntakeSample => '۱۶ نوبت ثبت‌بیه';
  @override
  String get startOfDay => 'روز تازه از چه ساعتی شروع می‌بو؟';
  @override
  String startOfDayDescription({required Object time}) =>
      'ساعت‌های پیش از ${time} جزو روز قبل حساب می‌بو.';
  @override
  String get chooseSchedule => 'یه وقت‌بندی انتخاب بکنین';
  @override
  String get addSchedulesFirst => 'اول از داخل تنظیمات وقت‌بندی اضافه بکنین.';
  @override
  String get editIntake => 'ویرایش نوبت مصرف';
  @override
  String get date => 'تاریخ';
  @override
  String get amount => 'مقدار';
  @override
  String get takenAmount => 'مقدار مصرف‌بیه';
  @override
  String get wastedAmount => 'مقدار هدررفته';
  @override
  String get none => 'هیچ‌کدوم';
  @override
  String get supplyItem => 'مورد موجودی';
  @override
  String get chooseItem => 'یه مورد انتخاب بکنین';
  @override
  String get noItemsToAdd => 'موردی نیه';
  @override
  String get injectionSide => 'جای تزریق';
  @override
  String get deleteIntake => 'این نوبت پاک ببو؟';
  @override
  String takeMedication({required Object scheduleName}) =>
      'ثبت مصرف ${scheduleName}';
  @override
  String get takeIntake => 'ثبت نوبت مصرف';
  @override
  String get intakeRecorded => 'مصرف دوا ثبت بی';
  @override
  String get needleDeadSpace => 'حجم فضای مردهٔ سوزن';
  @override
  String get notes => 'یادداشت‌ها';
  @override
  String get injectionType => 'جور تزریق';
  @override
  String get intramuscular => 'تو ماهیچه';
  @override
  String get subcutaneous => 'زیر پوست';
  @override
  String get microliters => 'μL';
  @override
  String get milliliters => 'mL';
  @override
  String get empty_levels =>
      'سی شروع، یه آزمایش خون اضافه بکنین یا تزریق استرادیول ثبت بکنین';
  @override
  String get bloodTestsTitle => 'آزمایش‌های خون شما';
  @override
  String get estradiolLevelsTitle => 'سطح استرادیول';
  @override
  String get week => 'هفته';
  @override
  String get twoWeeks => 'دو هفته';
  @override
  String get threeMonths => 'سه ماه';
  @override
  String get sixMonths => 'شش ماه';
  @override
  String get month => 'ماه';
  @override
  String get year => 'سال';
  @override
  String get empty_blood_tests =>
      'آزمایش‌های خون ایچه می‌آد. با دکمهٔ اضافه کردن شروع بکنین!';
  @override
  String get addBloodTest => 'اضافه کردن آزمایش خون';
  @override
  String get editBloodTest => 'ویرایش آزمایش خون';
  @override
  String get newBloodTest => 'آزمایش خون تازه';
  @override
  String get deleteBloodTest => 'این آزمایش خون پاک ببو؟';
  @override
  String get estradiolLevelLabel => 'سطح استرادیول';
  @override
  String get testosteroneLevelLabel => 'سطح تستوسترون';
  @override
  String get bloodTestDateLabel => 'تاریخ آزمایش';
  @override
  String chartNowConcentration({required Object value}) => 'ایسه ${value}';
  @override
  String chartBloodTestLevelTooltip(
          {required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String chartLevelTooltip({required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String get empty_supplies =>
      'دوا یا وسیله‌ای ثبت نشده. سی شروع یه مورد اضافه بکنین.';
  @override
  String get newItem => 'مورد تازه';
  @override
  String get adminRoute => 'روش مصرف';
  @override
  String get totalAmount => 'مقدار کل';
  @override
  String get concentration => 'غلظت';
  @override
  String dosePerUnitLabel({required Object unit}) => 'مقدار دوا سی هر ${unit}';
  @override
  String get editItem => 'ویرایش مورد';
  @override
  String get usedAmount => 'مقدار استفاده‌بیه';
  @override
  String deleteItem({required Object name}) => '${name} پاک ببو؟';
  @override
  String get allItemsFilter => 'همه';
  @override
  String get medicationItemsFilter => 'دوا';
  @override
  String get genericItems => 'وسایل مصرفی';
  @override
  String get medicationItemType => 'دوا';
  @override
  String get genericItemType => 'وسیلهٔ مصرفی';
  @override
  String get supplyType => 'جور';
  @override
  String get syringe => 'سرنگ';
  @override
  String get wipe => 'دستمال مرطوب';
  @override
  String get needle => 'سوزن';
  @override
  String get gloves => 'دستکش';
  @override
  String get bandage => 'بانداژ';
  @override
  String get add => 'اضافه کردن';
  @override
  String get save => 'ذخیره';
  @override
  String get cancel => 'ول کردن';
  @override
  String get next => 'بعدی';
  @override
  String get delete => 'پاک کردن';
  @override
  String get deleteElement => 'این مورد پاک ببو؟';
  @override
  String get irreversibleAction => 'این کار واپس نمی‌گرده.';
  @override
  String get name => 'نوم';
  @override
  String get molecule => 'نوم ژنریک دوا';
  @override
  String get ester => 'جور استر';
  @override
  String get estradiol => 'استرادیول';
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
  String get decapeptyl => 'دکاپپتیل';
  @override
  String get raloxifene => 'رالوکسیفن';
  @override
  String get tamoxifen => 'تاموکسیفن';
  @override
  String get finasteride => 'فیناستراید';
  @override
  String get dutasteride => 'دوتاستراید';
  @override
  String get minoxidil => 'ماینوکسیدیل';
  @override
  String get pioglitazone => 'پیوگلیتازون';
  @override
  String get enanthate => 'انانتات';
  @override
  String get valerate => 'والرات';
  @override
  String get cypionate => 'سیپیونات';
  @override
  String get undecylate => 'آندسیلات';
  @override
  String get benzoate => 'بنزوات';
  @override
  String get cypionateSuspension => 'سوسپانسیون سیپیونات';
  @override
  String get medicationEstradiolEnanthate => 'استرادیول انانتات';
  @override
  String get medicationEstradiolValerate => 'استرادیول والرات';
  @override
  String get medicationEstradiolCypionate => 'استرادیول سیپیونات';
  @override
  String get medicationEstradiolUndecylate => 'استرادیول آندسیلات';
  @override
  String get medicationEstradiolBenzoate => 'استرادیول بنزوات';
  @override
  String get medicationEstradiolCypionateSuspension =>
      'سوسپانسیون استرادیول سیپیونات';
  @override
  String get medicationTestosteroneEnanthate => 'تستوسترون انانتات';
  @override
  String get medicationTestosteroneValerate => 'تستوسترون والرات';
  @override
  String get medicationTestosteroneCypionate => 'تستوسترون سیپیونات';
  @override
  String get medicationTestosteroneUndecylate => 'تستوسترون آندسیلات';
  @override
  String get medicationTestosteroneBenzoate => 'تستوسترون بنزوات';
  @override
  String get medicationTestosteroneCypionateSuspension =>
      'سوسپانسیون تستوسترون سیپیونات';
  @override
  String get injection => 'تزریقی';
  @override
  String get oral => 'خوراکی';
  @override
  String get sublingual => 'زیر زوون';
  @override
  String get patch => 'پچ';
  @override
  String get gel => 'ژل';
  @override
  String get implant => 'ایمپلنت';
  @override
  String get suppository => 'شیاف';
  @override
  String get transdermalSpray => 'اسپری پوستی';
  @override
  String get transdermalDrops => 'قطرهٔ پوستی';
  @override
  String get deliveryForm => 'شکل دوا';
  @override
  String get deliveryFormPump => 'پمپ';
  @override
  String get deliveryFormSachet => 'ساشه';
  @override
  String get deliveryFormGram => 'تیوب';
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
  String get unitNmolPerL => 'nmol/L';
  @override
  String get unitNgPerMl => 'ng/mL';
  @override
  String get unitNgPerL => 'ng/L';
  @override
  String get unitMicrogramPerL => 'µg/L';
  @override
  String get valueComparisonEqual => 'برابر وا';
  @override
  String get valueComparisonBelow => 'کمتر یا برابر';
  @override
  String get valueComparisonAbove => 'بیشتر یا برابر';
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
  String get placementLeftArm => 'بازوی چپ';
  @override
  String get placementRightArm => 'بازوی راست';
  @override
  String get placementLeftButtock => 'باسن چپ';
  @override
  String get placementRightButtock => 'باسن راست';
  @override
  String get placementLeftAbdomen => 'سمت چپ شکم';
  @override
  String get placementRightAbdomen => 'سمت راست شکم';
  @override
  String get applicationSites => 'جای مصرف دوا';
  @override
  String get applicationSitesDescription =>
      'جاهایی که نوبتی روشون دوا می‌زنین تنظیم بکنین.';
  @override
  String get applicationSitesInstructions =>
      'جاهایی که نوبتی روشون دوا می‌زنین تنظیم بکنین. پیشنهاد جا از سابقهٔ مصرف شما درمی‌آد. سی عوض کردن ترتیب، انگشت روشون نگه دارین.';
  @override
  String get addApplicationSite => 'اضافه کردن جا';
  @override
  String get customSiteLabel => 'نوم دلخواه جای مصرف';
  @override
  String get noApplicationSitesYet => 'هنی جایی ثبت نشده';
  @override
  String get addSiteToGetStarted => 'سی شروع، از پایین یه جا اضافه بکنین.';
  @override
  String get placementSuggestionPerScheduleTitle =>
      'پیشنهاد جدا سی هر وقت‌بندی';
  @override
  String get placementSuggestionPerScheduleDescription =>
      'پیشنهاد جای بعدی فقط از سابقهٔ همین وقت‌بندی بیاد.';
  @override
  String get requiredField => 'باید پر ببو';
  @override
  String get mustBePositiveNumber => 'باید یه عدد مثبت بو';
  @override
  String get mustBeBetween1And28 => 'باید بین ۱ و ۲۸ بو';
  @override
  String mustBeAtMost({required Object max}) => 'نباید از ${max} بیشتر بو';
  @override
  String get invalidTotalAmount => 'مقدار کل درست نیه';
  @override
  String get cannotExceedTotalCapacity => 'نمی‌بو از ظرفیت کل بیشتر بو';
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: '${count} روز پیش',
        other: '${count} روز پیش',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: '${count} روز دیگه',
        other: '${count} روز دیگه',
      );
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'هر روز',
        other: 'هر ${count} روز یه بار',
      );
  @override
  String scheduleFrequencyOnDayEveryNMonths(
          {required num count, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'روز ${day}، هر ماه',
        other: 'روز ${day}، هر ${count} ماه یه بار',
      );
  @override
  String schedulesCreated({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: '${count} تا ساخته بی',
        other: '${count} تا ساخته بی',
      );
  @override
  String onHrtForDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه روز از شروع هورمون‌درمانی شما رد بیه',
        other: '${count} روز از شروع هورمون‌درمانی شما رد بیه',
      );
  @override
  String onHrtForWeeks({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه هفته از شروع هورمون‌درمانی شما رد بیه',
        other: '${count} هفته از شروع هورمون‌درمانی شما رد بیه',
      );
  @override
  String onHrtForMonths({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه ماه از شروع هورمون‌درمانی شما رد بیه',
        other: '${count} ماه از شروع هورمون‌درمانی شما رد بیه',
      );
  @override
  String onHrtForYears({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه سال از شروع هورمون‌درمانی شما رد بیه',
        other: '${count} سال از شروع هورمون‌درمانی شما رد بیه',
      );
  @override
  String intakesLoggedCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه نوبت مصرف ثبت بی',
        other: '${count} نوبت مصرف ثبت بی',
      );
  @override
  String remaining({required num count, required Object unit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: '${count} ${unit} مونده',
        other: '${count} ${unit} مونده',
      );
  @override
  String syringeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه سرنگ مونده',
        other: '${count} سرنگ مونده',
      );
  @override
  String wipeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه دستمال مرطوب مونده',
        other: '${count} دستمال مرطوب مونده',
      );
  @override
  String needleRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه سوزن مونده',
        other: '${count} سوزن مونده',
      );
  @override
  String glovesRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه دستکش مونده',
        other: '${count} دستکش مونده',
      );
  @override
  String bandageRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'یه بانداژ مونده',
        other: '${count} بانداژ مونده',
      );
  @override
  String administrationRouteUnitMl({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'میلی‌لیتر',
        other: 'میلی‌لیتر',
      );
  @override
  String administrationRouteUnitPill({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'قرص',
        other: 'قرص',
      );
  @override
  String administrationRouteUnitPatch({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'پچ پوستی',
        other: 'پچ پوستی',
      );
  @override
  String administrationRouteUnitPump({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'پمپ',
        other: 'پمپ',
      );
  @override
  String administrationRouteUnitSachet({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'ساشه',
        other: 'ساشه',
      );
  @override
  String administrationRouteUnitGram({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'گرم',
        other: 'گرم',
      );
  @override
  String administrationRouteUnitImplant({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'ایمپلنت',
        other: 'ایمپلنت',
      );
  @override
  String administrationRouteUnitSuppository({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'شیاف',
        other: 'شیاف',
      );
  @override
  String administrationRouteUnitSpray({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
        count,
        one: 'اسپری',
        other: 'اسپری',
      );
}

/// The flat map containing all translations for locale <lrc>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsLrc {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'مونا',
      'nav_home' => 'مونا',
      'nav_intakes' => 'نوبت‌های مصرف',
      'nav_levels' => 'سطح هورمون‌ها',
      'nav_supplies' => 'موجودی دواها',
      'takeAnIntake' => 'ثبت نوبت مصرف',
      'addAnItem' => 'یه مورد اضافه بکنین',
      'empty_home' => 'سی شروع، از تنظیمات یه وقت‌بندی اضافه بکنین',
      'allDone' => 'تموم بی!',
      'noIntakesDue' => 'امرو نوبت مصرف نیه',
      'upcoming' => 'پیش رو',
      'asNeeded' => 'موقع نیاز',
      'taken' => 'مصرف‌بیه',
      'yesterday' => 'دیرو',
      'tomorrow' => 'سوا',
      'lastTaken' => 'آخرین مصرف',
      'neverTakenYet' => 'هنی مصرف نشده',
      'scheduleFrequencyDaily' => 'هر روز',
      'scheduleFrequencyDailyDescription' => 'هر روز، سر ساعت‌های مشخص',
      'scheduleFrequencyInterval' => 'فاصله‌دار',
      'scheduleFrequencyIntervalDescription' => 'هر چند روز یه بار',
      'scheduleFrequencyWeekly' => 'هفتگی',
      'scheduleFrequencyWeeklyDescription' => 'روزهای مشخصی از هفته',
      'scheduleFrequencyMonthly' => 'ماهانه',
      'scheduleFrequencyMonthlyDescription' => 'همون روز، هر ماه',
      'scheduleFrequencyAsNeeded' => 'موقع نیاز',
      'scheduleFrequencyAsNeededDescription' => 'بی وقت‌بندی ثابت',
      'newUpdateAvailable' => 'یه به‌روزرسانی تازه هس!',
      'goToSettings' => 'برین به تنظیمات',
      'settingsTitle' => 'تنظیمات',
      'notifications' => 'اعلان‌ها',
      'schedulesAndNotifications' => 'وقت‌بندی و اعلان‌ها',
      'general' => 'عمومی',
      'schedules' => 'وقت‌بندی مصرف دوا',
      'noSchedules' => 'وقت‌بندی نیه',
      'language' => 'زبان برنامه',
      'languageFollowDevice' => 'همون زبان گوشی',
      'enableNotifications' => 'روشن کردن اعلان‌ها',
      'enableNotificationsDescription' => 'فرستادن یادآوری',
      'anchorToLastIntake' => 'حساب دوباره از آخرین مصرف',
      'anchorToLastIntakeDescription' =>
        'نوبت بعدی درست یه فاصلهٔ کامل بعد از آخرین مصرف می‌افته.',
      'notificationsDisabledTitle' => 'اعلان‌ها خاموشن',
      'clickToOpenSettings' => 'سی باز کردن تنظیمات بزنین',
      'exactRemindersDisabled' => 'یادآوری سر ساعت دقیق خاموش هس',
      'remindersDelayed' =>
        'ممکنه یادآوری‌ها یه کم با تأخیر بیاد. سی باز کردن تنظیمات بزنین.',
      'medicalSettings' => 'تنظیمات دوایی',
      'theme' => 'تم',
      'themeCustomizeColors' => 'سی دلخواه کردن رنگ‌های برنامه',
      'customThemeEnabled' => 'تم دست‌ساز',
      'themeGenerate' => 'ساختن',
      'themeVariant' => 'جور تم',
      'themeContrast' => 'کنتراست',
      'themeContrastStandard' => 'معمولی',
      'themeContrastMedium' => 'متوسط',
      'themeContrastHigh' => 'زیاد',
      'autoUpdate' => 'به‌روزرسانی خودکار',
      'autoUpdateDescription' =>
        'هر وخت برنامه باز ببو، خودش چک کنه به‌روزرسانی تازه هس یا نه',
      'checkForUpdates' => 'چک کردن به‌روزرسانی',
      'checkForUpdatesDescription' =>
        'آخرین نسخه خودتون چک بکنین. با این کار وصل اینترنت می‌بوین. (هیچ داده‌ای فرستاده نمی‌بو)',
      'appVersion' => ({required Object version}) => 'نسخهٔ مونا ${version}',
      'getInvolved' => 'همراهی بکنین',
      'reportBug' => 'گزارش اشکال',
      'reportBugDescription' => 'توی گیت‌هاب یه issue باز بکنین',
      'translateApp' => 'برنامه ترجمه بکنین',
      'translateAppDescription' => 'توی Weblate به ترجمهٔ مونا کمک بکنین',
      'missingTranslation' => 'ترجمه‌ای جامونده؟',
      'donate' => 'اهدا کردن',
      'donateDescription' => 'توی Ko-fi از مونا حمایت بکنین',
      'backupSaved' => 'نسخهٔ پشتیبان ذخیره بی',
      'exportFailed' => ({required Object error}) =>
          'خروجی گرفتن نشد: ${error}',
      'importDataTitle' => 'وارد کردن داده‌ها',
      'importDataSubtitle' => 'برگردوندن داده‌ها از یه پشتیبان JSON',
      'importDataOverwriteWarning' =>
        'این کار همهٔ داده‌هایی که ایسه دارید با نسخهٔ پشتیبان عوض می‌کنه. این کار واپس نمی‌گرده. ادامه می‌دین؟',
      'importConfirm' => 'وارد کردن',
      'importSuccessfulTitle' => 'وارد کردن درست انجام بی',
      'importRestartRequired' =>
        'تا داده‌هایی که برگردوندین بیاد سرجاش، برنامه ببندین و دوباره باز بکنین.',
      'closeApp' => 'بستن برنامه',
      'importFailed' => ({required Object error}) => 'وارد کردن نشد: ${error}',
      'updates' => 'به‌روزرسانی‌ها',
      'dataManagement' => 'کار با داده‌ها',
      'exportDataTitle' => 'خروجی گرفتن از داده‌ها',
      'exportDataSubtitle' => 'ذخیره کردن داده‌های خودتون توی یه فایل JSON',
      'units' => 'واحدها',
      'updateNoCompatibleApk' => 'به‌روزرسانی جور دستگاه شما پیدا نشد.',
      'updateAppUpToDate' => 'برنامهٔ شما به‌روز هس!',
      'updateCheckNetworkError' => 'ایسه نمی‌تونیم به‌روزرسانی چک بکنیم.',
      'updateDialogTitle' => 'به‌روزرسانی هس',
      'updateDialogBody' => (
              {required Object latest, required Object current}) =>
          'نسخهٔ ${latest} آماده هس! (نسخهٔ ایسه: ${current})\nیه به‌روزرسانی جور دستگاه شما آمادهٔ نصب هس.',
      'updateDownloadAndInstall' => 'دانلود و نصب',
      'updateInstallPermissionRequired' => 'سی نصب به‌روزرسانی اجازه لازمه.',
      'updateDownloadingTitle' => 'به‌روزرسانی داره دانلود می‌بو...',
      'updateFailedOpenInstaller' => ({required Object message}) =>
          'نصب‌کننده باز نشد: ${message}',
      'updateDownloadFailed' => 'دانلود نشد. اتصال اینترنت چک بکنین.',
      'secretSettings' => 'تنظیمات قایم',
      'slimeMode' => 'حالت حرکت نرم نمودار',
      'notificationMedicationReminderTitle' =>
        ({required Object scheduleName}) => 'وقت مصرف ${scheduleName}',
      'notificationMedicationReminderBodyDate' => ({required Object date}) =>
          'سی ${date} وقت‌بندی بیه',
      'notificationMedicationReminderBodyTime' => ({required Object time}) =>
          'سی ${time} وقت‌بندی بیه',
      'notificationMedicationReminderBodyWeekday' =>
        ({required Object weekday}) => 'سی ${weekday} وقت‌بندی بیه',
      'addSchedule' => 'یه برنامهٔ مصرف اضافه بکنین',
      'addScheduleToGetStarted' => 'سی شروع، یه وقت‌بندی اضافه بکنین.',
      'newSchedule' => 'وقت‌بندی تازه',
      'every' => 'هر',
      'days' => 'روز',
      'dayOfMonth' => 'روز ماه',
      'months' => 'ماه',
      'startDate' => 'تاریخ شروع',
      'pickATime' => 'انتخاب ساعت',
      'addIntakeTime' => 'اضافه کردن ساعت',
      'editScheduleInfo' => 'ویرایش اطلاعات وقت‌بندی',
      'scheduling' => 'وقت‌بندی',
      'editSchedule' => 'ویرایش وقت‌بندی',
      'deleteSchedule' => ({required Object name}) => '${name} پاک ببو؟',
      'addNotification' => 'اضافه کردن اعلان',
      'empty_intakes' => 'نوبت‌های مصرف‌بیه ایچه نشون داده می‌بون',
      'HrtCounter' => 'مدت هورمون‌درمانی',
      'HrtCounterDescription' =>
        'نشون می‌ده از شروع هورمون‌درمانی شما چقدر گذشته و روی هم چند نوبت مصرف ثبت بیه.',
      'hrtWidgetPlaceholder' => 'سی ثبت اولین نوبت مصرف، مونا باز بکنین',
      'hrtWidgetPreviewSample' => '۸ ماه هورمون‌درمانی',
      'hrtWidgetPreviewIntakeSample' => '۱۶ نوبت ثبت‌بیه',
      'startOfDay' => 'روز تازه از چه ساعتی شروع می‌بو؟',
      'startOfDayDescription' => ({required Object time}) =>
          'ساعت‌های پیش از ${time} جزو روز قبل حساب می‌بو.',
      'chooseSchedule' => 'یه وقت‌بندی انتخاب بکنین',
      'addSchedulesFirst' => 'اول از داخل تنظیمات وقت‌بندی اضافه بکنین.',
      'editIntake' => 'ویرایش نوبت مصرف',
      'date' => 'تاریخ',
      'amount' => 'مقدار',
      'takenAmount' => 'مقدار مصرف‌بیه',
      'wastedAmount' => 'مقدار هدررفته',
      'none' => 'هیچ‌کدوم',
      'supplyItem' => 'مورد موجودی',
      'chooseItem' => 'یه مورد انتخاب بکنین',
      'noItemsToAdd' => 'موردی نیه',
      'injectionSide' => 'جای تزریق',
      'deleteIntake' => 'این نوبت پاک ببو؟',
      'takeMedication' => ({required Object scheduleName}) =>
          'ثبت مصرف ${scheduleName}',
      'takeIntake' => 'ثبت نوبت مصرف',
      'intakeRecorded' => 'مصرف دوا ثبت بی',
      'needleDeadSpace' => 'حجم فضای مردهٔ سوزن',
      'notes' => 'یادداشت‌ها',
      'injectionType' => 'جور تزریق',
      'intramuscular' => 'تو ماهیچه',
      'subcutaneous' => 'زیر پوست',
      'microliters' => 'μL',
      'milliliters' => 'mL',
      'empty_levels' =>
        'سی شروع، یه آزمایش خون اضافه بکنین یا تزریق استرادیول ثبت بکنین',
      'bloodTestsTitle' => 'آزمایش‌های خون شما',
      'estradiolLevelsTitle' => 'سطح استرادیول',
      'week' => 'هفته',
      'twoWeeks' => 'دو هفته',
      'threeMonths' => 'سه ماه',
      'sixMonths' => 'شش ماه',
      'month' => 'ماه',
      'year' => 'سال',
      'empty_blood_tests' =>
        'آزمایش‌های خون ایچه می‌آد. با دکمهٔ اضافه کردن شروع بکنین!',
      'addBloodTest' => 'اضافه کردن آزمایش خون',
      'editBloodTest' => 'ویرایش آزمایش خون',
      'newBloodTest' => 'آزمایش خون تازه',
      'deleteBloodTest' => 'این آزمایش خون پاک ببو؟',
      'estradiolLevelLabel' => 'سطح استرادیول',
      'testosteroneLevelLabel' => 'سطح تستوسترون',
      'bloodTestDateLabel' => 'تاریخ آزمایش',
      'chartNowConcentration' => ({required Object value}) => 'ایسه ${value}',
      'chartBloodTestLevelTooltip' =>
        ({required Object date, required Object level}) => '${date}: ${level}',
      'chartLevelTooltip' => ({required Object date, required Object level}) =>
          '${date}: ${level}',
      'empty_supplies' =>
        'دوا یا وسیله‌ای ثبت نشده. سی شروع یه مورد اضافه بکنین.',
      'newItem' => 'مورد تازه',
      'adminRoute' => 'روش مصرف',
      'totalAmount' => 'مقدار کل',
      'concentration' => 'غلظت',
      'dosePerUnitLabel' => ({required Object unit}) =>
          'مقدار دوا سی هر ${unit}',
      'editItem' => 'ویرایش مورد',
      'usedAmount' => 'مقدار استفاده‌بیه',
      'deleteItem' => ({required Object name}) => '${name} پاک ببو؟',
      'allItemsFilter' => 'همه',
      'medicationItemsFilter' => 'دوا',
      'genericItems' => 'وسایل مصرفی',
      'medicationItemType' => 'دوا',
      'genericItemType' => 'وسیلهٔ مصرفی',
      'supplyType' => 'جور',
      'syringe' => 'سرنگ',
      'wipe' => 'دستمال مرطوب',
      'needle' => 'سوزن',
      'gloves' => 'دستکش',
      'bandage' => 'بانداژ',
      'add' => 'اضافه کردن',
      'save' => 'ذخیره',
      'cancel' => 'ول کردن',
      'next' => 'بعدی',
      'delete' => 'پاک کردن',
      'deleteElement' => 'این مورد پاک ببو؟',
      'irreversibleAction' => 'این کار واپس نمی‌گرده.',
      'name' => 'نوم',
      'molecule' => 'نوم ژنریک دوا',
      'ester' => 'جور استر',
      'estradiol' => 'استرادیول',
      'progesterone' => 'پروژسترون',
      'testosterone' => 'تستوسترون',
      'nandrolone' => 'ناندرولون',
      'dihydrotestosterone' => 'دی‌هیدروتستوسترون',
      'spironolactone' => 'اسپیرونولاکتون',
      'cyproteroneAcetate' => 'سیپروترون استات',
      'leuprorelinAcetate' => 'لوپرورلین استات',
      'bicalutamide' => 'بیکالوتامید',
      'decapeptyl' => 'دکاپپتیل',
      'raloxifene' => 'رالوکسیفن',
      'tamoxifen' => 'تاموکسیفن',
      'finasteride' => 'فیناستراید',
      'dutasteride' => 'دوتاستراید',
      'minoxidil' => 'ماینوکسیدیل',
      'pioglitazone' => 'پیوگلیتازون',
      'enanthate' => 'انانتات',
      'valerate' => 'والرات',
      'cypionate' => 'سیپیونات',
      'undecylate' => 'آندسیلات',
      'benzoate' => 'بنزوات',
      'cypionateSuspension' => 'سوسپانسیون سیپیونات',
      'medicationEstradiolEnanthate' => 'استرادیول انانتات',
      'medicationEstradiolValerate' => 'استرادیول والرات',
      'medicationEstradiolCypionate' => 'استرادیول سیپیونات',
      'medicationEstradiolUndecylate' => 'استرادیول آندسیلات',
      'medicationEstradiolBenzoate' => 'استرادیول بنزوات',
      'medicationEstradiolCypionateSuspension' =>
        'سوسپانسیون استرادیول سیپیونات',
      'medicationTestosteroneEnanthate' => 'تستوسترون انانتات',
      'medicationTestosteroneValerate' => 'تستوسترون والرات',
      'medicationTestosteroneCypionate' => 'تستوسترون سیپیونات',
      'medicationTestosteroneUndecylate' => 'تستوسترون آندسیلات',
      'medicationTestosteroneBenzoate' => 'تستوسترون بنزوات',
      'medicationTestosteroneCypionateSuspension' =>
        'سوسپانسیون تستوسترون سیپیونات',
      'injection' => 'تزریقی',
      'oral' => 'خوراکی',
      'sublingual' => 'زیر زوون',
      'patch' => 'پچ',
      'gel' => 'ژل',
      'implant' => 'ایمپلنت',
      'suppository' => 'شیاف',
      'transdermalSpray' => 'اسپری پوستی',
      'transdermalDrops' => 'قطرهٔ پوستی',
      'deliveryForm' => 'شکل دوا',
      'deliveryFormPump' => 'پمپ',
      'deliveryFormSachet' => 'ساشه',
      'deliveryFormGram' => 'تیوب',
      'unitMilligram' => 'میلی‌گرم',
      'unitMicrogramPerDay' => 'µg/day',
      'unitPgPerMl' => 'pg/mL',
      'unitPmolPerL' => 'pmol/L',
      'unitNgPerDl' => 'ng/dL',
      'unitNmolPerL' => 'nmol/L',
      'unitNgPerMl' => 'ng/mL',
      'unitNgPerL' => 'ng/L',
      'unitMicrogramPerL' => 'µg/L',
      'valueComparisonEqual' => 'برابر وا',
      'valueComparisonBelow' => 'کمتر یا برابر',
      'valueComparisonAbove' => 'بیشتر یا برابر',
      'injectionSideLeft' => 'چپ',
      'injectionSideRight' => 'راست',
      'placementLeft' => 'سمت چپ',
      'placementRight' => 'سمت راست',
      'placementLeftThigh' => 'ران چپ',
      'placementRightThigh' => 'ران راست',
      'placementLeftArm' => 'بازوی چپ',
      'placementRightArm' => 'بازوی راست',
      'placementLeftButtock' => 'باسن چپ',
      'placementRightButtock' => 'باسن راست',
      'placementLeftAbdomen' => 'سمت چپ شکم',
      'placementRightAbdomen' => 'سمت راست شکم',
      'applicationSites' => 'جای مصرف دوا',
      'applicationSitesDescription' =>
        'جاهایی که نوبتی روشون دوا می‌زنین تنظیم بکنین.',
      'applicationSitesInstructions' =>
        'جاهایی که نوبتی روشون دوا می‌زنین تنظیم بکنین. پیشنهاد جا از سابقهٔ مصرف شما درمی‌آد. سی عوض کردن ترتیب، انگشت روشون نگه دارین.',
      'addApplicationSite' => 'اضافه کردن جا',
      'customSiteLabel' => 'نوم دلخواه جای مصرف',
      'noApplicationSitesYet' => 'هنی جایی ثبت نشده',
      'addSiteToGetStarted' => 'سی شروع، از پایین یه جا اضافه بکنین.',
      'placementSuggestionPerScheduleTitle' => 'پیشنهاد جدا سی هر وقت‌بندی',
      'placementSuggestionPerScheduleDescription' =>
        'پیشنهاد جای بعدی فقط از سابقهٔ همین وقت‌بندی بیاد.',
      'requiredField' => 'باید پر ببو',
      'mustBePositiveNumber' => 'باید یه عدد مثبت بو',
      'mustBeBetween1And28' => 'باید بین ۱ و ۲۸ بو',
      'mustBeAtMost' => ({required Object max}) => 'نباید از ${max} بیشتر بو',
      'invalidTotalAmount' => 'مقدار کل درست نیه',
      'cannotExceedTotalCapacity' => 'نمی‌بو از ظرفیت کل بیشتر بو',
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: '${count} روز پیش',
            other: '${count} روز پیش',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: '${count} روز دیگه',
            other: '${count} روز دیگه',
          ),
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'هر روز',
            other: 'هر ${count} روز یه بار',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'روز ${day}، هر ماه',
            other: 'روز ${day}، هر ${count} ماه یه بار',
          ),
      'schedulesCreated' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: '${count} تا ساخته بی',
            other: '${count} تا ساخته بی',
          ),
      'onHrtForDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه روز از شروع هورمون‌درمانی شما رد بیه',
            other: '${count} روز از شروع هورمون‌درمانی شما رد بیه',
          ),
      'onHrtForWeeks' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه هفته از شروع هورمون‌درمانی شما رد بیه',
            other: '${count} هفته از شروع هورمون‌درمانی شما رد بیه',
          ),
      'onHrtForMonths' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه ماه از شروع هورمون‌درمانی شما رد بیه',
            other: '${count} ماه از شروع هورمون‌درمانی شما رد بیه',
          ),
      'onHrtForYears' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه سال از شروع هورمون‌درمانی شما رد بیه',
            other: '${count} سال از شروع هورمون‌درمانی شما رد بیه',
          ),
      'intakesLoggedCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه نوبت مصرف ثبت بی',
            other: '${count} نوبت مصرف ثبت بی',
          ),
      'remaining' => ({required num count, required Object unit}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: '${count} ${unit} مونده',
            other: '${count} ${unit} مونده',
          ),
      'syringeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه سرنگ مونده',
            other: '${count} سرنگ مونده',
          ),
      'wipeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه دستمال مرطوب مونده',
            other: '${count} دستمال مرطوب مونده',
          ),
      'needleRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه سوزن مونده',
            other: '${count} سوزن مونده',
          ),
      'glovesRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه دستکش مونده',
            other: '${count} دستکش مونده',
          ),
      'bandageRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'یه بانداژ مونده',
            other: '${count} بانداژ مونده',
          ),
      'administrationRouteUnitMl' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'میلی‌لیتر',
            other: 'میلی‌لیتر',
          ),
      'administrationRouteUnitPill' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'قرص',
            other: 'قرص',
          ),
      'administrationRouteUnitPatch' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'پچ پوستی',
            other: 'پچ پوستی',
          ),
      'administrationRouteUnitPump' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'پمپ',
            other: 'پمپ',
          ),
      'administrationRouteUnitSachet' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'ساشه',
            other: 'ساشه',
          ),
      'administrationRouteUnitGram' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'گرم',
            other: 'گرم',
          ),
      'administrationRouteUnitImplant' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'ایمپلنت',
            other: 'ایمپلنت',
          ),
      'administrationRouteUnitSuppository' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'شیاف',
            other: 'شیاف',
          ),
      'administrationRouteUnitSpray' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('lrc'))(
            count,
            one: 'اسپری',
            other: 'اسپری',
          ),
      _ => null,
    };
  }
}
