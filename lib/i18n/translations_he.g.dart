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
class TranslationsHe extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsHe(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.he,
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

  /// Metadata for the translations of <he>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsHe _root = this; // ignore: unused_field

  @override
  TranslationsHe $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsHe(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'מונה';
  @override
  String get nav_home => 'מונה';
  @override
  String get nav_intakes => 'נטילות';
  @override
  String get nav_levels => 'רמות';
  @override
  String get nav_supplies => 'מלאי';
  @override
  String get takeAnIntake => 'רישום נטילה';
  @override
  String get addAnItem => 'הוספת פריט';
  @override
  String get empty_home => 'כדי להתחיל, הוסיפו לוח זמנים בהגדרות';
  @override
  String get allDone => 'הכול הושלם!';
  @override
  String get noIntakesDue => 'אין נטילות מתוכננות להיום';
  @override
  String get upcoming => 'הקרובים';
  @override
  String get asNeeded => 'לפי הצורך';
  @override
  String get taken => 'נלקח';
  @override
  String get yesterday => 'אתמול';
  @override
  String get tomorrow => 'מחר';
  @override
  String get lastTaken => 'הנטילה האחרונה';
  @override
  String get neverTakenYet => 'טרם נלקח';
  @override
  String get scheduleFrequencyDaily => 'יומי';
  @override
  String get scheduleFrequencyDailyDescription => 'בכל יום, בשעות מוגדרות';
  @override
  String get scheduleFrequencyInterval => 'מרווח בין נטילות';
  @override
  String get scheduleFrequencyIntervalDescription => 'אחת לכמה ימים';
  @override
  String get scheduleFrequencyWeekly => 'שבועי';
  @override
  String get scheduleFrequencyWeeklyDescription => 'בימים מסוימים בשבוע';
  @override
  String get scheduleFrequencyMonthly => 'חודשי';
  @override
  String get scheduleFrequencyMonthlyDescription => 'באותו יום בכל חודש';
  @override
  String get scheduleFrequencyAsNeeded => 'לפי הצורך';
  @override
  String get scheduleFrequencyAsNeededDescription => 'ללא לוח זמנים קבוע';
  @override
  String get newUpdateAvailable => 'עדכון חדש זמין!';
  @override
  String get goToSettings => 'מעבר להגדרות';
  @override
  String get settingsTitle => 'הגדרות';
  @override
  String get notifications => 'התראות';
  @override
  String get schedulesAndNotifications => 'לוחות זמנים והתראות';
  @override
  String get general => 'כללי';
  @override
  String get schedules => 'לוחות זמנים';
  @override
  String get noSchedules => 'אין לוחות זמנים';
  @override
  String get language => 'שפה';
  @override
  String get languageFollowDevice => 'בהתאם לשפת המכשיר';
  @override
  String get enableNotifications => 'הפעלת התראות';
  @override
  String get enableNotificationsDescription => 'שליחת תזכורות';
  @override
  String get anchorToLastIntake => 'חישוב מחדש לפי הנטילה האחרונה';
  @override
  String get anchorToLastIntakeDescription =>
      'מועד הנטילה הבא יחושב כך שיעבור מרווח זמן מלא מאז הנטילה האחרונה';
  @override
  String get notificationsDisabledTitle => 'ההתראות מושבתות';
  @override
  String get clickToOpenSettings => 'לחצו כדי לפתוח את ההגדרות';
  @override
  String get exactRemindersDisabled => 'התזכורות בשעות המדויקות מושבתות';
  @override
  String get remindersDelayed =>
      'ייתכן עיכוב קל בקבלת התזכורות. לחצו כדי לפתוח את ההגדרות.';
  @override
  String get medicalSettings => 'הגדרות רפואיות';
  @override
  String get theme => 'ערכת נושא';
  @override
  String get themeCustomizeColors => 'התאמה אישית של צבעי האפליקציה';
  @override
  String get customThemeEnabled => 'ערכת נושא מותאמת אישית';
  @override
  String get themeGenerate => 'יצירה';
  @override
  String get themeVariant => 'וריאציה של ערכת הנושא';
  @override
  String get themeContrast => 'ניגודיות';
  @override
  String get themeContrastStandard => 'רגילה';
  @override
  String get themeContrastMedium => 'בינונית';
  @override
  String get themeContrastHigh => 'גבוהה';
  @override
  String get autoUpdate => 'עדכון אוטומטי';
  @override
  String get autoUpdateDescription =>
      'בדיקה אוטומטית של עדכונים חדשים בעת הפעלת האפליקציה';
  @override
  String get checkForUpdates => 'בדיקת עדכונים';
  @override
  String get checkForUpdatesDescription =>
      'בדיקה ידנית של הגרסה העדכנית ביותר. פעולה זו תחבר אתכם לאינטרנט (לא יישלחו נתונים).';
  @override
  String appVersion({required Object version}) => 'גרסת Mona ${version}';
  @override
  String get getInvolved => 'קחו חלק בפרויקט';
  @override
  String get reportBug => 'דיווח על באג';
  @override
  String get reportBugDescription => 'פתיחת דיווח ב-GitHub';
  @override
  String get translateApp => 'תרגום האפליקציה';
  @override
  String get translateAppDescription => 'עזרו לתרגם את Mona ב-Weblate';
  @override
  String get missingTranslation => 'חסר תרגום?';
  @override
  String get donate => 'תרומה';
  @override
  String get donateDescription => 'תמכו בפרויקט דרך Ko-fi';
  @override
  String get backupSaved => 'הגיבוי נשמר';
  @override
  String exportFailed({required Object error}) => 'ייצוא נכשל: ${error}';
  @override
  String get importDataTitle => 'ייבוא נתונים';
  @override
  String get importDataSubtitle => 'שחזור נתונים מקובץ גיבוי בפורמט JSON';
  @override
  String get importDataOverwriteWarning =>
      'פעולה זו תחליף את כל הנתונים הקיימים שלכם בנתוני הגיבוי. לא ניתן לבטל פעולה זו. האם להמשיך?';
  @override
  String get importConfirm => 'ייבוא';
  @override
  String get importSuccessfulTitle => 'הייבוא הושלם בהצלחה';
  @override
  String get importRestartRequired =>
      'יש להפעיל מחדש את האפליקציה כדי להחיל את הנתונים ששוחזרו.';
  @override
  String get closeApp => 'סגירת האפליקציה';
  @override
  String importFailed({required Object error}) => 'ייבוא נכשל: ${error}';
  @override
  String get updates => 'עדכונים';
  @override
  String get dataManagement => 'ניהול נתונים';
  @override
  String get exportDataTitle => 'ייצוא נתונים';
  @override
  String get exportDataSubtitle => 'שמירת הנתונים בקובץ JSON';
  @override
  String get units => 'יחידות';
  @override
  String get updateNoCompatibleApk => 'לא נמצא עדכון התואם למכשיר שלכם.';
  @override
  String get updateAppUpToDate => 'האפליקציה שלכם מעודכנת!';
  @override
  String get updateCheckNetworkError => 'לא ניתן לבדוק אם קיימים עדכונים כרגע.';
  @override
  String get updateDialogTitle => 'עדכון זמין';
  @override
  String updateDialogBody({required Object latest, required Object current}) =>
      'גרסה ${latest} זמינה! (הגרסה הנוכחית: ${current})\n\nעדכון התואם למכשיר שלכם מוכן להתקנה.';
  @override
  String get updateDownloadAndInstall => 'הורדה והתקנה';
  @override
  String get updateInstallPermissionRequired => 'נדרשת הרשאה להתקנת עדכונים.';
  @override
  String startOfDayDescription({required Object time}) =>
      'שעות שלפני ${time} נחשבות לחלק מהיום הקודם';
  @override
  String get chooseSchedule => 'בחירת לוח זמנים';
  @override
  String get addSchedulesFirst => 'תחילה יש להוסיף לוחות זמנים';
  @override
  String get editIntake => 'עריכת נטילה';
  @override
  String get date => 'תאריך';
  @override
  String get amount => 'כמות';
  @override
  String get takenAmount => 'הכמות שנלקחה';
  @override
  String get wastedAmount => 'הנפח שהתבזבז';
  @override
  String get none => 'ללא';
  @override
  String get chooseItem => 'בחירת פריט';
  @override
  String get noItemsToAdd => 'אין פריטים להוספה';
  @override
  String get injectionSide => 'צד ההזרקה';
  @override
  String get deleteIntake => 'למחוק את הנטילה הזו?';
  @override
  String get irreversibleAction => 'לא ניתן לבטל פעולה זו.';
  @override
  String get name => 'שם';
  @override
  String get molecule => 'החומר הפעיל';
  @override
  String get ester => 'סוג האסטר';
  @override
  String get decapeptyl => 'דקפפטיל';
  @override
  String get raloxifene => 'רלוקסיפן';
  @override
  String get pioglitazone => 'פיוגליטזון';
  @override
  String get suppository => 'נר';
  @override
  String get transdermalSpray => 'תרסיס לעור';
  @override
  String get transdermalDrops => 'טיפות לעור';
  @override
  String get deliveryFormPump => 'משאבה';
  @override
  String get unitMilligram => 'מיליגרם';
  @override
  String get unitMicrogramPerDay => 'µg/day';
  @override
  String get unitPgPerMl => 'pg/mL';
  @override
  String get unitPmolPerL => 'pmol/L';
  @override
  String get unitNgPerDl => 'ng/dL';
  @override
  String get applicationSitesDescription =>
      'ניהול האתרים שבהם אתם משתמשים לסירוגין';
  @override
  String get applicationSitesInstructions =>
      'נהלו את האתרים שבהם אתם משתמשים לסירוגין. האתרים מוצעים על סמך היסטוריית הנטילות שלכם. לחצו לחיצה ממושכת כדי לשנות את הסדר.';
  @override
  String get supplyItem => 'פריט מלאי';
  @override
  String takeMedication({required Object scheduleName}) =>
      'רישום נטילת ${scheduleName}';
  @override
  String get takeIntake => 'רישום נטילה';
  @override
  String get intakeRecorded => 'הנטילה נרשמה';
  @override
  String get needleDeadSpace => 'נפח החלל המת של המחט';
  @override
  String get notes => 'הערות';
  @override
  String get injectionType => 'סוג ההזרקה';
  @override
  String get intramuscular => 'תוך-שרירי';
  @override
  String get subcutaneous => 'תת-עורי';
  @override
  String get microliters => 'μL';
  @override
  String get milliliters => 'mL';
  @override
  String get empty_levels =>
      'הוסיפו בדיקת דם או תעדו הזרקת אסטרדיול כדי להתחיל';
  @override
  String get bloodTestsTitle => 'בדיקות דם';
  @override
  String get estradiolLevelsTitle => 'רמות אסטרדיול';
  @override
  String get week => 'שבוע';
  @override
  String get twoWeeks => 'שבועיים';
  @override
  String get threeMonths => '3 חודשים';
  @override
  String get sixMonths => '6 חודשים';
  @override
  String get month => 'חודש';
  @override
  String get year => 'שנה';
  @override
  String get empty_blood_tests =>
      'בדיקות הדם שביצעתם יופיעו כאן. לחצו על כפתור ההוספה כדי להתחיל!';
  @override
  String get addBloodTest => 'הוספת בדיקת דם';
  @override
  String get editBloodTest => 'עריכת בדיקת דם';
  @override
  String get newBloodTest => 'בדיקת דם חדשה';
  @override
  String get deleteBloodTest => 'למחוק את בדיקת הדם הזו?';
  @override
  String get estradiolLevelLabel => 'רמת אסטרדיול';
  @override
  String get testosteroneLevelLabel => 'רמת טסטוסטרון';
  @override
  String get bloodTestDateLabel => 'תאריך הבדיקה';
  @override
  String chartNowConcentration({required Object value}) => 'עכשיו ${value}';
  @override
  String chartBloodTestLevelTooltip(
          {required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String chartLevelTooltip({required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String get empty_supplies => 'אין פריטי מלאי. הוסיפו פריט כדי להתחיל.';
  @override
  String get newItem => 'פריט חדש';
  @override
  String get adminRoute => 'דרך מתן התרופה';
  @override
  String get totalAmount => 'כמות כוללת';
  @override
  String get concentration => 'ריכוז';
  @override
  String dosePerUnitLabel({required Object unit}) => 'מינון לכל ${unit}';
  @override
  String get editItem => 'עריכת פריט';
  @override
  String get usedAmount => 'כמות שנעשה בה שימוש';
  @override
  String deleteItem({required Object name}) => 'למחוק את ${name}?';
  @override
  String get allItemsFilter => 'הכול';
  @override
  String get medicationItemsFilter => 'תרופות';
  @override
  String get genericItems => 'מוצרים מתכלים';
  @override
  String get medicationItemType => 'תרופה';
  @override
  String get undecylate => 'אונדצילאט';
  @override
  String get medicationEstradiolUndecylate => 'אסטרדיול אונדצילאט';
  @override
  String get medicationEstradiolCypionateSuspension =>
      'תרחיף אסטרדיול ציפיונאט';
  @override
  String get medicationTestosteroneUndecylate => 'טסטוסטרון אונדצילאט';
  @override
  String get sublingual => 'מתחת ללשון';
  @override
  String get applicationSites => 'אתרי יישום';
  @override
  String get placementSuggestionPerScheduleDescription =>
      'הצגת הצעות לאתר היישום הבא על סמך היסטוריית השימוש בלוח הזמנים הזה בלבד.';
  @override
  String get updateDownloadingTitle => 'מוריד עדכון...';
  @override
  String updateFailedOpenInstaller({required Object message}) =>
      'פתיחת תוכנית ההתקנה נכשלה: ${message}';
  @override
  String get updateDownloadFailed =>
      'ההורדה נכשלה. נא לבדוק את החיבור לאינטרנט.';
  @override
  String get secretSettings => 'הגדרות סודיות';
  @override
  String get slimeMode => 'מצב תנועה חלקה';
  @override
  String notificationMedicationReminderTitle({required Object scheduleName}) =>
      'הגיע הזמן לקחת את ${scheduleName}';
  @override
  String notificationMedicationReminderBodyDate({required Object date}) =>
      'מתוכנן לתאריך ${date}';
  @override
  String notificationMedicationReminderBodyTime({required Object time}) =>
      'מתוכנן לשעה ${time}';
  @override
  String notificationMedicationReminderBodyWeekday({required Object weekday}) =>
      'מתוכנן ליום ${weekday}';
  @override
  String get addSchedule => 'הוספת לוח זמנים';
  @override
  String get addScheduleToGetStarted => 'יש להוסיף לוח זמנים כדי להתחיל.';
  @override
  String get newSchedule => 'לוח זמנים חדש';
  @override
  String get every => 'כל';
  @override
  String get days => 'ימים';
  @override
  String get dayOfMonth => 'יום בחודש';
  @override
  String get months => 'חודשים';
  @override
  String get startDate => 'תאריך התחלה';
  @override
  String get pickATime => 'בחירת שעה';
  @override
  String get addIntakeTime => 'הוספת שעה';
  @override
  String get editScheduleInfo => 'עריכת פרטי לוח הזמנים';
  @override
  String get scheduling => 'תזמון';
  @override
  String get editSchedule => 'עריכת לוח זמנים';
  @override
  String deleteSchedule({required Object name}) => 'למחוק את ${name}?';
  @override
  String get addNotification => 'הוספת התראה';
  @override
  String get empty_intakes => 'הנטילות שתועדו יופיעו כאן';
  @override
  String get HrtCounter => 'משך הטיפול ההורמונלי';
  @override
  String get HrtCounterDescription =>
      'הצגת משך הזמן שעבר מאז תחילת הטיפול ההורמונלי ומספר הנטילות הכולל';
  @override
  String get hrtWidgetPlaceholder =>
      'יש לפתוח את Mona כדי לתעד את הנטילה הראשונה';
  @override
  String get hrtWidgetPreviewSample => '8 חודשים בטיפול הורמונלי';
  @override
  String get hrtWidgetPreviewIntakeSample => '16 נטילות תועדו';
  @override
  String get startOfDay => 'תחילת היום';
  @override
  String get genericItemType => 'מוצר מתכלה';
  @override
  String get supplyType => 'סוג';
  @override
  String get syringe => 'מזרקים';
  @override
  String get wipe => 'מגבונים';
  @override
  String get needle => 'מחטים';
  @override
  String get gloves => 'כפפות';
  @override
  String get bandage => 'תחבושות';
  @override
  String get add => 'הוספה';
  @override
  String get save => 'שמירה';
  @override
  String get cancel => 'ביטול';
  @override
  String get next => 'הבא';
  @override
  String get delete => 'מחיקה';
  @override
  String get deleteElement => 'למחוק את הפריט הזה?';
  @override
  String get estradiol => 'אסטרדיול';
  @override
  String get progesterone => 'פרוגסטרון';
  @override
  String get testosterone => 'טסטוסטרון';
  @override
  String get nandrolone => 'ננדרולון';
  @override
  String get dihydrotestosterone => 'דיהידרוטסטוסטרון';
  @override
  String get spironolactone => 'ספירונולקטון';
  @override
  String get cyproteroneAcetate => 'ציפרוטרון אצטט';
  @override
  String get leuprorelinAcetate => 'לאופרורלין אצטט';
  @override
  String get bicalutamide => 'ביקלוטאמיד';
  @override
  String get tamoxifen => 'טמוקסיפן';
  @override
  String get finasteride => 'פינסטריד';
  @override
  String get dutasteride => 'דוטסטריד';
  @override
  String get minoxidil => 'מינוקסידיל';
  @override
  String get enanthate => 'אננתט';
  @override
  String get valerate => 'ולראט';
  @override
  String get cypionate => 'ציפיונאט';
  @override
  String get benzoate => 'בנזואט';
  @override
  String get cypionateSuspension => 'תרחיף ציפיונאט';
  @override
  String get medicationEstradiolEnanthate => 'אסטרדיול אננתט';
  @override
  String get medicationEstradiolValerate => 'אסטרדיול ולראט';
  @override
  String get medicationEstradiolCypionate => 'אסטרדיול ציפיונאט';
  @override
  String get medicationEstradiolBenzoate => 'אסטרדיול בנזואט';
  @override
  String get medicationTestosteroneEnanthate => 'טסטוסטרון אננתט';
  @override
  String get medicationTestosteroneValerate => 'טסטוסטרון ולראט';
  @override
  String get medicationTestosteroneCypionate => 'טסטוסטרון ציפיונאט';
  @override
  String get medicationTestosteroneBenzoate => 'טסטוסטרון בנזואט';
  @override
  String get medicationTestosteroneCypionateSuspension =>
      'תרחיף טסטוסטרון ציפיונאט';
  @override
  String get injection => 'זריקה';
  @override
  String get oral => 'דרך הפה';
  @override
  String get patch => 'מדבקה';
  @override
  String get gel => 'ג׳ל';
  @override
  String get implant => 'שתל';
  @override
  String get deliveryForm => 'צורת מתן';
  @override
  String get deliveryFormSachet => 'שקיק';
  @override
  String get deliveryFormGram => 'שפופרת';
  @override
  String get unitNmolPerL => 'nmol/L';
  @override
  String get unitNgPerMl => 'ng/mL';
  @override
  String get unitNgPerL => 'ng/L';
  @override
  String get unitMicrogramPerL => 'µg/L';
  @override
  String get valueComparisonEqual => 'שווה ל־';
  @override
  String get valueComparisonBelow => 'שווה ל־ או נמוך מ־';
  @override
  String get valueComparisonAbove => 'שווה ל־ או גבוה מ־';
  @override
  String get injectionSideLeft => 'שמאל';
  @override
  String get injectionSideRight => 'ימין';
  @override
  String get placementLeft => 'צד שמאל';
  @override
  String get placementRight => 'צד ימין';
  @override
  String get placementLeftThigh => 'ירך שמאל';
  @override
  String get placementRightThigh => 'ירך ימין';
  @override
  String get placementLeftArm => 'זרוע שמאל';
  @override
  String get placementRightArm => 'זרוע ימין';
  @override
  String get placementLeftButtock => 'עכוז שמאל';
  @override
  String get placementRightButtock => 'עכוז ימין';
  @override
  String get placementLeftAbdomen => 'צד שמאל של הבטן';
  @override
  String get placementRightAbdomen => 'צד ימין של הבטן';
  @override
  String get addApplicationSite => 'הוספת מקום מתן';
  @override
  String get customSiteLabel => 'שם מותאם אישית למקום המתן';
  @override
  String get noApplicationSitesYet => 'עדיין לא נוספו מקומות מתן';
  @override
  String get addSiteToGetStarted => 'יש להוסיף מקום מתן למטה כדי להתחיל.';
  @override
  String get placementSuggestionPerScheduleTitle => 'הצעה לפי לוח הזמנים';
  @override
  String get requiredField => 'שדה חובה';
  @override
  String get mustBePositiveNumber => 'יש להזין מספר חיובי';
  @override
  String get mustBeBetween1And28 => 'הערך חייב להיות בין 1 ל־28';
  @override
  String mustBeAtMost({required Object max}) =>
      'הערך חייב להיות לכל היותר ${max}';
  @override
  String get invalidTotalAmount => 'הכמות הכוללת אינה תקינה';
  @override
  String get cannotExceedTotalCapacity =>
      'הכמות אינה יכולה לחרוג מהקיבולת הכוללת';
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'לפני יום אחד',
        two: 'לפני יומיים',
        other: 'לפני ${count} ימים',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'בעוד יום אחד',
        two: 'בעוד יומיים',
        other: 'בעוד ${count} ימים',
      );
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'כל יום',
        two: 'כל יומיים',
        other: 'כל ${count} ימים',
      );
  @override
  String scheduleFrequencyOnDayEveryNMonths(
          {required num count, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'ביום ${day} בכל חודש',
        two: 'ביום ${day} אחת לחודשיים',
        other: 'ביום ${day} בכל ${count} חודשים',
      );
  @override
  String schedulesCreated({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'נוצר לוח זמנים אחד',
        two: 'נוצרו שני לוחות זמנים',
        other: 'נוצרו ${count} לוחות זמנים',
      );
  @override
  String administrationRouteUnitMl({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'מיליליטר',
        two: 'מיליליטר',
        other: 'מיליליטר',
      );
  @override
  String administrationRouteUnitPill({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'גלולה',
        two: 'גלולות',
        other: 'גלולות',
      );
  @override
  String administrationRouteUnitSachet({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'שקיק',
        two: 'שקיקים',
        other: 'שקיקים',
      );
  @override
  String administrationRouteUnitSuppository({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'נר',
        two: 'נרות',
        other: 'נרות',
      );
  @override
  String administrationRouteUnitSpray({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'תרסיס',
        two: 'תרסיסים',
        other: 'תרסיסים',
      );
  @override
  String remaining({required num count, required Object unit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: '${count} ${unit} נותרו',
        two: '${count} ${unit} נותרו',
        other: '${count} ${unit} נותרו',
      );
  @override
  String administrationRouteUnitPatch({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'מדבקה',
        two: 'מדבקות',
        other: 'מדבקות',
      );
  @override
  String administrationRouteUnitPump({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'משאבה',
        two: 'משאבות',
        other: 'משאבות',
      );
  @override
  String onHrtForDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'בטיפול הורמונלי במשך יום אחד',
        two: 'בטיפול הורמונלי במשך יומיים',
        other: 'בטיפול הורמונלי במשך ${count} ימים',
      );
  @override
  String onHrtForWeeks({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'בטיפול הורמונלי במשך שבוע אחד',
        two: 'בטיפול הורמונלי במשך שבועיים',
        other: 'בטיפול הורמונלי במשך ${count} שבועות',
      );
  @override
  String onHrtForMonths({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'בטיפול הורמונלי במשך חודש אחד',
        two: 'בטיפול הורמונלי במשך חודשיים',
        other: 'בטיפול הורמונלי במשך ${count} חודשים',
      );
  @override
  String onHrtForYears({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'בטיפול הורמונלי במשך שנה אחת',
        two: 'בטיפול הורמונלי במשך שנתיים',
        other: 'בטיפול הורמונלי במשך ${count} שנים',
      );
  @override
  String intakesLoggedCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'נטילה אחת תועדה',
        two: 'נרשמו שתי נטילות',
        other: '${count} נטילות תועדו',
      );
  @override
  String syringeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'נותר מזרק אחד',
        two: 'נותרו שני מזרקים',
        other: 'נותרו ${count} מזרקים',
      );
  @override
  String wipeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'נותר מגבון אחד',
        two: 'נותרו שני מגבונים',
        other: 'נותרו ${count} מגבונים',
      );
  @override
  String needleRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'נותרה מחט אחת',
        two: 'נותרו שתי מחטים',
        other: 'נותרו ${count} מחטים',
      );
  @override
  String glovesRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'נותרה כפפה אחת',
        two: 'נותרו שתי כפפות',
        other: 'נותרו ${count} כפפות',
      );
  @override
  String bandageRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'נותרה תחבושת אחת',
        two: 'נותרו שתי תחבושות',
        other: 'נותרו ${count} תחבושות',
      );
  @override
  String administrationRouteUnitGram({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'גרם',
        two: 'גרם',
        other: 'גרם',
      );
  @override
  String administrationRouteUnitImplant({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
        count,
        one: 'שתל',
        two: 'שתלים',
        other: 'שתלים',
      );
}

/// The flat map containing all translations for locale <he>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsHe {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'מונה',
      'nav_home' => 'מונה',
      'nav_intakes' => 'נטילות',
      'nav_levels' => 'רמות',
      'nav_supplies' => 'מלאי',
      'takeAnIntake' => 'רישום נטילה',
      'addAnItem' => 'הוספת פריט',
      'empty_home' => 'כדי להתחיל, הוסיפו לוח זמנים בהגדרות',
      'allDone' => 'הכול הושלם!',
      'noIntakesDue' => 'אין נטילות מתוכננות להיום',
      'upcoming' => 'הקרובים',
      'asNeeded' => 'לפי הצורך',
      'taken' => 'נלקח',
      'yesterday' => 'אתמול',
      'tomorrow' => 'מחר',
      'lastTaken' => 'הנטילה האחרונה',
      'neverTakenYet' => 'טרם נלקח',
      'scheduleFrequencyDaily' => 'יומי',
      'scheduleFrequencyDailyDescription' => 'בכל יום, בשעות מוגדרות',
      'scheduleFrequencyInterval' => 'מרווח בין נטילות',
      'scheduleFrequencyIntervalDescription' => 'אחת לכמה ימים',
      'scheduleFrequencyWeekly' => 'שבועי',
      'scheduleFrequencyWeeklyDescription' => 'בימים מסוימים בשבוע',
      'scheduleFrequencyMonthly' => 'חודשי',
      'scheduleFrequencyMonthlyDescription' => 'באותו יום בכל חודש',
      'scheduleFrequencyAsNeeded' => 'לפי הצורך',
      'scheduleFrequencyAsNeededDescription' => 'ללא לוח זמנים קבוע',
      'newUpdateAvailable' => 'עדכון חדש זמין!',
      'goToSettings' => 'מעבר להגדרות',
      'settingsTitle' => 'הגדרות',
      'notifications' => 'התראות',
      'schedulesAndNotifications' => 'לוחות זמנים והתראות',
      'general' => 'כללי',
      'schedules' => 'לוחות זמנים',
      'noSchedules' => 'אין לוחות זמנים',
      'language' => 'שפה',
      'languageFollowDevice' => 'בהתאם לשפת המכשיר',
      'enableNotifications' => 'הפעלת התראות',
      'enableNotificationsDescription' => 'שליחת תזכורות',
      'anchorToLastIntake' => 'חישוב מחדש לפי הנטילה האחרונה',
      'anchorToLastIntakeDescription' =>
        'מועד הנטילה הבא יחושב כך שיעבור מרווח זמן מלא מאז הנטילה האחרונה',
      'notificationsDisabledTitle' => 'ההתראות מושבתות',
      'clickToOpenSettings' => 'לחצו כדי לפתוח את ההגדרות',
      'exactRemindersDisabled' => 'התזכורות בשעות המדויקות מושבתות',
      'remindersDelayed' =>
        'ייתכן עיכוב קל בקבלת התזכורות. לחצו כדי לפתוח את ההגדרות.',
      'medicalSettings' => 'הגדרות רפואיות',
      'theme' => 'ערכת נושא',
      'themeCustomizeColors' => 'התאמה אישית של צבעי האפליקציה',
      'customThemeEnabled' => 'ערכת נושא מותאמת אישית',
      'themeGenerate' => 'יצירה',
      'themeVariant' => 'וריאציה של ערכת הנושא',
      'themeContrast' => 'ניגודיות',
      'themeContrastStandard' => 'רגילה',
      'themeContrastMedium' => 'בינונית',
      'themeContrastHigh' => 'גבוהה',
      'autoUpdate' => 'עדכון אוטומטי',
      'autoUpdateDescription' =>
        'בדיקה אוטומטית של עדכונים חדשים בעת הפעלת האפליקציה',
      'checkForUpdates' => 'בדיקת עדכונים',
      'checkForUpdatesDescription' =>
        'בדיקה ידנית של הגרסה העדכנית ביותר. פעולה זו תחבר אתכם לאינטרנט (לא יישלחו נתונים).',
      'appVersion' => ({required Object version}) => 'גרסת Mona ${version}',
      'getInvolved' => 'קחו חלק בפרויקט',
      'reportBug' => 'דיווח על באג',
      'reportBugDescription' => 'פתיחת דיווח ב-GitHub',
      'translateApp' => 'תרגום האפליקציה',
      'translateAppDescription' => 'עזרו לתרגם את Mona ב-Weblate',
      'missingTranslation' => 'חסר תרגום?',
      'donate' => 'תרומה',
      'donateDescription' => 'תמכו בפרויקט דרך Ko-fi',
      'backupSaved' => 'הגיבוי נשמר',
      'exportFailed' => ({required Object error}) => 'ייצוא נכשל: ${error}',
      'importDataTitle' => 'ייבוא נתונים',
      'importDataSubtitle' => 'שחזור נתונים מקובץ גיבוי בפורמט JSON',
      'importDataOverwriteWarning' =>
        'פעולה זו תחליף את כל הנתונים הקיימים שלכם בנתוני הגיבוי. לא ניתן לבטל פעולה זו. האם להמשיך?',
      'importConfirm' => 'ייבוא',
      'importSuccessfulTitle' => 'הייבוא הושלם בהצלחה',
      'importRestartRequired' =>
        'יש להפעיל מחדש את האפליקציה כדי להחיל את הנתונים ששוחזרו.',
      'closeApp' => 'סגירת האפליקציה',
      'importFailed' => ({required Object error}) => 'ייבוא נכשל: ${error}',
      'updates' => 'עדכונים',
      'dataManagement' => 'ניהול נתונים',
      'exportDataTitle' => 'ייצוא נתונים',
      'exportDataSubtitle' => 'שמירת הנתונים בקובץ JSON',
      'units' => 'יחידות',
      'updateNoCompatibleApk' => 'לא נמצא עדכון התואם למכשיר שלכם.',
      'updateAppUpToDate' => 'האפליקציה שלכם מעודכנת!',
      'updateCheckNetworkError' => 'לא ניתן לבדוק אם קיימים עדכונים כרגע.',
      'updateDialogTitle' => 'עדכון זמין',
      'updateDialogBody' => (
              {required Object latest, required Object current}) =>
          'גרסה ${latest} זמינה! (הגרסה הנוכחית: ${current})\n\nעדכון התואם למכשיר שלכם מוכן להתקנה.',
      'updateDownloadAndInstall' => 'הורדה והתקנה',
      'updateInstallPermissionRequired' => 'נדרשת הרשאה להתקנת עדכונים.',
      'startOfDayDescription' => ({required Object time}) =>
          'שעות שלפני ${time} נחשבות לחלק מהיום הקודם',
      'chooseSchedule' => 'בחירת לוח זמנים',
      'addSchedulesFirst' => 'תחילה יש להוסיף לוחות זמנים',
      'editIntake' => 'עריכת נטילה',
      'date' => 'תאריך',
      'amount' => 'כמות',
      'takenAmount' => 'הכמות שנלקחה',
      'wastedAmount' => 'הנפח שהתבזבז',
      'none' => 'ללא',
      'chooseItem' => 'בחירת פריט',
      'noItemsToAdd' => 'אין פריטים להוספה',
      'injectionSide' => 'צד ההזרקה',
      'deleteIntake' => 'למחוק את הנטילה הזו?',
      'irreversibleAction' => 'לא ניתן לבטל פעולה זו.',
      'name' => 'שם',
      'molecule' => 'החומר הפעיל',
      'ester' => 'סוג האסטר',
      'decapeptyl' => 'דקפפטיל',
      'raloxifene' => 'רלוקסיפן',
      'pioglitazone' => 'פיוגליטזון',
      'suppository' => 'נר',
      'transdermalSpray' => 'תרסיס לעור',
      'transdermalDrops' => 'טיפות לעור',
      'deliveryFormPump' => 'משאבה',
      'unitMilligram' => 'מיליגרם',
      'unitMicrogramPerDay' => 'µg/day',
      'unitPgPerMl' => 'pg/mL',
      'unitPmolPerL' => 'pmol/L',
      'unitNgPerDl' => 'ng/dL',
      'applicationSitesDescription' => 'ניהול האתרים שבהם אתם משתמשים לסירוגין',
      'applicationSitesInstructions' =>
        'נהלו את האתרים שבהם אתם משתמשים לסירוגין. האתרים מוצעים על סמך היסטוריית הנטילות שלכם. לחצו לחיצה ממושכת כדי לשנות את הסדר.',
      'supplyItem' => 'פריט מלאי',
      'takeMedication' => ({required Object scheduleName}) =>
          'רישום נטילת ${scheduleName}',
      'takeIntake' => 'רישום נטילה',
      'intakeRecorded' => 'הנטילה נרשמה',
      'needleDeadSpace' => 'נפח החלל המת של המחט',
      'notes' => 'הערות',
      'injectionType' => 'סוג ההזרקה',
      'intramuscular' => 'תוך-שרירי',
      'subcutaneous' => 'תת-עורי',
      'microliters' => 'μL',
      'milliliters' => 'mL',
      'empty_levels' => 'הוסיפו בדיקת דם או תעדו הזרקת אסטרדיול כדי להתחיל',
      'bloodTestsTitle' => 'בדיקות דם',
      'estradiolLevelsTitle' => 'רמות אסטרדיול',
      'week' => 'שבוע',
      'twoWeeks' => 'שבועיים',
      'threeMonths' => '3 חודשים',
      'sixMonths' => '6 חודשים',
      'month' => 'חודש',
      'year' => 'שנה',
      'empty_blood_tests' =>
        'בדיקות הדם שביצעתם יופיעו כאן. לחצו על כפתור ההוספה כדי להתחיל!',
      'addBloodTest' => 'הוספת בדיקת דם',
      'editBloodTest' => 'עריכת בדיקת דם',
      'newBloodTest' => 'בדיקת דם חדשה',
      'deleteBloodTest' => 'למחוק את בדיקת הדם הזו?',
      'estradiolLevelLabel' => 'רמת אסטרדיול',
      'testosteroneLevelLabel' => 'רמת טסטוסטרון',
      'bloodTestDateLabel' => 'תאריך הבדיקה',
      'chartNowConcentration' => ({required Object value}) => 'עכשיו ${value}',
      'chartBloodTestLevelTooltip' =>
        ({required Object date, required Object level}) => '${date}: ${level}',
      'chartLevelTooltip' => ({required Object date, required Object level}) =>
          '${date}: ${level}',
      'empty_supplies' => 'אין פריטי מלאי. הוסיפו פריט כדי להתחיל.',
      'newItem' => 'פריט חדש',
      'adminRoute' => 'דרך מתן התרופה',
      'totalAmount' => 'כמות כוללת',
      'concentration' => 'ריכוז',
      'dosePerUnitLabel' => ({required Object unit}) => 'מינון לכל ${unit}',
      'editItem' => 'עריכת פריט',
      'usedAmount' => 'כמות שנעשה בה שימוש',
      'deleteItem' => ({required Object name}) => 'למחוק את ${name}?',
      'allItemsFilter' => 'הכול',
      'medicationItemsFilter' => 'תרופות',
      'genericItems' => 'מוצרים מתכלים',
      'medicationItemType' => 'תרופה',
      'undecylate' => 'אונדצילאט',
      'medicationEstradiolUndecylate' => 'אסטרדיול אונדצילאט',
      'medicationEstradiolCypionateSuspension' => 'תרחיף אסטרדיול ציפיונאט',
      'medicationTestosteroneUndecylate' => 'טסטוסטרון אונדצילאט',
      'sublingual' => 'מתחת ללשון',
      'applicationSites' => 'אתרי יישום',
      'placementSuggestionPerScheduleDescription' =>
        'הצגת הצעות לאתר היישום הבא על סמך היסטוריית השימוש בלוח הזמנים הזה בלבד.',
      'updateDownloadingTitle' => 'מוריד עדכון...',
      'updateFailedOpenInstaller' => ({required Object message}) =>
          'פתיחת תוכנית ההתקנה נכשלה: ${message}',
      'updateDownloadFailed' => 'ההורדה נכשלה. נא לבדוק את החיבור לאינטרנט.',
      'secretSettings' => 'הגדרות סודיות',
      'slimeMode' => 'מצב תנועה חלקה',
      'notificationMedicationReminderTitle' =>
        ({required Object scheduleName}) => 'הגיע הזמן לקחת את ${scheduleName}',
      'notificationMedicationReminderBodyDate' => ({required Object date}) =>
          'מתוכנן לתאריך ${date}',
      'notificationMedicationReminderBodyTime' => ({required Object time}) =>
          'מתוכנן לשעה ${time}',
      'notificationMedicationReminderBodyWeekday' =>
        ({required Object weekday}) => 'מתוכנן ליום ${weekday}',
      'addSchedule' => 'הוספת לוח זמנים',
      'addScheduleToGetStarted' => 'יש להוסיף לוח זמנים כדי להתחיל.',
      'newSchedule' => 'לוח זמנים חדש',
      'every' => 'כל',
      'days' => 'ימים',
      'dayOfMonth' => 'יום בחודש',
      'months' => 'חודשים',
      'startDate' => 'תאריך התחלה',
      'pickATime' => 'בחירת שעה',
      'addIntakeTime' => 'הוספת שעה',
      'editScheduleInfo' => 'עריכת פרטי לוח הזמנים',
      'scheduling' => 'תזמון',
      'editSchedule' => 'עריכת לוח זמנים',
      'deleteSchedule' => ({required Object name}) => 'למחוק את ${name}?',
      'addNotification' => 'הוספת התראה',
      'empty_intakes' => 'הנטילות שתועדו יופיעו כאן',
      'HrtCounter' => 'משך הטיפול ההורמונלי',
      'HrtCounterDescription' =>
        'הצגת משך הזמן שעבר מאז תחילת הטיפול ההורמונלי ומספר הנטילות הכולל',
      'hrtWidgetPlaceholder' => 'יש לפתוח את Mona כדי לתעד את הנטילה הראשונה',
      'hrtWidgetPreviewSample' => '8 חודשים בטיפול הורמונלי',
      'hrtWidgetPreviewIntakeSample' => '16 נטילות תועדו',
      'startOfDay' => 'תחילת היום',
      'genericItemType' => 'מוצר מתכלה',
      'supplyType' => 'סוג',
      'syringe' => 'מזרקים',
      'wipe' => 'מגבונים',
      'needle' => 'מחטים',
      'gloves' => 'כפפות',
      'bandage' => 'תחבושות',
      'add' => 'הוספה',
      'save' => 'שמירה',
      'cancel' => 'ביטול',
      'next' => 'הבא',
      'delete' => 'מחיקה',
      'deleteElement' => 'למחוק את הפריט הזה?',
      'estradiol' => 'אסטרדיול',
      'progesterone' => 'פרוגסטרון',
      'testosterone' => 'טסטוסטרון',
      'nandrolone' => 'ננדרולון',
      'dihydrotestosterone' => 'דיהידרוטסטוסטרון',
      'spironolactone' => 'ספירונולקטון',
      'cyproteroneAcetate' => 'ציפרוטרון אצטט',
      'leuprorelinAcetate' => 'לאופרורלין אצטט',
      'bicalutamide' => 'ביקלוטאמיד',
      'tamoxifen' => 'טמוקסיפן',
      'finasteride' => 'פינסטריד',
      'dutasteride' => 'דוטסטריד',
      'minoxidil' => 'מינוקסידיל',
      'enanthate' => 'אננתט',
      'valerate' => 'ולראט',
      'cypionate' => 'ציפיונאט',
      'benzoate' => 'בנזואט',
      'cypionateSuspension' => 'תרחיף ציפיונאט',
      'medicationEstradiolEnanthate' => 'אסטרדיול אננתט',
      'medicationEstradiolValerate' => 'אסטרדיול ולראט',
      'medicationEstradiolCypionate' => 'אסטרדיול ציפיונאט',
      'medicationEstradiolBenzoate' => 'אסטרדיול בנזואט',
      'medicationTestosteroneEnanthate' => 'טסטוסטרון אננתט',
      'medicationTestosteroneValerate' => 'טסטוסטרון ולראט',
      'medicationTestosteroneCypionate' => 'טסטוסטרון ציפיונאט',
      'medicationTestosteroneBenzoate' => 'טסטוסטרון בנזואט',
      'medicationTestosteroneCypionateSuspension' => 'תרחיף טסטוסטרון ציפיונאט',
      'injection' => 'זריקה',
      'oral' => 'דרך הפה',
      'patch' => 'מדבקה',
      'gel' => 'ג׳ל',
      'implant' => 'שתל',
      'deliveryForm' => 'צורת מתן',
      'deliveryFormSachet' => 'שקיק',
      'deliveryFormGram' => 'שפופרת',
      'unitNmolPerL' => 'nmol/L',
      'unitNgPerMl' => 'ng/mL',
      'unitNgPerL' => 'ng/L',
      'unitMicrogramPerL' => 'µg/L',
      'valueComparisonEqual' => 'שווה ל־',
      'valueComparisonBelow' => 'שווה ל־ או נמוך מ־',
      'valueComparisonAbove' => 'שווה ל־ או גבוה מ־',
      'injectionSideLeft' => 'שמאל',
      'injectionSideRight' => 'ימין',
      'placementLeft' => 'צד שמאל',
      'placementRight' => 'צד ימין',
      'placementLeftThigh' => 'ירך שמאל',
      'placementRightThigh' => 'ירך ימין',
      'placementLeftArm' => 'זרוע שמאל',
      'placementRightArm' => 'זרוע ימין',
      'placementLeftButtock' => 'עכוז שמאל',
      'placementRightButtock' => 'עכוז ימין',
      'placementLeftAbdomen' => 'צד שמאל של הבטן',
      'placementRightAbdomen' => 'צד ימין של הבטן',
      'addApplicationSite' => 'הוספת מקום מתן',
      'customSiteLabel' => 'שם מותאם אישית למקום המתן',
      'noApplicationSitesYet' => 'עדיין לא נוספו מקומות מתן',
      'addSiteToGetStarted' => 'יש להוסיף מקום מתן למטה כדי להתחיל.',
      'placementSuggestionPerScheduleTitle' => 'הצעה לפי לוח הזמנים',
      'requiredField' => 'שדה חובה',
      'mustBePositiveNumber' => 'יש להזין מספר חיובי',
      'mustBeBetween1And28' => 'הערך חייב להיות בין 1 ל־28',
      'mustBeAtMost' => ({required Object max}) =>
          'הערך חייב להיות לכל היותר ${max}',
      'invalidTotalAmount' => 'הכמות הכוללת אינה תקינה',
      'cannotExceedTotalCapacity' => 'הכמות אינה יכולה לחרוג מהקיבולת הכוללת',
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'לפני יום אחד',
            two: 'לפני יומיים',
            other: 'לפני ${count} ימים',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'בעוד יום אחד',
            two: 'בעוד יומיים',
            other: 'בעוד ${count} ימים',
          ),
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'כל יום',
            two: 'כל יומיים',
            other: 'כל ${count} ימים',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'ביום ${day} בכל חודש',
            two: 'ביום ${day} אחת לחודשיים',
            other: 'ביום ${day} בכל ${count} חודשים',
          ),
      'schedulesCreated' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'נוצר לוח זמנים אחד',
            two: 'נוצרו שני לוחות זמנים',
            other: 'נוצרו ${count} לוחות זמנים',
          ),
      'administrationRouteUnitMl' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'מיליליטר',
            two: 'מיליליטר',
            other: 'מיליליטר',
          ),
      'administrationRouteUnitPill' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'גלולה',
            two: 'גלולות',
            other: 'גלולות',
          ),
      'administrationRouteUnitSachet' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'שקיק',
            two: 'שקיקים',
            other: 'שקיקים',
          ),
      'administrationRouteUnitSuppository' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'נר',
            two: 'נרות',
            other: 'נרות',
          ),
      'administrationRouteUnitSpray' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'תרסיס',
            two: 'תרסיסים',
            other: 'תרסיסים',
          ),
      'remaining' => ({required num count, required Object unit}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: '${count} ${unit} נותרו',
            two: '${count} ${unit} נותרו',
            other: '${count} ${unit} נותרו',
          ),
      'administrationRouteUnitPatch' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'מדבקה',
            two: 'מדבקות',
            other: 'מדבקות',
          ),
      'administrationRouteUnitPump' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'משאבה',
            two: 'משאבות',
            other: 'משאבות',
          ),
      'onHrtForDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'בטיפול הורמונלי במשך יום אחד',
            two: 'בטיפול הורמונלי במשך יומיים',
            other: 'בטיפול הורמונלי במשך ${count} ימים',
          ),
      'onHrtForWeeks' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'בטיפול הורמונלי במשך שבוע אחד',
            two: 'בטיפול הורמונלי במשך שבועיים',
            other: 'בטיפול הורמונלי במשך ${count} שבועות',
          ),
      'onHrtForMonths' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'בטיפול הורמונלי במשך חודש אחד',
            two: 'בטיפול הורמונלי במשך חודשיים',
            other: 'בטיפול הורמונלי במשך ${count} חודשים',
          ),
      'onHrtForYears' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'בטיפול הורמונלי במשך שנה אחת',
            two: 'בטיפול הורמונלי במשך שנתיים',
            other: 'בטיפול הורמונלי במשך ${count} שנים',
          ),
      'intakesLoggedCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'נטילה אחת תועדה',
            two: 'נרשמו שתי נטילות',
            other: '${count} נטילות תועדו',
          ),
      'syringeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'נותר מזרק אחד',
            two: 'נותרו שני מזרקים',
            other: 'נותרו ${count} מזרקים',
          ),
      'wipeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'נותר מגבון אחד',
            two: 'נותרו שני מגבונים',
            other: 'נותרו ${count} מגבונים',
          ),
      'needleRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'נותרה מחט אחת',
            two: 'נותרו שתי מחטים',
            other: 'נותרו ${count} מחטים',
          ),
      'glovesRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'נותרה כפפה אחת',
            two: 'נותרו שתי כפפות',
            other: 'נותרו ${count} כפפות',
          ),
      'bandageRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'נותרה תחבושת אחת',
            two: 'נותרו שתי תחבושות',
            other: 'נותרו ${count} תחבושות',
          ),
      'administrationRouteUnitGram' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'גרם',
            two: 'גרם',
            other: 'גרם',
          ),
      'administrationRouteUnitImplant' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('he'))(
            count,
            one: 'שתל',
            two: 'שתלים',
            other: 'שתלים',
          ),
      _ => null,
    };
  }
}
