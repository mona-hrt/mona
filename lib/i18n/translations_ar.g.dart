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
class TranslationsAr extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsAr(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.ar,
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

  /// Metadata for the translations of <ar>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsAr _root = this; // ignore: unused_field

  @override
  TranslationsAr $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsAr(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'مونا';
  @override
  String get nav_home => 'مونا';
  @override
  String get nav_intakes => 'الجرعات';
  @override
  String get nav_levels => 'المستويات';
  @override
  String get nav_supplies => 'المستلزمات';
  @override
  String get takeAnIntake => 'تسجيل جرعة';
  @override
  String get addAnItem => 'إضافة عنصر';
  @override
  String get empty_home => 'ابدأ بإضافة جدول زمني من الإعدادات';
  @override
  String get allDone => 'اكتمل كل شيء!';
  @override
  String get noIntakesDue => 'لا توجد جرعات مستحقة اليوم';
  @override
  String get upcoming => 'القادمة';
  @override
  String get asNeeded => 'عند الحاجة';
  @override
  String get taken => 'تم التناول';
  @override
  String get yesterday => 'أمس';
  @override
  String get tomorrow => 'غدًا';
  @override
  String get lastTaken => 'آخر جرعة تم تناولها';
  @override
  String get neverTakenYet => 'لم تُسجّل أي جرعة بعد';
  @override
  String get scheduleFrequencyDaily => 'يوميًا';
  @override
  String get scheduleFrequencyDailyDescription => 'كل يوم في أوقات محددة';
  @override
  String get scheduleFrequencyInterval => 'فاصل زمني';
  @override
  String get scheduleFrequencyIntervalDescription => 'مرة كل بضعة أيام';
  @override
  String get scheduleFrequencyWeekly => 'أسبوعيًا';
  @override
  String get scheduleFrequencyWeeklyDescription => 'في أيام محددة من الأسبوع';
  @override
  String get scheduleFrequencyMonthly => 'شهريًا';
  @override
  String get scheduleFrequencyMonthlyDescription => 'في اليوم نفسه من كل شهر';
  @override
  String get scheduleFrequencyAsNeeded => 'عند الحاجة';
  @override
  String get scheduleFrequencyAsNeededDescription => 'من دون جدول زمني ثابت';
  @override
  String get newUpdateAvailable => 'يتوفر تحديث جديد!';
  @override
  String get goToSettings => 'الانتقال إلى الإعدادات';
  @override
  String get settingsTitle => 'الإعدادات';
  @override
  String get notifications => 'الإشعارات';
  @override
  String get schedulesAndNotifications => 'الجداول الزمنية والإشعارات';
  @override
  String get general => 'عام';
  @override
  String get schedules => 'الجداول الزمنية';
  @override
  String get noSchedules => 'لا توجد جداول زمنية';
  @override
  String get language => 'اللغة';
  @override
  String get languageFollowDevice => 'اتباع لغة الجهاز';
  @override
  String get enableNotifications => 'تفعيل الإشعارات';
  @override
  String get enableNotificationsDescription => 'إرسال التذكيرات';
  @override
  String get anchorToLastIntake => 'إعادة الحساب استنادًا إلى آخر جرعة';
  @override
  String get anchorToLastIntakeDescription =>
      'يُحدّد موعد الجرعة التالية بعد مرور فترة زمنية كاملة منذ آخر جرعة تم تناولها';
  @override
  String get notificationsDisabledTitle => 'الإشعارات معطّلة';
  @override
  String get clickToOpenSettings => 'اضغط لفتح الإعدادات';
  @override
  String get exactRemindersDisabled => 'التذكيرات في أوقاتها المحددة معطّلة';
  @override
  String get remindersDelayed =>
      'قد تتأخر التذكيرات قليلًا. اضغط لفتح الإعدادات.';
  @override
  String get medicalSettings => 'الإعدادات الطبية';
  @override
  String get theme => 'المظهر';
  @override
  String get themeCustomizeColors => 'تخصيص ألوان التطبيق';
  @override
  String get customThemeEnabled => 'المظهر المخصص';
  @override
  String get themeGenerate => 'إنشاء';
  @override
  String get themeVariant => 'النمط';
  @override
  String get themeContrast => 'التباين';
  @override
  String get themeContrastStandard => 'قياسي';
  @override
  String get themeContrastMedium => 'متوسط';
  @override
  String get themeContrastHigh => 'مرتفع';
  @override
  String get autoUpdate => 'التحديث التلقائي';
  @override
  String get autoUpdateDescription =>
      'التحقق تلقائيًا من وجود تحديثات جديدة عند تشغيل التطبيق';
  @override
  String get checkForUpdates => 'التحقق من التحديثات';
  @override
  String get checkForUpdatesDescription =>
      'التحقق يدويًا من أحدث إصدار. سيتم توصيلك بالإنترنت. (لن يتم إرسال أي بيانات)';
  @override
  String appVersion({required Object version}) => 'إصدار مونا ${version}';
  @override
  String get getInvolved => 'ساهم في المشروع';
  @override
  String get reportBug => 'الإبلاغ عن خطأ';
  @override
  String get reportBugDescription => 'فتح بلاغ على GitHub';
  @override
  String get translateApp => 'ترجمة التطبيق';
  @override
  String get translateAppDescription => 'ساعد في ترجمة مونا على Weblate';
  @override
  String get missingTranslation => 'هل هناك ترجمة مفقودة؟';
  @override
  String get donate => 'التبرع';
  @override
  String get donateDescription => 'ادعم مونا عبر Ko-fi';
  @override
  String get backupSaved => 'تم حفظ النسخة الاحتياطية';
  @override
  String exportFailed({required Object error}) => 'فشل التصدير: ${error}';
  @override
  String get importDataTitle => 'استيراد البيانات';
  @override
  String get importDataSubtitle =>
      'استعادة البيانات من نسخة احتياطية بصيغة JSON';
  @override
  String get importDataOverwriteWarning =>
      'سيؤدي هذا إلى استبدال جميع بياناتك الحالية بالبيانات الموجودة في النسخة الاحتياطية. لا يمكن التراجع عن هذا الإجراء. هل تريد المتابعة؟';
  @override
  String get importConfirm => 'استيراد';
  @override
  String get importSuccessfulTitle => 'تم الاستيراد بنجاح';
  @override
  String get importRestartRequired =>
      'يُرجى إعادة تشغيل التطبيق لتطبيق البيانات المستعادة.';
  @override
  String get closeApp => 'إغلاق التطبيق';
  @override
  String importFailed({required Object error}) => 'فشل الاستيراد: ${error}';
  @override
  String get updates => 'التحديثات';
  @override
  String get dataManagement => 'إدارة البيانات';
  @override
  String get exportDataTitle => 'تصدير البيانات';
  @override
  String get exportDataSubtitle => 'حفظ بياناتك في ملف JSON';
  @override
  String get units => 'الوحدات';
  @override
  String get updateNoCompatibleApk =>
      'لم يتم العثور على تحديث متوافق مع جهازك.';
  @override
  String get updateAppUpToDate => 'تطبيقك محدّث بالفعل!';
  @override
  String get updateCheckNetworkError =>
      'تعذّر التحقق من وجود تحديثات في الوقت الحالي.';
  @override
  String get updateDialogTitle => 'يتوفر تحديث';
  @override
  String updateDialogBody({required Object latest, required Object current}) =>
      'الإصدار ${latest} متاح! (الإصدار الحالي: ${current})\nيوجد تحديث متوافق مع جهازك وجاهز للتثبيت.';
  @override
  String get updateDownloadAndInstall => 'تنزيل وتثبيت';
  @override
  String get updateInstallPermissionRequired =>
      'يلزم الحصول على إذن لتثبيت التحديثات.';
  @override
  String get updateDownloadingTitle => 'جارٍ تنزيل التحديث...';
  @override
  String updateFailedOpenInstaller({required Object message}) =>
      'تعذّر فتح برنامج التثبيت: ${message}';
  @override
  String get updateDownloadFailed =>
      'فشل التنزيل. يُرجى التحقق من اتصالك بالإنترنت.';
  @override
  String get secretSettings => 'الإعدادات السرية';
  @override
  String get slimeMode => 'وضع حركة الرسم البياني السلسة';
  @override
  String notificationMedicationReminderTitle({required Object scheduleName}) =>
      'حان وقت تناول ${scheduleName}';
  @override
  String notificationMedicationReminderBodyDate({required Object date}) =>
      'الموعد المحدد: ${date}';
  @override
  String notificationMedicationReminderBodyTime({required Object time}) =>
      'الموعد المحدد: ${time}';
  @override
  String notificationMedicationReminderBodyWeekday({required Object weekday}) =>
      'الموعد المحدد: ${weekday}';
  @override
  String get addSchedule => 'إضافة جدول';
  @override
  String get addScheduleToGetStarted => 'أضف جدولًا للبدء.';
  @override
  String get newSchedule => 'جدول جديد';
  @override
  String get every => 'كل';
  @override
  String get days => 'أيام';
  @override
  String get dayOfMonth => 'يوم من الشهر';
  @override
  String get months => 'أشهر';
  @override
  String get startDate => 'تاريخ البدء';
  @override
  String get pickATime => 'اختر وقتًا';
  @override
  String get addIntakeTime => 'إضافة وقت';
  @override
  String get editScheduleInfo => 'تعديل معلومات الجدول';
  @override
  String get scheduling => 'الجدولة';
  @override
  String get editSchedule => 'تعديل الجدول';
  @override
  String deleteSchedule({required Object name}) => 'هل تريد حذف ${name}؟';
  @override
  String get addNotification => 'إضافة إشعار';
  @override
  String get empty_intakes => 'ستظهر الجرعات المتناولة هنا';
  @override
  String get HrtCounter => 'مدة العلاج الهرموني';
  @override
  String get HrtCounterDescription =>
      'اعرض المدة التي قضيتها في العلاج الهرموني وإجمالي الجرعات التي سجلتها';
  @override
  String get hrtWidgetPlaceholder => 'افتح مونا لتسجيل جرعتك الأولى';
  @override
  String get hrtWidgetPreviewSample => 'مضت 8 أشهر على بدء العلاج الهرموني';
  @override
  String get hrtWidgetPreviewIntakeSample => 'تم تسجيل 16 جرعة';
  @override
  String get startOfDay => 'بداية اليوم';
  @override
  String startOfDayDescription({required Object time}) =>
      'يُحتسب الوقت الذي يسبق ${time} ضمن اليوم السابق';
  @override
  String get chooseSchedule => 'اختر جدولًا';
  @override
  String get addSchedulesFirst => 'أضف جداول أولًا.';
  @override
  String get editIntake => 'تعديل الجرعة';
  @override
  String get date => 'التاريخ';
  @override
  String get amount => 'الكمية';
  @override
  String get takenAmount => 'الكمية المتناولة';
  @override
  String get wastedAmount => 'الكمية المهدرة';
  @override
  String get none => 'لا شيء';
  @override
  String get supplyItem => 'عنصر من المستلزمات';
  @override
  String get chooseItem => 'اختر عنصرًا';
  @override
  String get noItemsToAdd => 'لا توجد عناصر متاحة';
  @override
  String get injectionSide => 'موضع الحقن';
  @override
  String get deleteIntake => 'هل تريد حذف هذه الجرعة؟';
  @override
  String takeMedication({required Object scheduleName}) =>
      'تناول ${scheduleName}';
  @override
  String get takeIntake => 'تسجيل تناول الجرعة';
  @override
  String get intakeRecorded => 'تم تسجيل الجرعة';
  @override
  String get needleDeadSpace => 'الحيز الميت في الإبرة';
  @override
  String get notes => 'ملاحظات';
  @override
  String get injectionType => 'نوع الحقن';
  @override
  String get intramuscular => 'حقن عضلي';
  @override
  String get subcutaneous => 'حقن تحت الجلد';
  @override
  String get microliters => 'μL';
  @override
  String get milliliters => 'mL';
  @override
  String get empty_levels => 'أضف تحليلًا للدم أو سجّل حقنة إستراديول للبدء';
  @override
  String get bloodTestsTitle => 'تحاليل الدم';
  @override
  String get estradiolLevelsTitle => 'مستويات الإستراديول';
  @override
  String get week => 'أسبوع';
  @override
  String get twoWeeks => 'أسبوعان';
  @override
  String get threeMonths => 'ثلاثة أشهر';
  @override
  String get sixMonths => 'ستة أشهر';
  @override
  String get month => 'شهر';
  @override
  String get year => 'سنة';
  @override
  String get empty_blood_tests =>
      'ستظهر تحاليل الدم التي أجريتها هنا. ابدأ باستخدام زر الإضافة!';
  @override
  String get addBloodTest => 'إضافة تحليل دم';
  @override
  String get editBloodTest => 'تعديل تحليل الدم';
  @override
  String get newBloodTest => 'تحليل دم جديد';
  @override
  String get deleteBloodTest => 'هل تريد حذف هذا التحليل؟';
  @override
  String get estradiolLevelLabel => 'مستوى الإستراديول';
  @override
  String get testosteroneLevelLabel => 'مستوى التستوستيرون';
  @override
  String get bloodTestDateLabel => 'تاريخ التحليل';
  @override
  String chartNowConcentration({required Object value}) => 'الآن ${value}';
  @override
  String chartBloodTestLevelTooltip(
          {required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String chartLevelTooltip({required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String get empty_supplies => 'لا توجد مستلزمات. أضف عنصرًا للبدء.';
  @override
  String get newItem => 'عنصر جديد';
  @override
  String get adminRoute => 'مسار إعطاء الدواء';
  @override
  String get totalAmount => 'الكمية الإجمالية';
  @override
  String get concentration => 'التركيز';
  @override
  String dosePerUnitLabel({required Object unit}) => 'الجرعة لكل ${unit}';
  @override
  String get editItem => 'تعديل العنصر';
  @override
  String get usedAmount => 'الكمية المستخدمة';
  @override
  String deleteItem({required Object name}) => 'هل تريد حذف ${name}؟';
  @override
  String get allItemsFilter => 'الكل';
  @override
  String get medicationItemsFilter => 'الأدوية';
  @override
  String get genericItems => 'المواد الاستهلاكية';
  @override
  String get medicationItemType => 'دواء';
  @override
  String get genericItemType => 'مادة استهلاكية';
  @override
  String get supplyType => 'النوع';
  @override
  String get syringe => 'محاقن';
  @override
  String get wipe => 'مناديل';
  @override
  String get needle => 'إبر';
  @override
  String get gloves => 'قفازات';
  @override
  String get bandage => 'ضمادات';
  @override
  String get add => 'إضافة';
  @override
  String get save => 'حفظ';
  @override
  String get cancel => 'إلغاء';
  @override
  String get next => 'التالي';
  @override
  String get delete => 'حذف';
  @override
  String get deleteElement => 'هل تريد حذف هذا العنصر؟';
  @override
  String get irreversibleAction => 'لا يمكن التراجع عن هذا الإجراء.';
  @override
  String get name => 'الاسم';
  @override
  String get molecule => 'الجزيء';
  @override
  String get ester => 'الإستر';
  @override
  String get estradiol => 'إستراديول';
  @override
  String get progesterone => 'بروجستيرون';
  @override
  String get testosterone => 'تستوستيرون';
  @override
  String get nandrolone => 'ناندرولون';
  @override
  String get dihydrotestosterone => 'ثنائي هيدروتستوستيرون';
  @override
  String get spironolactone => 'سبيرونولاكتون';
  @override
  String get cyproteroneAcetate => 'خلات سيبروتيرون';
  @override
  String get leuprorelinAcetate => 'خلات ليوبروريلين';
  @override
  String get bicalutamide => 'بيكالوتاميد';
  @override
  String get decapeptyl => 'ديكابيبتيل';
  @override
  String get raloxifene => 'رالوكسيفين';
  @override
  String get tamoxifen => 'تاموكسيفين';
  @override
  String get finasteride => 'فيناستيرايد';
  @override
  String get dutasteride => 'دوتاستيرايد';
  @override
  String get minoxidil => 'مينوكسيديل';
  @override
  String get pioglitazone => 'بيوغليتازون';
  @override
  String get enanthate => 'إينانثات';
  @override
  String get valerate => 'فاليرات';
  @override
  String get cypionate => 'سيبيونات';
  @override
  String get undecylate => 'أونديسيلات';
  @override
  String get benzoate => 'بنزوات';
  @override
  String get cypionateSuspension => 'معلّق السيبيونات';
  @override
  String get medicationEstradiolEnanthate => 'إستراديول إينانثات';
  @override
  String get medicationEstradiolValerate => 'إستراديول فاليرات';
  @override
  String get medicationEstradiolCypionate => 'إستراديول سيبيونات';
  @override
  String get medicationEstradiolUndecylate => 'إستراديول أونديسيلات';
  @override
  String get medicationEstradiolBenzoate => 'إستراديول بنزوات';
  @override
  String get medicationEstradiolCypionateSuspension =>
      'معلّق إستراديول سيبيونات';
  @override
  String get medicationTestosteroneEnanthate => 'تستوستيرون إينانثات';
  @override
  String get medicationTestosteroneValerate => 'تستوستيرون فاليرات';
  @override
  String get medicationTestosteroneCypionate => 'تستوستيرون سيبيونات';
  @override
  String get medicationTestosteroneUndecylate => 'تستوستيرون أونديسيلات';
  @override
  String get medicationTestosteroneBenzoate => 'تستوستيرون بنزوات';
  @override
  String get medicationTestosteroneCypionateSuspension =>
      'معلّق تستوستيرون سيبيونات';
  @override
  String get injection => 'حقن';
  @override
  String get oral => 'فموي';
  @override
  String get sublingual => 'تحت اللسان';
  @override
  String get patch => 'لصقة';
  @override
  String get gel => 'هلام';
  @override
  String get implant => 'غرسة';
  @override
  String get suppository => 'تحميلة';
  @override
  String get transdermalSpray => 'بخاخ عبر الجلد';
  @override
  String get transdermalDrops => 'قطرات عبر الجلد';
  @override
  String get deliveryForm => 'الشكل';
  @override
  String get deliveryFormPump => 'مضخة';
  @override
  String get deliveryFormSachet => 'كيس';
  @override
  String get deliveryFormGram => 'أنبوب';
  @override
  String get unitMilligram => 'mg';
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
  String get valueComparisonEqual => 'يساوي';
  @override
  String get valueComparisonBelow => 'أقل من أو يساوي';
  @override
  String get valueComparisonAbove => 'أكبر من أو يساوي';
  @override
  String get injectionSideLeft => 'اليسار';
  @override
  String get injectionSideRight => 'اليمين';
  @override
  String get placementLeft => 'الجانب الأيسر';
  @override
  String get placementRight => 'الجانب الأيمن';
  @override
  String get placementLeftThigh => 'الفخذ الأيسر';
  @override
  String get placementRightThigh => 'الفخذ الأيمن';
  @override
  String get placementLeftArm => 'الذراع اليسرى';
  @override
  String get placementRightArm => 'الذراع اليمنى';
  @override
  String get placementLeftButtock => 'الإلية اليسرى';
  @override
  String get placementRightButtock => 'الإلية اليمنى';
  @override
  String get placementLeftAbdomen => 'الجانب الأيسر من البطن';
  @override
  String get placementRightAbdomen => 'الجانب الأيمن من البطن';
  @override
  String get applicationSites => 'مواضع التطبيق';
  @override
  String get applicationSitesDescription =>
      'إدارة المواضع التي تتناوب على استخدامها';
  @override
  String get applicationSitesInstructions =>
      'أدِر المواضع التي تتناوب على استخدامها. تُقترح المواضع بناءً على سجل الجرعات التي تناولتها. اضغط مطولًا لإعادة ترتيبها.';
  @override
  String get addApplicationSite => 'إضافة موضع';
  @override
  String get customSiteLabel => 'اسم موضع مخصص';
  @override
  String get noApplicationSitesYet => 'لا توجد مواضع بعد';
  @override
  String get addSiteToGetStarted => 'أضف موضعًا أدناه للبدء.';
  @override
  String get placementSuggestionPerScheduleTitle => 'الاقتراح حسب الجدول';
  @override
  String get placementSuggestionPerScheduleDescription =>
      'اعتمد في اقتراح الموضع التالي على سجل هذا الجدول وحده.';
  @override
  String get requiredField => 'حقل مطلوب';
  @override
  String get mustBePositiveNumber => 'يجب أن يكون رقمًا موجبًا';
  @override
  String get mustBeBetween1And28 => 'يجب أن تكون القيمة بين 1 و28';
  @override
  String mustBeAtMost({required Object max}) => 'يجب ألا تتجاوز القيمة ${max}';
  @override
  String get invalidTotalAmount => 'الكمية الإجمالية غير صالحة';
  @override
  String get cannotExceedTotalCapacity => 'لا يمكن تجاوز السعة الإجمالية';
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'اليوم ${count}',
        one: 'منذ يوم واحد',
        two: 'منذ يومين',
        few: 'منذ ${count} أيام',
        many: 'منذ ${count} يومًا',
        other: 'منذ ${count} يومًا',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'اليوم ${count}',
        one: 'خلال يوم واحد',
        two: 'خلال يومين',
        few: 'خلال ${count} أيام',
        many: 'خلال ${count} يومًا',
        other: 'خلال ${count} يوم',
      );
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'كل يوم',
        one: 'كل يوم',
        two: 'كل يومين',
        few: 'كل ${count} أيام',
        many: 'كل ${count} يومًا',
        other: 'كل ${count} يوم',
      );
  @override
  String scheduleFrequencyOnDayEveryNMonths(
          {required num count, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'في اليوم ${day} من هذا الشهر',
        one: 'في اليوم ${day} من كل شهر',
        two: 'في اليوم كل شهرين',
        few: 'في اليوم ${day} كل ${count} أشهر',
        many: 'في اليوم ${day} كل ${count} شهرًا',
        other: 'في اليوم ${day} كل ${count} شهر',
      );
  @override
  String schedulesCreated({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لم يتم إنشاء أي جدول زمني',
        one: 'تم إنشاء جدول زمني واحد',
        two: 'تم إنشاء جدولين زمنيين',
        few: 'تم إنشاء ${count} جداول زمنية',
        many: 'تم إنشاء ${count} جدولًا زمنيًا',
        other: 'تم إنشاء ${count} جدول زمني',
      );
  @override
  String onHrtForDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لم يمضِ أي يوم على بدء العلاج الهرموني',
        one: 'مضى يوم واحد على بدء العلاج الهرموني',
        two: 'مضى يومان على بدء العلاج الهرموني',
        few: 'مضت ${count} أيام على بدء العلاج الهرموني',
        many: 'مضى ${count} يومًا على بدء العلاج الهرموني',
        other: 'مضى ${count} يومًا على بدء العلاج الهرموني',
      );
  @override
  String onHrtForWeeks({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لم يمضِ أي أسبوع على بدء العلاج الهرموني',
        one: 'مضى أسبوع واحد على بدء العلاج الهرموني',
        two: 'مضى أسبوعان على بدء العلاج الهرموني',
        few: 'مضت ${count} أسابيع على بدء العلاج الهرموني',
        many: 'مضى ${count} أسبوعًا على بدء العلاج الهرموني',
        other: 'مضى ${count} أسبوعًا على بدء العلاج الهرموني',
      );
  @override
  String onHrtForMonths({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لم يمضِ أي شهر على بدء العلاج الهرموني',
        one: 'مضى شهر واحد على بدء العلاج الهرموني',
        two: 'مضى شهران على بدء العلاج الهرموني',
        few: 'مضت ${count} أشهر على بدء العلاج الهرموني',
        many: 'مضى ${count} شهرًا على بدء العلاج الهرموني',
        other: 'مضى ${count} شهرًا على بدء العلاج الهرموني',
      );
  @override
  String onHrtForYears({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لم تمضِ أي سنة على بدء العلاج الهرموني',
        one: 'مضت سنة واحدة على بدء العلاج الهرموني',
        two: 'مضت سنتان على بدء العلاج الهرموني',
        few: 'مضت ${count} سنوات على بدء العلاج الهرموني',
        many: 'مضت ${count} سنة على بدء العلاج الهرموني',
        other: 'مضت ${count} سنة على بدء العلاج الهرموني',
      );
  @override
  String intakesLoggedCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لم تُسجّل أي جرعة',
        one: 'تم تسجيل جرعة واحدة',
        two: 'تم تسجيل جرعتين',
        few: 'تم تسجيل ${count} جرعات',
        many: 'تم تسجيل ${count} جرعة',
        other: 'تم تسجيل ${count} جرعة',
      );
  @override
  String remaining({required num count, required Object unit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لا يتبقى شيء',
        one: 'المتبقي: ${count} ${unit}',
        two: 'المتبقي: ${count} ${unit}',
        few: 'المتبقي: ${count} ${unit}',
        many: 'المتبقي: ${count} ${unit}',
        other: 'المتبقي: ${count} ${unit}',
      );
  @override
  String syringeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لا توجد محاقن متبقية',
        one: 'يتبقى محقنة واحدة',
        two: 'تتبقى محقنتان',
        few: 'يتبقى ${count} محاقن',
        many: 'يتبقى ${count} محقنة',
        other: 'يتبقى ${count} محقنة',
      );
  @override
  String wipeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لا توجد مناديل متبقية',
        one: 'يتبقى منديل واحد',
        two: 'يتبقى منديلان',
        few: 'يتبقى ${count} مناديل',
        many: 'يتبقى ${count} منديلًا',
        other: 'يتبقى ${count} منديل',
      );
  @override
  String needleRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لا توجد إبر متبقية',
        one: 'تتبقى إبرة واحدة',
        two: 'تتبقى إبرتان',
        few: 'تتبقى ${count} إبر',
        many: 'تتبقى ${count} إبرة',
        other: 'تتبقى ${count} إبرة',
      );
  @override
  String glovesRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لا توجد قفازات متبقية',
        one: 'يتبقى قفاز واحد',
        two: 'يتبقى قفازان',
        few: 'يتبقى ${count} قفازات',
        many: 'يتبقى ${count} قفازًا',
        other: 'يتبقى ${count} قفاز',
      );
  @override
  String bandageRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لا توجد ضمادات متبقية',
        one: 'تتبقى ضمادة واحدة',
        two: 'تتبقى ضمادتان',
        few: 'تتبقى ${count} ضمادات',
        many: 'تتبقى ${count} ضمادة',
        other: 'تتبقى ${count} ضمادة',
      );
  @override
  String administrationRouteUnitMl({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'مل',
        one: 'مل',
        two: 'مل',
        few: 'مل',
        many: 'مل',
        other: 'مل',
      );
  @override
  String administrationRouteUnitPill({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'قرص',
        one: 'قرص',
        two: 'قرصان',
        few: 'أقراص',
        many: 'قرصًا',
        other: 'قرص',
      );
  @override
  String administrationRouteUnitPatch({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'لصقة',
        one: 'لصقة',
        two: 'لصقتان',
        few: 'لصقات',
        many: 'لصقة',
        other: 'لصقة',
      );
  @override
  String administrationRouteUnitPump({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'مضخة',
        one: 'مضخة',
        two: 'مضختان',
        few: 'مضخات',
        many: 'مضخة',
        other: 'مضخة',
      );
  @override
  String administrationRouteUnitSachet({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'كيس',
        one: 'كيس',
        two: 'كيسان',
        few: 'أكياس',
        many: 'كيسًا',
        other: 'كيس',
      );
  @override
  String administrationRouteUnitGram({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'غرام',
        one: 'غرام',
        two: 'غرامان',
        few: 'غرامات',
        many: 'غرامًا',
        other: 'غرام',
      );
  @override
  String administrationRouteUnitImplant({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'غرسة',
        one: 'غرسة',
        two: 'غراستان',
        few: 'غرسات',
        many: 'غرسة',
        other: 'غرسة',
      );
  @override
  String administrationRouteUnitSuppository({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'تحميلة',
        one: 'تحميلة',
        two: 'تحميلتان',
        few: 'تحاميل',
        many: 'تحميلة',
        other: 'تحميلة',
      );
  @override
  String administrationRouteUnitSpray({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
        count,
        zero: 'بخاخ',
        one: 'بخاخ',
        two: 'بخاخان',
        few: 'بخاخات',
        many: 'بخاخًا',
        other: 'بخاخ',
      );
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'مونا',
      'nav_home' => 'مونا',
      'nav_intakes' => 'الجرعات',
      'nav_levels' => 'المستويات',
      'nav_supplies' => 'المستلزمات',
      'takeAnIntake' => 'تسجيل جرعة',
      'addAnItem' => 'إضافة عنصر',
      'empty_home' => 'ابدأ بإضافة جدول زمني من الإعدادات',
      'allDone' => 'اكتمل كل شيء!',
      'noIntakesDue' => 'لا توجد جرعات مستحقة اليوم',
      'upcoming' => 'القادمة',
      'asNeeded' => 'عند الحاجة',
      'taken' => 'تم التناول',
      'yesterday' => 'أمس',
      'tomorrow' => 'غدًا',
      'lastTaken' => 'آخر جرعة تم تناولها',
      'neverTakenYet' => 'لم تُسجّل أي جرعة بعد',
      'scheduleFrequencyDaily' => 'يوميًا',
      'scheduleFrequencyDailyDescription' => 'كل يوم في أوقات محددة',
      'scheduleFrequencyInterval' => 'فاصل زمني',
      'scheduleFrequencyIntervalDescription' => 'مرة كل بضعة أيام',
      'scheduleFrequencyWeekly' => 'أسبوعيًا',
      'scheduleFrequencyWeeklyDescription' => 'في أيام محددة من الأسبوع',
      'scheduleFrequencyMonthly' => 'شهريًا',
      'scheduleFrequencyMonthlyDescription' => 'في اليوم نفسه من كل شهر',
      'scheduleFrequencyAsNeeded' => 'عند الحاجة',
      'scheduleFrequencyAsNeededDescription' => 'من دون جدول زمني ثابت',
      'newUpdateAvailable' => 'يتوفر تحديث جديد!',
      'goToSettings' => 'الانتقال إلى الإعدادات',
      'settingsTitle' => 'الإعدادات',
      'notifications' => 'الإشعارات',
      'schedulesAndNotifications' => 'الجداول الزمنية والإشعارات',
      'general' => 'عام',
      'schedules' => 'الجداول الزمنية',
      'noSchedules' => 'لا توجد جداول زمنية',
      'language' => 'اللغة',
      'languageFollowDevice' => 'اتباع لغة الجهاز',
      'enableNotifications' => 'تفعيل الإشعارات',
      'enableNotificationsDescription' => 'إرسال التذكيرات',
      'anchorToLastIntake' => 'إعادة الحساب استنادًا إلى آخر جرعة',
      'anchorToLastIntakeDescription' =>
        'يُحدّد موعد الجرعة التالية بعد مرور فترة زمنية كاملة منذ آخر جرعة تم تناولها',
      'notificationsDisabledTitle' => 'الإشعارات معطّلة',
      'clickToOpenSettings' => 'اضغط لفتح الإعدادات',
      'exactRemindersDisabled' => 'التذكيرات في أوقاتها المحددة معطّلة',
      'remindersDelayed' => 'قد تتأخر التذكيرات قليلًا. اضغط لفتح الإعدادات.',
      'medicalSettings' => 'الإعدادات الطبية',
      'theme' => 'المظهر',
      'themeCustomizeColors' => 'تخصيص ألوان التطبيق',
      'customThemeEnabled' => 'المظهر المخصص',
      'themeGenerate' => 'إنشاء',
      'themeVariant' => 'النمط',
      'themeContrast' => 'التباين',
      'themeContrastStandard' => 'قياسي',
      'themeContrastMedium' => 'متوسط',
      'themeContrastHigh' => 'مرتفع',
      'autoUpdate' => 'التحديث التلقائي',
      'autoUpdateDescription' =>
        'التحقق تلقائيًا من وجود تحديثات جديدة عند تشغيل التطبيق',
      'checkForUpdates' => 'التحقق من التحديثات',
      'checkForUpdatesDescription' =>
        'التحقق يدويًا من أحدث إصدار. سيتم توصيلك بالإنترنت. (لن يتم إرسال أي بيانات)',
      'appVersion' => ({required Object version}) => 'إصدار مونا ${version}',
      'getInvolved' => 'ساهم في المشروع',
      'reportBug' => 'الإبلاغ عن خطأ',
      'reportBugDescription' => 'فتح بلاغ على GitHub',
      'translateApp' => 'ترجمة التطبيق',
      'translateAppDescription' => 'ساعد في ترجمة مونا على Weblate',
      'missingTranslation' => 'هل هناك ترجمة مفقودة؟',
      'donate' => 'التبرع',
      'donateDescription' => 'ادعم مونا عبر Ko-fi',
      'backupSaved' => 'تم حفظ النسخة الاحتياطية',
      'exportFailed' => ({required Object error}) => 'فشل التصدير: ${error}',
      'importDataTitle' => 'استيراد البيانات',
      'importDataSubtitle' => 'استعادة البيانات من نسخة احتياطية بصيغة JSON',
      'importDataOverwriteWarning' =>
        'سيؤدي هذا إلى استبدال جميع بياناتك الحالية بالبيانات الموجودة في النسخة الاحتياطية. لا يمكن التراجع عن هذا الإجراء. هل تريد المتابعة؟',
      'importConfirm' => 'استيراد',
      'importSuccessfulTitle' => 'تم الاستيراد بنجاح',
      'importRestartRequired' =>
        'يُرجى إعادة تشغيل التطبيق لتطبيق البيانات المستعادة.',
      'closeApp' => 'إغلاق التطبيق',
      'importFailed' => ({required Object error}) => 'فشل الاستيراد: ${error}',
      'updates' => 'التحديثات',
      'dataManagement' => 'إدارة البيانات',
      'exportDataTitle' => 'تصدير البيانات',
      'exportDataSubtitle' => 'حفظ بياناتك في ملف JSON',
      'units' => 'الوحدات',
      'updateNoCompatibleApk' => 'لم يتم العثور على تحديث متوافق مع جهازك.',
      'updateAppUpToDate' => 'تطبيقك محدّث بالفعل!',
      'updateCheckNetworkError' =>
        'تعذّر التحقق من وجود تحديثات في الوقت الحالي.',
      'updateDialogTitle' => 'يتوفر تحديث',
      'updateDialogBody' => (
              {required Object latest, required Object current}) =>
          'الإصدار ${latest} متاح! (الإصدار الحالي: ${current})\nيوجد تحديث متوافق مع جهازك وجاهز للتثبيت.',
      'updateDownloadAndInstall' => 'تنزيل وتثبيت',
      'updateInstallPermissionRequired' =>
        'يلزم الحصول على إذن لتثبيت التحديثات.',
      'updateDownloadingTitle' => 'جارٍ تنزيل التحديث...',
      'updateFailedOpenInstaller' => ({required Object message}) =>
          'تعذّر فتح برنامج التثبيت: ${message}',
      'updateDownloadFailed' =>
        'فشل التنزيل. يُرجى التحقق من اتصالك بالإنترنت.',
      'secretSettings' => 'الإعدادات السرية',
      'slimeMode' => 'وضع حركة الرسم البياني السلسة',
      'notificationMedicationReminderTitle' =>
        ({required Object scheduleName}) => 'حان وقت تناول ${scheduleName}',
      'notificationMedicationReminderBodyDate' => ({required Object date}) =>
          'الموعد المحدد: ${date}',
      'notificationMedicationReminderBodyTime' => ({required Object time}) =>
          'الموعد المحدد: ${time}',
      'notificationMedicationReminderBodyWeekday' =>
        ({required Object weekday}) => 'الموعد المحدد: ${weekday}',
      'addSchedule' => 'إضافة جدول',
      'addScheduleToGetStarted' => 'أضف جدولًا للبدء.',
      'newSchedule' => 'جدول جديد',
      'every' => 'كل',
      'days' => 'أيام',
      'dayOfMonth' => 'يوم من الشهر',
      'months' => 'أشهر',
      'startDate' => 'تاريخ البدء',
      'pickATime' => 'اختر وقتًا',
      'addIntakeTime' => 'إضافة وقت',
      'editScheduleInfo' => 'تعديل معلومات الجدول',
      'scheduling' => 'الجدولة',
      'editSchedule' => 'تعديل الجدول',
      'deleteSchedule' => ({required Object name}) => 'هل تريد حذف ${name}؟',
      'addNotification' => 'إضافة إشعار',
      'empty_intakes' => 'ستظهر الجرعات المتناولة هنا',
      'HrtCounter' => 'مدة العلاج الهرموني',
      'HrtCounterDescription' =>
        'اعرض المدة التي قضيتها في العلاج الهرموني وإجمالي الجرعات التي سجلتها',
      'hrtWidgetPlaceholder' => 'افتح مونا لتسجيل جرعتك الأولى',
      'hrtWidgetPreviewSample' => 'مضت 8 أشهر على بدء العلاج الهرموني',
      'hrtWidgetPreviewIntakeSample' => 'تم تسجيل 16 جرعة',
      'startOfDay' => 'بداية اليوم',
      'startOfDayDescription' => ({required Object time}) =>
          'يُحتسب الوقت الذي يسبق ${time} ضمن اليوم السابق',
      'chooseSchedule' => 'اختر جدولًا',
      'addSchedulesFirst' => 'أضف جداول أولًا.',
      'editIntake' => 'تعديل الجرعة',
      'date' => 'التاريخ',
      'amount' => 'الكمية',
      'takenAmount' => 'الكمية المتناولة',
      'wastedAmount' => 'الكمية المهدرة',
      'none' => 'لا شيء',
      'supplyItem' => 'عنصر من المستلزمات',
      'chooseItem' => 'اختر عنصرًا',
      'noItemsToAdd' => 'لا توجد عناصر متاحة',
      'injectionSide' => 'موضع الحقن',
      'deleteIntake' => 'هل تريد حذف هذه الجرعة؟',
      'takeMedication' => ({required Object scheduleName}) =>
          'تناول ${scheduleName}',
      'takeIntake' => 'تسجيل تناول الجرعة',
      'intakeRecorded' => 'تم تسجيل الجرعة',
      'needleDeadSpace' => 'الحيز الميت في الإبرة',
      'notes' => 'ملاحظات',
      'injectionType' => 'نوع الحقن',
      'intramuscular' => 'حقن عضلي',
      'subcutaneous' => 'حقن تحت الجلد',
      'microliters' => 'μL',
      'milliliters' => 'mL',
      'empty_levels' => 'أضف تحليلًا للدم أو سجّل حقنة إستراديول للبدء',
      'bloodTestsTitle' => 'تحاليل الدم',
      'estradiolLevelsTitle' => 'مستويات الإستراديول',
      'week' => 'أسبوع',
      'twoWeeks' => 'أسبوعان',
      'threeMonths' => 'ثلاثة أشهر',
      'sixMonths' => 'ستة أشهر',
      'month' => 'شهر',
      'year' => 'سنة',
      'empty_blood_tests' =>
        'ستظهر تحاليل الدم التي أجريتها هنا. ابدأ باستخدام زر الإضافة!',
      'addBloodTest' => 'إضافة تحليل دم',
      'editBloodTest' => 'تعديل تحليل الدم',
      'newBloodTest' => 'تحليل دم جديد',
      'deleteBloodTest' => 'هل تريد حذف هذا التحليل؟',
      'estradiolLevelLabel' => 'مستوى الإستراديول',
      'testosteroneLevelLabel' => 'مستوى التستوستيرون',
      'bloodTestDateLabel' => 'تاريخ التحليل',
      'chartNowConcentration' => ({required Object value}) => 'الآن ${value}',
      'chartBloodTestLevelTooltip' =>
        ({required Object date, required Object level}) => '${date}: ${level}',
      'chartLevelTooltip' => ({required Object date, required Object level}) =>
          '${date}: ${level}',
      'empty_supplies' => 'لا توجد مستلزمات. أضف عنصرًا للبدء.',
      'newItem' => 'عنصر جديد',
      'adminRoute' => 'مسار إعطاء الدواء',
      'totalAmount' => 'الكمية الإجمالية',
      'concentration' => 'التركيز',
      'dosePerUnitLabel' => ({required Object unit}) => 'الجرعة لكل ${unit}',
      'editItem' => 'تعديل العنصر',
      'usedAmount' => 'الكمية المستخدمة',
      'deleteItem' => ({required Object name}) => 'هل تريد حذف ${name}؟',
      'allItemsFilter' => 'الكل',
      'medicationItemsFilter' => 'الأدوية',
      'genericItems' => 'المواد الاستهلاكية',
      'medicationItemType' => 'دواء',
      'genericItemType' => 'مادة استهلاكية',
      'supplyType' => 'النوع',
      'syringe' => 'محاقن',
      'wipe' => 'مناديل',
      'needle' => 'إبر',
      'gloves' => 'قفازات',
      'bandage' => 'ضمادات',
      'add' => 'إضافة',
      'save' => 'حفظ',
      'cancel' => 'إلغاء',
      'next' => 'التالي',
      'delete' => 'حذف',
      'deleteElement' => 'هل تريد حذف هذا العنصر؟',
      'irreversibleAction' => 'لا يمكن التراجع عن هذا الإجراء.',
      'name' => 'الاسم',
      'molecule' => 'الجزيء',
      'ester' => 'الإستر',
      'estradiol' => 'إستراديول',
      'progesterone' => 'بروجستيرون',
      'testosterone' => 'تستوستيرون',
      'nandrolone' => 'ناندرولون',
      'dihydrotestosterone' => 'ثنائي هيدروتستوستيرون',
      'spironolactone' => 'سبيرونولاكتون',
      'cyproteroneAcetate' => 'خلات سيبروتيرون',
      'leuprorelinAcetate' => 'خلات ليوبروريلين',
      'bicalutamide' => 'بيكالوتاميد',
      'decapeptyl' => 'ديكابيبتيل',
      'raloxifene' => 'رالوكسيفين',
      'tamoxifen' => 'تاموكسيفين',
      'finasteride' => 'فيناستيرايد',
      'dutasteride' => 'دوتاستيرايد',
      'minoxidil' => 'مينوكسيديل',
      'pioglitazone' => 'بيوغليتازون',
      'enanthate' => 'إينانثات',
      'valerate' => 'فاليرات',
      'cypionate' => 'سيبيونات',
      'undecylate' => 'أونديسيلات',
      'benzoate' => 'بنزوات',
      'cypionateSuspension' => 'معلّق السيبيونات',
      'medicationEstradiolEnanthate' => 'إستراديول إينانثات',
      'medicationEstradiolValerate' => 'إستراديول فاليرات',
      'medicationEstradiolCypionate' => 'إستراديول سيبيونات',
      'medicationEstradiolUndecylate' => 'إستراديول أونديسيلات',
      'medicationEstradiolBenzoate' => 'إستراديول بنزوات',
      'medicationEstradiolCypionateSuspension' => 'معلّق إستراديول سيبيونات',
      'medicationTestosteroneEnanthate' => 'تستوستيرون إينانثات',
      'medicationTestosteroneValerate' => 'تستوستيرون فاليرات',
      'medicationTestosteroneCypionate' => 'تستوستيرون سيبيونات',
      'medicationTestosteroneUndecylate' => 'تستوستيرون أونديسيلات',
      'medicationTestosteroneBenzoate' => 'تستوستيرون بنزوات',
      'medicationTestosteroneCypionateSuspension' =>
        'معلّق تستوستيرون سيبيونات',
      'injection' => 'حقن',
      'oral' => 'فموي',
      'sublingual' => 'تحت اللسان',
      'patch' => 'لصقة',
      'gel' => 'هلام',
      'implant' => 'غرسة',
      'suppository' => 'تحميلة',
      'transdermalSpray' => 'بخاخ عبر الجلد',
      'transdermalDrops' => 'قطرات عبر الجلد',
      'deliveryForm' => 'الشكل',
      'deliveryFormPump' => 'مضخة',
      'deliveryFormSachet' => 'كيس',
      'deliveryFormGram' => 'أنبوب',
      'unitMilligram' => 'mg',
      'unitMicrogramPerDay' => 'µg/day',
      'unitPgPerMl' => 'pg/mL',
      'unitPmolPerL' => 'pmol/L',
      'unitNgPerDl' => 'ng/dL',
      'unitNmolPerL' => 'nmol/L',
      'unitNgPerMl' => 'ng/mL',
      'unitNgPerL' => 'ng/L',
      'unitMicrogramPerL' => 'µg/L',
      'valueComparisonEqual' => 'يساوي',
      'valueComparisonBelow' => 'أقل من أو يساوي',
      'valueComparisonAbove' => 'أكبر من أو يساوي',
      'injectionSideLeft' => 'اليسار',
      'injectionSideRight' => 'اليمين',
      'placementLeft' => 'الجانب الأيسر',
      'placementRight' => 'الجانب الأيمن',
      'placementLeftThigh' => 'الفخذ الأيسر',
      'placementRightThigh' => 'الفخذ الأيمن',
      'placementLeftArm' => 'الذراع اليسرى',
      'placementRightArm' => 'الذراع اليمنى',
      'placementLeftButtock' => 'الإلية اليسرى',
      'placementRightButtock' => 'الإلية اليمنى',
      'placementLeftAbdomen' => 'الجانب الأيسر من البطن',
      'placementRightAbdomen' => 'الجانب الأيمن من البطن',
      'applicationSites' => 'مواضع التطبيق',
      'applicationSitesDescription' =>
        'إدارة المواضع التي تتناوب على استخدامها',
      'applicationSitesInstructions' =>
        'أدِر المواضع التي تتناوب على استخدامها. تُقترح المواضع بناءً على سجل الجرعات التي تناولتها. اضغط مطولًا لإعادة ترتيبها.',
      'addApplicationSite' => 'إضافة موضع',
      'customSiteLabel' => 'اسم موضع مخصص',
      'noApplicationSitesYet' => 'لا توجد مواضع بعد',
      'addSiteToGetStarted' => 'أضف موضعًا أدناه للبدء.',
      'placementSuggestionPerScheduleTitle' => 'الاقتراح حسب الجدول',
      'placementSuggestionPerScheduleDescription' =>
        'اعتمد في اقتراح الموضع التالي على سجل هذا الجدول وحده.',
      'requiredField' => 'حقل مطلوب',
      'mustBePositiveNumber' => 'يجب أن يكون رقمًا موجبًا',
      'mustBeBetween1And28' => 'يجب أن تكون القيمة بين 1 و28',
      'mustBeAtMost' => ({required Object max}) =>
          'يجب ألا تتجاوز القيمة ${max}',
      'invalidTotalAmount' => 'الكمية الإجمالية غير صالحة',
      'cannotExceedTotalCapacity' => 'لا يمكن تجاوز السعة الإجمالية',
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'اليوم ${count}',
            one: 'منذ يوم واحد',
            two: 'منذ يومين',
            few: 'منذ ${count} أيام',
            many: 'منذ ${count} يومًا',
            other: 'منذ ${count} يومًا',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'اليوم ${count}',
            one: 'خلال يوم واحد',
            two: 'خلال يومين',
            few: 'خلال ${count} أيام',
            many: 'خلال ${count} يومًا',
            other: 'خلال ${count} يوم',
          ),
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'كل يوم',
            one: 'كل يوم',
            two: 'كل يومين',
            few: 'كل ${count} أيام',
            many: 'كل ${count} يومًا',
            other: 'كل ${count} يوم',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'في اليوم ${day} من هذا الشهر',
            one: 'في اليوم ${day} من كل شهر',
            two: 'في اليوم كل شهرين',
            few: 'في اليوم ${day} كل ${count} أشهر',
            many: 'في اليوم ${day} كل ${count} شهرًا',
            other: 'في اليوم ${day} كل ${count} شهر',
          ),
      'schedulesCreated' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لم يتم إنشاء أي جدول زمني',
            one: 'تم إنشاء جدول زمني واحد',
            two: 'تم إنشاء جدولين زمنيين',
            few: 'تم إنشاء ${count} جداول زمنية',
            many: 'تم إنشاء ${count} جدولًا زمنيًا',
            other: 'تم إنشاء ${count} جدول زمني',
          ),
      'onHrtForDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لم يمضِ أي يوم على بدء العلاج الهرموني',
            one: 'مضى يوم واحد على بدء العلاج الهرموني',
            two: 'مضى يومان على بدء العلاج الهرموني',
            few: 'مضت ${count} أيام على بدء العلاج الهرموني',
            many: 'مضى ${count} يومًا على بدء العلاج الهرموني',
            other: 'مضى ${count} يومًا على بدء العلاج الهرموني',
          ),
      'onHrtForWeeks' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لم يمضِ أي أسبوع على بدء العلاج الهرموني',
            one: 'مضى أسبوع واحد على بدء العلاج الهرموني',
            two: 'مضى أسبوعان على بدء العلاج الهرموني',
            few: 'مضت ${count} أسابيع على بدء العلاج الهرموني',
            many: 'مضى ${count} أسبوعًا على بدء العلاج الهرموني',
            other: 'مضى ${count} أسبوعًا على بدء العلاج الهرموني',
          ),
      'onHrtForMonths' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لم يمضِ أي شهر على بدء العلاج الهرموني',
            one: 'مضى شهر واحد على بدء العلاج الهرموني',
            two: 'مضى شهران على بدء العلاج الهرموني',
            few: 'مضت ${count} أشهر على بدء العلاج الهرموني',
            many: 'مضى ${count} شهرًا على بدء العلاج الهرموني',
            other: 'مضى ${count} شهرًا على بدء العلاج الهرموني',
          ),
      'onHrtForYears' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لم تمضِ أي سنة على بدء العلاج الهرموني',
            one: 'مضت سنة واحدة على بدء العلاج الهرموني',
            two: 'مضت سنتان على بدء العلاج الهرموني',
            few: 'مضت ${count} سنوات على بدء العلاج الهرموني',
            many: 'مضت ${count} سنة على بدء العلاج الهرموني',
            other: 'مضت ${count} سنة على بدء العلاج الهرموني',
          ),
      'intakesLoggedCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لم تُسجّل أي جرعة',
            one: 'تم تسجيل جرعة واحدة',
            two: 'تم تسجيل جرعتين',
            few: 'تم تسجيل ${count} جرعات',
            many: 'تم تسجيل ${count} جرعة',
            other: 'تم تسجيل ${count} جرعة',
          ),
      'remaining' => ({required num count, required Object unit}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لا يتبقى شيء',
            one: 'المتبقي: ${count} ${unit}',
            two: 'المتبقي: ${count} ${unit}',
            few: 'المتبقي: ${count} ${unit}',
            many: 'المتبقي: ${count} ${unit}',
            other: 'المتبقي: ${count} ${unit}',
          ),
      'syringeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لا توجد محاقن متبقية',
            one: 'يتبقى محقنة واحدة',
            two: 'تتبقى محقنتان',
            few: 'يتبقى ${count} محاقن',
            many: 'يتبقى ${count} محقنة',
            other: 'يتبقى ${count} محقنة',
          ),
      'wipeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لا توجد مناديل متبقية',
            one: 'يتبقى منديل واحد',
            two: 'يتبقى منديلان',
            few: 'يتبقى ${count} مناديل',
            many: 'يتبقى ${count} منديلًا',
            other: 'يتبقى ${count} منديل',
          ),
      'needleRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لا توجد إبر متبقية',
            one: 'تتبقى إبرة واحدة',
            two: 'تتبقى إبرتان',
            few: 'تتبقى ${count} إبر',
            many: 'تتبقى ${count} إبرة',
            other: 'تتبقى ${count} إبرة',
          ),
      'glovesRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لا توجد قفازات متبقية',
            one: 'يتبقى قفاز واحد',
            two: 'يتبقى قفازان',
            few: 'يتبقى ${count} قفازات',
            many: 'يتبقى ${count} قفازًا',
            other: 'يتبقى ${count} قفاز',
          ),
      'bandageRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لا توجد ضمادات متبقية',
            one: 'تتبقى ضمادة واحدة',
            two: 'تتبقى ضمادتان',
            few: 'تتبقى ${count} ضمادات',
            many: 'تتبقى ${count} ضمادة',
            other: 'تتبقى ${count} ضمادة',
          ),
      'administrationRouteUnitMl' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'مل',
            one: 'مل',
            two: 'مل',
            few: 'مل',
            many: 'مل',
            other: 'مل',
          ),
      'administrationRouteUnitPill' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'قرص',
            one: 'قرص',
            two: 'قرصان',
            few: 'أقراص',
            many: 'قرصًا',
            other: 'قرص',
          ),
      'administrationRouteUnitPatch' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'لصقة',
            one: 'لصقة',
            two: 'لصقتان',
            few: 'لصقات',
            many: 'لصقة',
            other: 'لصقة',
          ),
      'administrationRouteUnitPump' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'مضخة',
            one: 'مضخة',
            two: 'مضختان',
            few: 'مضخات',
            many: 'مضخة',
            other: 'مضخة',
          ),
      'administrationRouteUnitSachet' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'كيس',
            one: 'كيس',
            two: 'كيسان',
            few: 'أكياس',
            many: 'كيسًا',
            other: 'كيس',
          ),
      'administrationRouteUnitGram' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'غرام',
            one: 'غرام',
            two: 'غرامان',
            few: 'غرامات',
            many: 'غرامًا',
            other: 'غرام',
          ),
      'administrationRouteUnitImplant' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'غرسة',
            one: 'غرسة',
            two: 'غراستان',
            few: 'غرسات',
            many: 'غرسة',
            other: 'غرسة',
          ),
      'administrationRouteUnitSuppository' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'تحميلة',
            one: 'تحميلة',
            two: 'تحميلتان',
            few: 'تحاميل',
            many: 'تحميلة',
            other: 'تحميلة',
          ),
      'administrationRouteUnitSpray' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(
            count,
            zero: 'بخاخ',
            one: 'بخاخ',
            two: 'بخاخان',
            few: 'بخاخات',
            many: 'بخاخًا',
            other: 'بخاخ',
          ),
      _ => null,
    };
  }
}
