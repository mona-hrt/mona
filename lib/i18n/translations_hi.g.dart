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
class TranslationsHi extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsHi(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.hi,
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

  /// Metadata for the translations of <hi>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsHi _root = this; // ignore: unused_field

  @override
  TranslationsHi $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsHi(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'Mona';
  @override
  String get nav_home => 'Mona';
  @override
  String get nav_intakes => 'Khurak';
  @override
  String get nav_levels => 'Star';
  @override
  String get nav_supplies => 'Samagri';
  @override
  String get takeAnIntake => 'Khurana le';
  @override
  String get addAnItem => 'Chiz jode';
  @override
  String get empty_home => 'Setting me schedule jodke shuru kare';
  @override
  String get allDone => 'Sab hogya!';
  @override
  String get noIntakesDue => 'Aaj koi khurak bakhi nahi hai';
  @override
  String get upcoming => 'Aanewala';
  @override
  String get asNeeded => 'Zaroorat padne par';
  @override
  String get taken => 'Le liya';
  @override
  String get yesterday => 'Kal';
  @override
  String get tomorrow => 'Kal';
  @override
  String get lastTaken => 'Pichli baar';
  @override
  String get neverTakenYet => 'Abhi tak nahi li';
  @override
  String get scheduleFrequencyDaily => 'Roz';
  @override
  String get scheduleFrequencyDailyDescription => 'Har din, nishchit samay par';
  @override
  String get scheduleFrequencyInterval => 'Antaral';
  @override
  String get scheduleFrequencyIntervalDescription => 'Kuch dino me';
  @override
  String get scheduleFrequencyWeekly => 'Saptahik';
  @override
  String get scheduleFrequencyWeeklyDescription => 'Hafte ke kuch din';
  @override
  String get scheduleFrequencyMonthly => 'Somvar';
  @override
  String get scheduleFrequencyMonthlyDescription => 'Har mahine usi din';
  @override
  String get scheduleFrequencyAsNeeded => 'Zaroorat padne par';
  @override
  String get scheduleFrequencyAsNeededDescription => 'Koi fix schedule';
  @override
  String get newUpdateAvailable => 'Ekta Naya update upland hai!';
  @override
  String get goToSettings => 'Settings me jaye';
  @override
  String get settingsTitle => 'Settings';
  @override
  String get notifications => 'Suchnaye';
  @override
  String get schedulesAndNotifications => 'Schedule aur suchnaye';
  @override
  String get general => 'Samanya';
  @override
  String get schedules => 'Schedule';
  @override
  String get noSchedules => 'Koi schedule nahi';
  @override
  String get language => 'Bhasha';
  @override
  String get languageFollowDevice => 'Device ki bhasha ka palan kare';
  @override
  String get enableNotifications => 'Notification chalu kare';
  @override
  String get enableNotificationsDescription => 'Reminder bhejo';
  @override
  String get anchorToLastIntake => 'Pickle sevan ki aadhar par';
  @override
  String get anchorToLastIntakeDescription =>
      'Agli khurak ko pichli bar lene ke band ek pure antaral ke baad schedule karta hai';
  @override
  String get notificationsDisabledTitle => 'Notification band hai';
  @override
  String get clickToOpenSettings => 'Setting kholne ke liye click kare';
  @override
  String get exactRemindersDisabled => 'Satik reminded ka samay band hai';
  @override
  String get remindersDelayed =>
      'Yaad dilane me thod Der ho sakti hai settings ke liye type kare।';
  @override
  String get medicalSettings => 'Chikitsya settings';
  @override
  String get theme => 'Vishay';
  @override
  String get themeCustomizeColors => 'App ke rang badle';
  @override
  String get customThemeEnabled => 'Custom vishay';
  @override
  String get themeGenerate => 'Banaye';
  @override
  String get themeVariant => 'Alag roop';
  @override
  String get themeContrast => 'Antar';
  @override
  String get themeContrastStandard => 'Manak';
  @override
  String get themeContrastMedium => 'Madhya';
  @override
  String get themeContrastHigh => 'Uppar';
  @override
  String get autoUpdate => 'Apne aap update';
  @override
  String get autoUpdateDescription =>
      'Apne aap check jab naye updates launch ho jayenge';
  @override
  String get checkForUpdates => 'Updates dekhe';
  @override
  String get checkForUpdatesDescription =>
      'Naye version ke liye manually check kare\n yeh aapko internet se connect karega\(Koi data nahi milega)';
  @override
  String appVersion({required Object version}) => 'मोना संस्करण ${version}';
  @override
  String get backupSaved => 'बैकअप बचाया';
  @override
  String exportFailed({required Object error}) =>
      'निर्यात करने में विफल: ${error}';
  @override
  String get importDataTitle => 'आयात डेटा';
  @override
  String get importDataSubtitle => 'JSON बैकअप से डेटा पुनर्स्थापित करें';
  @override
  String get importDataOverwriteWarning =>
      'यह बैकअप के साथ अपने सभी वर्तमान डेटा को ओवरराइट करेगा। यह कार्रवाई नहीं की जा सकती है। क्या आप जारी रखना चाहते हैं?';
  @override
  String get importConfirm => 'आयात';
  @override
  String get importSuccessfulTitle => 'सफल आयात';
  @override
  String get importRestartRequired =>
      'कृपया ऐप को पुनर्स्थापित किए गए डेटा को लागू करने के लिए पुनः आरंभ करें।।';
  @override
  String get closeApp => 'ऐप बंद करें';
  @override
  String importFailed({required Object error}) =>
      'आयात करने में विफल: ${error}';
  @override
  String get updates => 'अपडेट';
  @override
  String get dataManagement => 'डेटा प्रबंधन';
  @override
  String get exportDataTitle => 'डेटा निर्यात करें';
  @override
  String get exportDataSubtitle => 'अपने डेटा को JSON फाइल में सेव करें';
  @override
  String get units => 'यूनिट';
  @override
  String get updateNoCompatibleApk =>
      'आपके डिवाइस के लिए कोई संगत अपडेट नहीं मिला।।';
  @override
  String get updateAppUpToDate => 'आपका ऐप तारीख तक है!';
  @override
  String get updateCheckNetworkError => 'अभी अद्यतन की जाँच नहीं कर सका।।';
  @override
  String get updateDialogTitle => 'अद्यतन उपलब्ध';
  @override
  String updateDialogBody({required Object latest, required Object current}) =>
      'संस्करण ${latest} उपलब्ध है! (Current: ${current}) \n \nAn अद्यतन अपने डिवाइस के साथ संगत स्थापित करने के लिए तैयार है।।';
  @override
  String get updateDownloadAndInstall => 'डाउनलोड करें';
  @override
  String get updateInstallPermissionRequired =>
      'अनुमति अद्यतन स्थापित करने के लिए आवश्यक है।।';
  @override
  String get updateDownloadingTitle => 'डाउनलोड करें अद्यतन..।';
  @override
  String updateFailedOpenInstaller({required Object message}) =>
      'खोलने के लिए विफल: ${message}';
  @override
  String get updateDownloadFailed =>
      'डाउनलोड विफल रहा। कृपया अपने कनेक्शन की जांच करें।।';
  @override
  String get secretSettings => 'गुप्त सेटिंग्स';
  @override
  String get slimeMode => 'स्लिम मोड';
  @override
  String notificationMedicationReminderTitle({required Object scheduleName}) =>
      'समय लेने के लिए ${scheduleName}';
  @override
  String notificationMedicationReminderBodyDate({required Object date}) =>
      '${date} के लिए अनुसूचित';
  @override
  String notificationMedicationReminderBodyTime({required Object time}) =>
      '${time} के लिए अनुसूचित';
  @override
  String notificationMedicationReminderBodyWeekday({required Object weekday}) =>
      '${weekday} के लिए अनुसूचित';
  @override
  String get addSchedule => 'एक अनुसूची जोड़ें';
  @override
  String get addScheduleToGetStarted => 'शुरू करने के लिए एक अनुसूची जोड़ें।।';
  @override
  String get newSchedule => 'नया कार्यक्रम';
  @override
  String get every => 'हर';
  @override
  String get days => 'दिन';
  @override
  String get dayOfMonth => 'महीना';
  @override
  String get months => 'Mahine';
  @override
  String get startDate => 'प्रारंभ तिथि';
  @override
  String get pickATime => 'एक समय चुनें';
  @override
  String get addIntakeTime => 'समय जोड़ें';
  @override
  String get editScheduleInfo => 'अनुसूची जानकारी संपादित करें';
  @override
  String get scheduling => 'शेड्यूलिंग';
  @override
  String get editSchedule => 'संपादित करें';
  @override
  String deleteSchedule({required Object name}) => '${name}?';
  @override
  String get addNotification => 'अधिसूचना जोड़ें';
  @override
  String get empty_intakes => 'ले लिया गया सेवन यहाँ दिखाई देगा';
  @override
  String get HrtCounter => 'HRT पर समय';
  @override
  String get HrtCounterDescription =>
      'जब तक आप एचआरटी और आपके कुल सेवन पर रहे हैं, तब तक दिखाएं';
  @override
  String get hrtWidgetPlaceholder =>
      'अपना पहला सेवन लॉग इन करने के लिए मोना खोलें';
  @override
  String get hrtWidgetPreviewSample => '8 महीने के लिए HRT पर';
  @override
  String get hrtWidgetPreviewIntakeSample => '16 सेवन लॉग इन';
  @override
  String startOfDayDescription({required Object time}) =>
      'समय पहले ${time} पिछले दिन की ओर गिनती';
  @override
  String get chooseSchedule => 'एक अनुसूची चुनें';
  @override
  String get addSchedulesFirst => 'पहले शेड्यूल जोड़ें।।';
  @override
  String get editIntake => 'सेवन संपादित करें';
  @override
  String get date => 'तारीख';
  @override
  String get amount => 'राशि';
  @override
  String get takenAmount => 'ली गई राशि';
  @override
  String get wastedAmount => 'अपशिष्ट राशि';
  @override
  String get none => 'कोई नहीं';
  @override
  String get startOfDay => 'दिन की शुरुआत';
  @override
  String get supplyItem => 'आपूर्ति आइटम';
  @override
  String get chooseItem => 'एक आइटम चुनें';
  @override
  String get noItemsToAdd => 'उपलब्ध नहीं है';
  @override
  String get injectionSide => 'इंजेक्शन साइड';
  @override
  String get deleteIntake => 'इस सेवन को हटा दें?';
  @override
  String takeMedication({required Object scheduleName}) => '${scheduleName}';
  @override
  String get takeIntake => 'सेवन करें';
  @override
  String get intakeRecorded => 'दर्ज करना';
  @override
  String get needleDeadSpace => 'सुई मृत अंतरिक्ष';
  @override
  String get notes => 'नोट';
  @override
  String get microliters => 'μL';
  @override
  String get milliliters => 'एमएल';
  @override
  String get empty_levels =>
      'एक रक्त परीक्षण जोड़ें या शुरू करने के लिए एक एस्ट्राडियोल इंजेक्शन लॉग इन करें';
  @override
  String get bloodTestsTitle => 'रक्त परीक्षण';
  @override
  String get estradiolLevelsTitle => 'एस्ट्राडियोल स्तर';
  @override
  String get week => 'डब्ल्यू';
  @override
  String get twoWeeks => '2 डब्ल्यू';
  @override
  String get threeMonths => '3 एम';
  @override
  String get sixMonths => '6 एम';
  @override
  String get month => 'एम';
  @override
  String get year => 'वाई';
  @override
  String get empty_blood_tests =>
      'रक्त परीक्षण यहाँ दिखाई देगा। ऐड बटन का उपयोग करके शुरू करें!';
  @override
  String get addBloodTest => 'रक्त परीक्षण जोड़ें';
  @override
  String get editBloodTest => 'रक्त परीक्षण';
  @override
  String get newBloodTest => 'न्यू ब्लड टेस्ट';
  @override
  String get deleteBloodTest => 'इस रक्त परीक्षण को हटा दें?';
  @override
  String get estradiolLevelLabel => 'एस्ट्राडियोल स्तर';
  @override
  String get testosteroneLevelLabel => 'टेस्टोस्टेरोन का स्तर';
  @override
  String get bloodTestDateLabel => 'परीक्षा तिथि';
  @override
  String chartNowConcentration({required Object value}) => 'अब ${value}';
  @override
  String chartBloodTestLevelTooltip(
          {required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String chartLevelTooltip({required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String get empty_supplies =>
      'कोई आपूर्ति नहीं। शुरू करने के लिए एक आइटम जोड़ें।।';
  @override
  String get newItem => 'नया आइटम';
  @override
  String get adminRoute => 'प्रशासन मार्ग';
  @override
  String get totalAmount => 'कुल राशि';
  @override
  String get concentration => 'एकाग्रता';
  @override
  String dosePerUnitLabel({required Object unit}) => 'प्रति खुराक ${unit}';
  @override
  String get editItem => 'आइटम जोड़ें';
  @override
  String get usedAmount => 'प्रयुक्त राशि';
  @override
  String deleteItem({required Object name}) => '${name}?';
  @override
  String get allItemsFilter => 'सब';
  @override
  String get medicationItemsFilter => 'दवा';
  @override
  String get genericItems => 'उपभोग्य';
  @override
  String get medicationItemType => 'दवा';
  @override
  String get genericItemType => 'उपभोग्य';
  @override
  String get supplyType => 'प्रकार';
  @override
  String get syringe => 'सिरिंज';
  @override
  String get wipe => 'वाइप्स';
  @override
  String get needle => 'सुई';
  @override
  String get gloves => 'दस्ताने';
  @override
  String get bandage => 'बंधन';
  @override
  String get add => 'जोड़ें';
  @override
  String get save => 'सहेजें';
  @override
  String get cancel => 'रद्द करना';
  @override
  String get next => 'अगला';
  @override
  String get delete => 'डिलीट';
  @override
  String get deleteElement => 'इस मद को हटाएं?';
  @override
  String get irreversibleAction => 'यह कार्रवाई नहीं हो सकती है।।';
  @override
  String get name => 'नाम';
  @override
  String get molecule => 'मोलेकुल';
  @override
  String get ester => 'एस्टर';
  @override
  String get estradiol => 'एस्ट्राडियोल';
  @override
  String get progesterone => 'प्रोजेस्टेरोन';
  @override
  String get testosterone => 'टेस्टोस्टेरोन';
  @override
  String get nandrolone => 'नांद्र';
  @override
  String get dihydrotestosterone => 'Dihydrotestosterone';
  @override
  String get spironolactone => 'Spironolactone';
  @override
  String get cyproteroneAcetate => 'Cyproterone एसीटेट';
  @override
  String get leuprorelinAcetate => 'ल्यूप्रोरेलिन एसीटेट';
  @override
  String get bicalutamide => 'Bicalutamide';
  @override
  String get decapeptyl => 'Decapeptyl';
  @override
  String get raloxifene => 'रालॉक्सीफेन';
  @override
  String get tamoxifen => 'टैमोक्सीफेन';
  @override
  String get finasteride => 'फिनस्टराइड';
  @override
  String get dutasteride => 'Dutasteride';
  @override
  String get minoxidil => 'मिनोक्सिडिल';
  @override
  String get pioglitazone => 'Pioglitazone';
  @override
  String get enanthate => 'Enanthate';
  @override
  String get valerate => 'वैलेरेट';
  @override
  String get cypionate => 'साइटमैप';
  @override
  String get undecylate => 'Undecylate';
  @override
  String get benzoate => 'बेंजोएट';
  @override
  String get cypionateSuspension => 'Cypionate निलंबन';
  @override
  String get medicationEstradiolEnanthate => 'Estradiol enanthate';
  @override
  String get medicationEstradiolValerate => 'Estradiol valerate';
  @override
  String get medicationEstradiolCypionate => 'Estradiol cypionate';
  @override
  String get medicationEstradiolUndecylate => 'Estradiol undecylate';
  @override
  String get medicationEstradiolBenzoate => 'Estradiol बेंजोएट';
  @override
  String get medicationEstradiolCypionateSuspension =>
      'Estradiol cypionate निलंबन';
  @override
  String get medicationTestosteroneEnanthate => 'टेस्टोस्टेरोन enanthate';
  @override
  String get medicationTestosteroneValerate => 'टेस्टोस्टेरोन valerate';
  @override
  String get medicationTestosteroneCypionate => 'टेस्टोस्टेरोन cypionate';
  @override
  String get medicationTestosteroneUndecylate => 'टेस्टोस्टेरोन undecylate';
  @override
  String get medicationTestosteroneBenzoate => 'टेस्टोस्टेरोन benzoate';
  @override
  String get medicationTestosteroneCypionateSuspension =>
      'टेस्टोस्टेरोन साइपीओनेट निलंबन';
  @override
  String get injection => 'इंजेक्शन';
  @override
  String get oral => 'मौखिक';
  @override
  String get sublingual => 'बहुभाषी';
  @override
  String get patch => 'पैच';
  @override
  String get gel => 'जेल';
  @override
  String get implant => 'प्रत्यारोपण';
  @override
  String get suppository => 'सपोसिटरी';
  @override
  String get transdermalSpray => 'ट्रांसडर्मल स्प्रे';
  @override
  String get transdermalDrops => 'ट्रांसडर्मल ड्रॉप';
  @override
  String get deliveryForm => 'फॉर्म';
  @override
  String get deliveryFormPump => 'पम्प';
  @override
  String get deliveryFormSachet => 'साचेत';
  @override
  String get deliveryFormGram => 'ट्यूब';
  @override
  String get unitMilligram => 'मिलीग्राम';
  @override
  String get unitMicrogramPerDay => 'μg / दिन';
  @override
  String get unitPgPerMl => 'pg/ml';
  @override
  String get unitPmolPerL => 'pmol';
  @override
  String get unitNgPerDl => 'ng/dl';
  @override
  String get unitNmolPerL => 'nmol/L';
  @override
  String get unitNgPerMl => 'एनजी / एमएल';
  @override
  String get injectionSideLeft => 'बाएं';
  @override
  String get injectionSideRight => 'अधिकार';
  @override
  String get placementLeft => 'बाएं तरफ';
  @override
  String get placementRight => 'सही पक्ष';
  @override
  String get placementLeftThigh => 'बाएं जांघ';
  @override
  String get placementRightThigh => 'सही जांघ';
  @override
  String get placementLeftArm => 'बाएं हाथ';
  @override
  String get placementRightArm => 'दाहिने हाथ';
  @override
  String get placementLeftButtock => 'बाएं बटॉक';
  @override
  String get placementRightButtock => 'राइट बटॉक';
  @override
  String get placementLeftAbdomen => 'बाएं पेट';
  @override
  String get placementRightAbdomen => 'दाहिने पेट';
  @override
  String get applicationSites => 'अनुप्रयोग साइट';
  @override
  String get applicationSitesDescription =>
      'उन साइटों को प्रबंधित करें जो आप के बीच घूमते हैं';
  @override
  String get applicationSitesInstructions =>
      'उन साइटों को प्रबंधित करें जो आप के बीच घूमते हैं। साइट्स को आपके सेवन इतिहास के आधार पर सुझाव दिया जाता है। फिर से व्यवस्थित करने के लिए लंबे प्रेस।।';
  @override
  String get addApplicationSite => 'साइट जोड़ें';
  @override
  String get customSiteLabel => 'कस्टम साइट नाम';
  @override
  String get noApplicationSitesYet => 'अभी तक कोई साइट नहीं';
  @override
  String get addSiteToGetStarted => 'शुरू करने के लिए नीचे एक साइट जोड़ें।।';
  @override
  String get placementSuggestionPerScheduleTitle => 'प्रति अनुसूची सुझाव';
  @override
  String get placementSuggestionPerScheduleDescription =>
      'इस कार्यक्रम के इतिहास पर अगले साइट सुझाव को बेस करें।।';
  @override
  String get requiredField => 'आवश्यक फ़ील्ड';
  @override
  String get mustBePositiveNumber => 'एक सकारात्मक संख्या होना चाहिए';
  @override
  String get mustBeBetween1And28 => '1 और 28 के बीच होना चाहिए';
  @override
  String mustBeAtMost({required Object max}) => '${max}';
  @override
  String get invalidTotalAmount => 'कुल राशि';
  @override
  String get cannotExceedTotalCapacity => 'कुल क्षमता से अधिक नहीं';
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} pehle',
        other: '${count} pehle',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} Dinon me',
        other: '${count} Dinon me',
      );
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'Har din',
        other: 'Har ${count} din',
      );
  @override
  String scheduleFrequencyOnDayEveryNMonths(
          {required num count, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'Din ${day}, har mahine',
        other: 'Har ${count}, mahine, ${day} tarikh',
      );
  @override
  String schedulesCreated({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} manage gaye',
        other: '${count} banaye gaye',
      );
  @override
  String onHrtForDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} दिनों के लिए HRT पर',
        other: '${count} दिनों के लिए HRT पर',
      );
  @override
  String onHrtForMonths({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} महीनों के लिए HRT पर',
        other: '${count} महीनों के लिए HRT पर',
      );
  @override
  String onHrtForWeeks({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'HRT on ${count} week',
        other: 'HRT on ${count} week',
      );
  @override
  String onHrtForYears({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'HRT पर ${count} वर्ष',
        other: 'HRT पर ${count} वर्ष',
      );
  @override
  String intakesLoggedCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} प्रवेश लॉग इन',
        other: '${count} प्रवेश लॉग इन',
      );
  @override
  String remaining({required num count, required Object unit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} ${unit} शेष',
        other: '${count} ${unit} शेष',
      );
  @override
  String syringeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} syringes शेष',
        other: '${count} syringes शेष',
      );
  @override
  String wipeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} शेष पोंछे',
        other: '${count} शेष पोंछे',
      );
  @override
  String needleRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} सुई शेष',
        other: '${count} सुई शेष',
      );
  @override
  String glovesRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} दस्ताने शेष',
        other: '${count} दस्ताने शेष',
      );
  @override
  String bandageRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: '${count} बैंडेज शेष',
        other: '${count} बैंडेज शेष',
      );
  @override
  String administrationRouteUnitMl({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'एमएल',
        other: 'एमएल',
      );
  @override
  String administrationRouteUnitPill({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'गोलियाँ',
        other: 'गोलियाँ',
      );
  @override
  String administrationRouteUnitPatch({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'पैच',
        other: 'पैच',
      );
  @override
  String administrationRouteUnitPump({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'पंप',
        other: 'पंप',
      );
  @override
  String administrationRouteUnitSachet({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'पाउच',
        other: 'पाउच',
      );
  @override
  String administrationRouteUnitGram({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'ग्राम',
        other: 'ग्राम',
      );
  @override
  String administrationRouteUnitImplant({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'प्रत्यारोपण',
        other: 'प्रत्यारोपण',
      );
  @override
  String administrationRouteUnitSuppository({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'सट्टा',
        other: 'सट्टा',
      );
  @override
  String administrationRouteUnitSpray({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
        count,
        one: 'स्प्रे',
        other: 'स्प्रे',
      );
}

/// The flat map containing all translations for locale <hi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsHi {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'Mona',
      'nav_home' => 'Mona',
      'nav_intakes' => 'Khurak',
      'nav_levels' => 'Star',
      'nav_supplies' => 'Samagri',
      'takeAnIntake' => 'Khurana le',
      'addAnItem' => 'Chiz jode',
      'empty_home' => 'Setting me schedule jodke shuru kare',
      'allDone' => 'Sab hogya!',
      'noIntakesDue' => 'Aaj koi khurak bakhi nahi hai',
      'upcoming' => 'Aanewala',
      'asNeeded' => 'Zaroorat padne par',
      'taken' => 'Le liya',
      'yesterday' => 'Kal',
      'tomorrow' => 'Kal',
      'lastTaken' => 'Pichli baar',
      'neverTakenYet' => 'Abhi tak nahi li',
      'scheduleFrequencyDaily' => 'Roz',
      'scheduleFrequencyDailyDescription' => 'Har din, nishchit samay par',
      'scheduleFrequencyInterval' => 'Antaral',
      'scheduleFrequencyIntervalDescription' => 'Kuch dino me',
      'scheduleFrequencyWeekly' => 'Saptahik',
      'scheduleFrequencyWeeklyDescription' => 'Hafte ke kuch din',
      'scheduleFrequencyMonthly' => 'Somvar',
      'scheduleFrequencyMonthlyDescription' => 'Har mahine usi din',
      'scheduleFrequencyAsNeeded' => 'Zaroorat padne par',
      'scheduleFrequencyAsNeededDescription' => 'Koi fix schedule',
      'newUpdateAvailable' => 'Ekta Naya update upland hai!',
      'goToSettings' => 'Settings me jaye',
      'settingsTitle' => 'Settings',
      'notifications' => 'Suchnaye',
      'schedulesAndNotifications' => 'Schedule aur suchnaye',
      'general' => 'Samanya',
      'schedules' => 'Schedule',
      'noSchedules' => 'Koi schedule nahi',
      'language' => 'Bhasha',
      'languageFollowDevice' => 'Device ki bhasha ka palan kare',
      'enableNotifications' => 'Notification chalu kare',
      'enableNotificationsDescription' => 'Reminder bhejo',
      'anchorToLastIntake' => 'Pickle sevan ki aadhar par',
      'anchorToLastIntakeDescription' =>
        'Agli khurak ko pichli bar lene ke band ek pure antaral ke baad schedule karta hai',
      'notificationsDisabledTitle' => 'Notification band hai',
      'clickToOpenSettings' => 'Setting kholne ke liye click kare',
      'exactRemindersDisabled' => 'Satik reminded ka samay band hai',
      'remindersDelayed' =>
        'Yaad dilane me thod Der ho sakti hai settings ke liye type kare।',
      'medicalSettings' => 'Chikitsya settings',
      'theme' => 'Vishay',
      'themeCustomizeColors' => 'App ke rang badle',
      'customThemeEnabled' => 'Custom vishay',
      'themeGenerate' => 'Banaye',
      'themeVariant' => 'Alag roop',
      'themeContrast' => 'Antar',
      'themeContrastStandard' => 'Manak',
      'themeContrastMedium' => 'Madhya',
      'themeContrastHigh' => 'Uppar',
      'autoUpdate' => 'Apne aap update',
      'autoUpdateDescription' =>
        'Apne aap check jab naye updates launch ho jayenge',
      'checkForUpdates' => 'Updates dekhe',
      'checkForUpdatesDescription' =>
        'Naye version ke liye manually check kare\n yeh aapko internet se connect karega\(Koi data nahi milega)',
      'appVersion' => ({required Object version}) => 'मोना संस्करण ${version}',
      'backupSaved' => 'बैकअप बचाया',
      'exportFailed' => ({required Object error}) =>
          'निर्यात करने में विफल: ${error}',
      'importDataTitle' => 'आयात डेटा',
      'importDataSubtitle' => 'JSON बैकअप से डेटा पुनर्स्थापित करें',
      'importDataOverwriteWarning' =>
        'यह बैकअप के साथ अपने सभी वर्तमान डेटा को ओवरराइट करेगा। यह कार्रवाई नहीं की जा सकती है। क्या आप जारी रखना चाहते हैं?',
      'importConfirm' => 'आयात',
      'importSuccessfulTitle' => 'सफल आयात',
      'importRestartRequired' =>
        'कृपया ऐप को पुनर्स्थापित किए गए डेटा को लागू करने के लिए पुनः आरंभ करें।।',
      'closeApp' => 'ऐप बंद करें',
      'importFailed' => ({required Object error}) =>
          'आयात करने में विफल: ${error}',
      'updates' => 'अपडेट',
      'dataManagement' => 'डेटा प्रबंधन',
      'exportDataTitle' => 'डेटा निर्यात करें',
      'exportDataSubtitle' => 'अपने डेटा को JSON फाइल में सेव करें',
      'units' => 'यूनिट',
      'updateNoCompatibleApk' =>
        'आपके डिवाइस के लिए कोई संगत अपडेट नहीं मिला।।',
      'updateAppUpToDate' => 'आपका ऐप तारीख तक है!',
      'updateCheckNetworkError' => 'अभी अद्यतन की जाँच नहीं कर सका।।',
      'updateDialogTitle' => 'अद्यतन उपलब्ध',
      'updateDialogBody' => (
              {required Object latest, required Object current}) =>
          'संस्करण ${latest} उपलब्ध है! (Current: ${current}) \n \nAn अद्यतन अपने डिवाइस के साथ संगत स्थापित करने के लिए तैयार है।।',
      'updateDownloadAndInstall' => 'डाउनलोड करें',
      'updateInstallPermissionRequired' =>
        'अनुमति अद्यतन स्थापित करने के लिए आवश्यक है।।',
      'updateDownloadingTitle' => 'डाउनलोड करें अद्यतन..।',
      'updateFailedOpenInstaller' => ({required Object message}) =>
          'खोलने के लिए विफल: ${message}',
      'updateDownloadFailed' =>
        'डाउनलोड विफल रहा। कृपया अपने कनेक्शन की जांच करें।।',
      'secretSettings' => 'गुप्त सेटिंग्स',
      'slimeMode' => 'स्लिम मोड',
      'notificationMedicationReminderTitle' =>
        ({required Object scheduleName}) => 'समय लेने के लिए ${scheduleName}',
      'notificationMedicationReminderBodyDate' => ({required Object date}) =>
          '${date} के लिए अनुसूचित',
      'notificationMedicationReminderBodyTime' => ({required Object time}) =>
          '${time} के लिए अनुसूचित',
      'notificationMedicationReminderBodyWeekday' =>
        ({required Object weekday}) => '${weekday} के लिए अनुसूचित',
      'addSchedule' => 'एक अनुसूची जोड़ें',
      'addScheduleToGetStarted' => 'शुरू करने के लिए एक अनुसूची जोड़ें।।',
      'newSchedule' => 'नया कार्यक्रम',
      'every' => 'हर',
      'days' => 'दिन',
      'dayOfMonth' => 'महीना',
      'months' => 'Mahine',
      'startDate' => 'प्रारंभ तिथि',
      'pickATime' => 'एक समय चुनें',
      'addIntakeTime' => 'समय जोड़ें',
      'editScheduleInfo' => 'अनुसूची जानकारी संपादित करें',
      'scheduling' => 'शेड्यूलिंग',
      'editSchedule' => 'संपादित करें',
      'deleteSchedule' => ({required Object name}) => '${name}?',
      'addNotification' => 'अधिसूचना जोड़ें',
      'empty_intakes' => 'ले लिया गया सेवन यहाँ दिखाई देगा',
      'HrtCounter' => 'HRT पर समय',
      'HrtCounterDescription' =>
        'जब तक आप एचआरटी और आपके कुल सेवन पर रहे हैं, तब तक दिखाएं',
      'hrtWidgetPlaceholder' => 'अपना पहला सेवन लॉग इन करने के लिए मोना खोलें',
      'hrtWidgetPreviewSample' => '8 महीने के लिए HRT पर',
      'hrtWidgetPreviewIntakeSample' => '16 सेवन लॉग इन',
      'startOfDayDescription' => ({required Object time}) =>
          'समय पहले ${time} पिछले दिन की ओर गिनती',
      'chooseSchedule' => 'एक अनुसूची चुनें',
      'addSchedulesFirst' => 'पहले शेड्यूल जोड़ें।।',
      'editIntake' => 'सेवन संपादित करें',
      'date' => 'तारीख',
      'amount' => 'राशि',
      'takenAmount' => 'ली गई राशि',
      'wastedAmount' => 'अपशिष्ट राशि',
      'none' => 'कोई नहीं',
      'startOfDay' => 'दिन की शुरुआत',
      'supplyItem' => 'आपूर्ति आइटम',
      'chooseItem' => 'एक आइटम चुनें',
      'noItemsToAdd' => 'उपलब्ध नहीं है',
      'injectionSide' => 'इंजेक्शन साइड',
      'deleteIntake' => 'इस सेवन को हटा दें?',
      'takeMedication' => ({required Object scheduleName}) => '${scheduleName}',
      'takeIntake' => 'सेवन करें',
      'intakeRecorded' => 'दर्ज करना',
      'needleDeadSpace' => 'सुई मृत अंतरिक्ष',
      'notes' => 'नोट',
      'microliters' => 'μL',
      'milliliters' => 'एमएल',
      'empty_levels' =>
        'एक रक्त परीक्षण जोड़ें या शुरू करने के लिए एक एस्ट्राडियोल इंजेक्शन लॉग इन करें',
      'bloodTestsTitle' => 'रक्त परीक्षण',
      'estradiolLevelsTitle' => 'एस्ट्राडियोल स्तर',
      'week' => 'डब्ल्यू',
      'twoWeeks' => '2 डब्ल्यू',
      'threeMonths' => '3 एम',
      'sixMonths' => '6 एम',
      'month' => 'एम',
      'year' => 'वाई',
      'empty_blood_tests' =>
        'रक्त परीक्षण यहाँ दिखाई देगा। ऐड बटन का उपयोग करके शुरू करें!',
      'addBloodTest' => 'रक्त परीक्षण जोड़ें',
      'editBloodTest' => 'रक्त परीक्षण',
      'newBloodTest' => 'न्यू ब्लड टेस्ट',
      'deleteBloodTest' => 'इस रक्त परीक्षण को हटा दें?',
      'estradiolLevelLabel' => 'एस्ट्राडियोल स्तर',
      'testosteroneLevelLabel' => 'टेस्टोस्टेरोन का स्तर',
      'bloodTestDateLabel' => 'परीक्षा तिथि',
      'chartNowConcentration' => ({required Object value}) => 'अब ${value}',
      'chartBloodTestLevelTooltip' =>
        ({required Object date, required Object level}) => '${date}: ${level}',
      'chartLevelTooltip' => ({required Object date, required Object level}) =>
          '${date}: ${level}',
      'empty_supplies' => 'कोई आपूर्ति नहीं। शुरू करने के लिए एक आइटम जोड़ें।।',
      'newItem' => 'नया आइटम',
      'adminRoute' => 'प्रशासन मार्ग',
      'totalAmount' => 'कुल राशि',
      'concentration' => 'एकाग्रता',
      'dosePerUnitLabel' => ({required Object unit}) => 'प्रति खुराक ${unit}',
      'editItem' => 'आइटम जोड़ें',
      'usedAmount' => 'प्रयुक्त राशि',
      'deleteItem' => ({required Object name}) => '${name}?',
      'allItemsFilter' => 'सब',
      'medicationItemsFilter' => 'दवा',
      'genericItems' => 'उपभोग्य',
      'medicationItemType' => 'दवा',
      'genericItemType' => 'उपभोग्य',
      'supplyType' => 'प्रकार',
      'syringe' => 'सिरिंज',
      'wipe' => 'वाइप्स',
      'needle' => 'सुई',
      'gloves' => 'दस्ताने',
      'bandage' => 'बंधन',
      'add' => 'जोड़ें',
      'save' => 'सहेजें',
      'cancel' => 'रद्द करना',
      'next' => 'अगला',
      'delete' => 'डिलीट',
      'deleteElement' => 'इस मद को हटाएं?',
      'irreversibleAction' => 'यह कार्रवाई नहीं हो सकती है।।',
      'name' => 'नाम',
      'molecule' => 'मोलेकुल',
      'ester' => 'एस्टर',
      'estradiol' => 'एस्ट्राडियोल',
      'progesterone' => 'प्रोजेस्टेरोन',
      'testosterone' => 'टेस्टोस्टेरोन',
      'nandrolone' => 'नांद्र',
      'dihydrotestosterone' => 'Dihydrotestosterone',
      'spironolactone' => 'Spironolactone',
      'cyproteroneAcetate' => 'Cyproterone एसीटेट',
      'leuprorelinAcetate' => 'ल्यूप्रोरेलिन एसीटेट',
      'bicalutamide' => 'Bicalutamide',
      'decapeptyl' => 'Decapeptyl',
      'raloxifene' => 'रालॉक्सीफेन',
      'tamoxifen' => 'टैमोक्सीफेन',
      'finasteride' => 'फिनस्टराइड',
      'dutasteride' => 'Dutasteride',
      'minoxidil' => 'मिनोक्सिडिल',
      'pioglitazone' => 'Pioglitazone',
      'enanthate' => 'Enanthate',
      'valerate' => 'वैलेरेट',
      'cypionate' => 'साइटमैप',
      'undecylate' => 'Undecylate',
      'benzoate' => 'बेंजोएट',
      'cypionateSuspension' => 'Cypionate निलंबन',
      'medicationEstradiolEnanthate' => 'Estradiol enanthate',
      'medicationEstradiolValerate' => 'Estradiol valerate',
      'medicationEstradiolCypionate' => 'Estradiol cypionate',
      'medicationEstradiolUndecylate' => 'Estradiol undecylate',
      'medicationEstradiolBenzoate' => 'Estradiol बेंजोएट',
      'medicationEstradiolCypionateSuspension' => 'Estradiol cypionate निलंबन',
      'medicationTestosteroneEnanthate' => 'टेस्टोस्टेरोन enanthate',
      'medicationTestosteroneValerate' => 'टेस्टोस्टेरोन valerate',
      'medicationTestosteroneCypionate' => 'टेस्टोस्टेरोन cypionate',
      'medicationTestosteroneUndecylate' => 'टेस्टोस्टेरोन undecylate',
      'medicationTestosteroneBenzoate' => 'टेस्टोस्टेरोन benzoate',
      'medicationTestosteroneCypionateSuspension' =>
        'टेस्टोस्टेरोन साइपीओनेट निलंबन',
      'injection' => 'इंजेक्शन',
      'oral' => 'मौखिक',
      'sublingual' => 'बहुभाषी',
      'patch' => 'पैच',
      'gel' => 'जेल',
      'implant' => 'प्रत्यारोपण',
      'suppository' => 'सपोसिटरी',
      'transdermalSpray' => 'ट्रांसडर्मल स्प्रे',
      'transdermalDrops' => 'ट्रांसडर्मल ड्रॉप',
      'deliveryForm' => 'फॉर्म',
      'deliveryFormPump' => 'पम्प',
      'deliveryFormSachet' => 'साचेत',
      'deliveryFormGram' => 'ट्यूब',
      'unitMilligram' => 'मिलीग्राम',
      'unitMicrogramPerDay' => 'μg / दिन',
      'unitPgPerMl' => 'pg/ml',
      'unitPmolPerL' => 'pmol',
      'unitNgPerDl' => 'ng/dl',
      'unitNmolPerL' => 'nmol/L',
      'unitNgPerMl' => 'एनजी / एमएल',
      'injectionSideLeft' => 'बाएं',
      'injectionSideRight' => 'अधिकार',
      'placementLeft' => 'बाएं तरफ',
      'placementRight' => 'सही पक्ष',
      'placementLeftThigh' => 'बाएं जांघ',
      'placementRightThigh' => 'सही जांघ',
      'placementLeftArm' => 'बाएं हाथ',
      'placementRightArm' => 'दाहिने हाथ',
      'placementLeftButtock' => 'बाएं बटॉक',
      'placementRightButtock' => 'राइट बटॉक',
      'placementLeftAbdomen' => 'बाएं पेट',
      'placementRightAbdomen' => 'दाहिने पेट',
      'applicationSites' => 'अनुप्रयोग साइट',
      'applicationSitesDescription' =>
        'उन साइटों को प्रबंधित करें जो आप के बीच घूमते हैं',
      'applicationSitesInstructions' =>
        'उन साइटों को प्रबंधित करें जो आप के बीच घूमते हैं। साइट्स को आपके सेवन इतिहास के आधार पर सुझाव दिया जाता है। फिर से व्यवस्थित करने के लिए लंबे प्रेस।।',
      'addApplicationSite' => 'साइट जोड़ें',
      'customSiteLabel' => 'कस्टम साइट नाम',
      'noApplicationSitesYet' => 'अभी तक कोई साइट नहीं',
      'addSiteToGetStarted' => 'शुरू करने के लिए नीचे एक साइट जोड़ें।।',
      'placementSuggestionPerScheduleTitle' => 'प्रति अनुसूची सुझाव',
      'placementSuggestionPerScheduleDescription' =>
        'इस कार्यक्रम के इतिहास पर अगले साइट सुझाव को बेस करें।।',
      'requiredField' => 'आवश्यक फ़ील्ड',
      'mustBePositiveNumber' => 'एक सकारात्मक संख्या होना चाहिए',
      'mustBeBetween1And28' => '1 और 28 के बीच होना चाहिए',
      'mustBeAtMost' => ({required Object max}) => '${max}',
      'invalidTotalAmount' => 'कुल राशि',
      'cannotExceedTotalCapacity' => 'कुल क्षमता से अधिक नहीं',
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} pehle',
            other: '${count} pehle',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} Dinon me',
            other: '${count} Dinon me',
          ),
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'Har din',
            other: 'Har ${count} din',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'Din ${day}, har mahine',
            other: 'Har ${count}, mahine, ${day} tarikh',
          ),
      'schedulesCreated' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} manage gaye',
            other: '${count} banaye gaye',
          ),
      'onHrtForDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} दिनों के लिए HRT पर',
            other: '${count} दिनों के लिए HRT पर',
          ),
      'onHrtForMonths' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} महीनों के लिए HRT पर',
            other: '${count} महीनों के लिए HRT पर',
          ),
      'onHrtForWeeks' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'HRT on ${count} week',
            other: 'HRT on ${count} week',
          ),
      'onHrtForYears' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'HRT पर ${count} वर्ष',
            other: 'HRT पर ${count} वर्ष',
          ),
      'intakesLoggedCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} प्रवेश लॉग इन',
            other: '${count} प्रवेश लॉग इन',
          ),
      'remaining' => ({required num count, required Object unit}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} ${unit} शेष',
            other: '${count} ${unit} शेष',
          ),
      'syringeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} syringes शेष',
            other: '${count} syringes शेष',
          ),
      'wipeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} शेष पोंछे',
            other: '${count} शेष पोंछे',
          ),
      'needleRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} सुई शेष',
            other: '${count} सुई शेष',
          ),
      'glovesRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} दस्ताने शेष',
            other: '${count} दस्ताने शेष',
          ),
      'bandageRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: '${count} बैंडेज शेष',
            other: '${count} बैंडेज शेष',
          ),
      'administrationRouteUnitMl' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'एमएल',
            other: 'एमएल',
          ),
      'administrationRouteUnitPill' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'गोलियाँ',
            other: 'गोलियाँ',
          ),
      'administrationRouteUnitPatch' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'पैच',
            other: 'पैच',
          ),
      'administrationRouteUnitPump' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'पंप',
            other: 'पंप',
          ),
      'administrationRouteUnitSachet' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'पाउच',
            other: 'पाउच',
          ),
      'administrationRouteUnitGram' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'ग्राम',
            other: 'ग्राम',
          ),
      'administrationRouteUnitImplant' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'प्रत्यारोपण',
            other: 'प्रत्यारोपण',
          ),
      'administrationRouteUnitSuppository' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'सट्टा',
            other: 'सट्टा',
          ),
      'administrationRouteUnitSpray' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(
            count,
            one: 'स्प्रे',
            other: 'स्प्रे',
          ),
      _ => null,
    };
  }
}
