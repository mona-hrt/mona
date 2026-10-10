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
  String get nav_intakes => 'Bevitelek';
  @override
  String get nav_levels => 'Hormonok';
  @override
  String get nav_supplies => 'Készlet';
  @override
  String get takeAnIntake => 'Bevevés felírása';
  @override
  String get addAnItem => 'Elem hozzáadása';
  @override
  String get empty_home =>
      'Kezdje egy időbeosztás hozzáadásával a Beállításokban';
  @override
  String get allDone => 'Kész!';
  @override
  String get noIntakesDue => 'Nincs mára felírt adag';
  @override
  String get upcoming => 'Közelgő';
  @override
  String get asNeeded => 'Ahogy szükséges';
  @override
  String get taken => 'Bevéve';
  @override
  String get yesterday => 'tegnap';
  @override
  String get tomorrow => 'holnap';
  @override
  String get lastTaken => 'Utolsó bevevés';
  @override
  String get neverTakenYet => 'Nincs bevitel';
  @override
  String get scheduleFrequencyDaily => 'Naponta';
  @override
  String get scheduleFrequencyDailyDescription =>
      'Minden nap, specifikus időben';
  @override
  String get scheduleFrequencyInterval => 'Intervallum';
  @override
  String get scheduleFrequencyIntervalDescription => 'Néhány naponta';
  @override
  String get scheduleFrequencyWeekly => 'Hetente';
  @override
  String get scheduleFrequencyMonthly => 'Havonta';
  @override
  String get scheduleFrequencyMonthlyDescription =>
      'Minden hónap ugyanazon napján';
  @override
  String get scheduleFrequencyAsNeeded => 'Szükség szerint';
  @override
  String get scheduleFrequencyAsNeededDescription => 'Nincs rögzített ütemezés';
  @override
  String get newUpdateAvailable => 'Új frissítés érhető el!';
  @override
  String get settingsTitle => 'Beállítások';
  @override
  String get notifications => 'Értesítések';
  @override
  String get schedulesAndNotifications => 'Ütemezések és értesítések';
  @override
  String get general => 'Általános';
  @override
  String get schedules => 'Ütemezések';
  @override
  String get noSchedules => 'Nincsen ütemezés';
  @override
  String get language => 'Nyelv';
  @override
  String get languageFollowDevice => 'Használja az eszköz nyelvét';
  @override
  String get enableNotifications => 'Érdesítések bekapcsolása';
  @override
  String get enableNotificationsDescription => 'Küldj emlékeztetőket';
  @override
  String get anchorToLastIntake => 'Újraszámítás a legútóbbi bevitel alapján';
  @override
  String get scheduleFrequencyWeeklyDescription => 'A hét egy napján';
  @override
  String get goToSettings => 'Menj a beállításokhoz';
  @override
  String get anchorToLastIntakeDescription =>
      'A következő bevétel utemezése az előző bevétel alapján, egy intervallummal későbbre';
  @override
  String get notificationsDisabledTitle => 'Az értesítések ki vannak kapcsolva';
  @override
  String get clickToOpenSettings => 'Kattintson beállítások megbyitásához';
  @override
  String get exactRemindersDisabled =>
      'A pontos emlékeztetők ki vannak kapcsolva';
  @override
  String get remindersDelayed =>
      'Az emlékeztetők kissé késhetnek. Kattintson beállítások megnyitásahoz.';
  @override
  String get medicalSettings => 'Egészségügyi beállítások';
  @override
  String get theme => 'Téma';
  @override
  String get themeCustomizeColors => 'App színek testreszabása';
  @override
  String get customThemeEnabled => 'Saját téma';
  @override
  String get themeGenerate => 'Frissítés';
  @override
  String importFailed({required Object error}) =>
      'Importálás sikertelen: ${error}';
  @override
  String get updates => 'Frissítések';
  @override
  String get dataManagement => 'Adat Kezelés';
  @override
  String get exportDataTitle => 'Adatok Exportálása';
  @override
  String get exportDataSubtitle => 'Adatok mentése JSON fájlba';
  @override
  String get units => 'Mértékegységek';
  @override
  String get updateNoCompatibleApk =>
      'Nem található ezközöddel kompatibilis frissítés.';
  @override
  String get updateAppUpToDate => 'Az app naprakész!';
  @override
  String get updateCheckNetworkError => 'A frissítések ellenőrzése sikertelen.';
  @override
  String get updateDialogTitle => 'Új frissítés érhető el';
  @override
  String updateDialogBody({required Object latest, required Object current}) =>
      'A(z) ${latest} verzió elérhetőve vált! (Jelenlegi: ${current})\n\nEgy ezközöddel kompartibilis frissítés készen áll a telepítésre.';
  @override
  String get updateDownloadAndInstall => 'Letöltés és Telepítés';
  @override
  String get updateInstallPermissionRequired =>
      'Engedély szükséges a frissítés telepítéséhez.';
  @override
  String get updateDownloadingTitle => 'Frissítés Letöltése...';
  @override
  String updateFailedOpenInstaller({required Object message}) =>
      'A telepítő megnyitása sikertelen volt: ${message}';
  @override
  String get updateDownloadFailed =>
      'Letöltés sikertelen. Kérem ellenőrizze a kapcsolatát.';
  @override
  String get secretSettings => 'Titkos beállítások';
  @override
  String get slimeMode => 'Nyálka mód';
  @override
  String get themeVariant => 'Típús';
  @override
  String get themeContrast => 'Kontraszt';
  @override
  String get themeContrastStandard => 'Átlagos';
  @override
  String get themeContrastMedium => 'Közepes';
  @override
  String get themeContrastHigh => 'Magas';
  @override
  String get autoUpdate => 'Auto-Frissítés';
  @override
  String get autoUpdateDescription =>
      'Frissítes autómatikus ellenőrzése az app megnyitásakor';
  @override
  String get checkForUpdates => 'Frissítések ellenőrzése';
  @override
  String get checkForUpdatesDescription =>
      'Frissítések ellenőrzése manuálisan\nEz csatlakoztat az internethet\n(Adatot nem küld)';
  @override
  String appVersion({required Object version}) => 'Mona verzió: ${version}';
  @override
  String get getInvolved => 'Kapcsolódj be';
  @override
  String get reportBug => 'Hiba jelentése';
  @override
  String get reportBugDescription => 'Probléma nyitása GitHub-on';
  @override
  String get translateApp => 'Segíts fordítani';
  @override
  String get translateAppDescription => 'Segíts Monát lefordítani Weblate-en';
  @override
  String get missingTranslation => 'Hiányzik egy fordítás?';
  @override
  String get donate => 'Adományozz';
  @override
  String get donateDescription => 'Támogast Monát Ko-Fi-n';
  @override
  String get backupSaved => 'Biztonsági mentés sikeres';
  @override
  String exportFailed({required Object error}) =>
      'Sikertelen exportálás: ${error}';
  @override
  String get importDataTitle => 'Adatok Importálása';
  @override
  String get importDataSubtitle => 'Adatok helyreállítása JSON fájlból';
  @override
  String get importDataOverwriteWarning =>
      'Ez felülírja az összes adatod a biztonsági mentéssel. Ez a művelet visszafordíthatatlan. Szeretnéd folytatni?';
  @override
  String get importConfirm => 'Importálás';
  @override
  String get importSuccessfulTitle => 'Importálás Sikeres';
  @override
  String get importRestartRequired =>
      'Kérem indítsa újra az alkalmazást, hogy alkalmazza a helyreálított adatokat.';
  @override
  String get closeApp => 'Alkalmazás Bezárása';
  @override
  String notificationMedicationReminderTitle({required Object scheduleName}) =>
      'Itt az idő a(z) ${scheduleName} bevevésére';
  @override
  String notificationMedicationReminderBodyDate({required Object date}) =>
      '${date}-ra/re időzítve lett';
  @override
  String notificationMedicationReminderBodyTime({required Object time}) =>
      '${time}-ra/re időzítve lett';
  @override
  String notificationMedicationReminderBodyWeekday({required Object weekday}) =>
      '${weekday}-ra/re időzítve lett';
  @override
  String get addSchedule => 'Beosztás hozzádása';
  @override
  String get addScheduleToGetStarted => 'Kezdd egy beosztás hozzáadásával.';
  @override
  String get newSchedule => 'Új beosztás';
  @override
  String get every => 'Minden';
  @override
  String get days => 'napok';
  @override
  String get dayOfMonth => 'Hónap napja';
  @override
  String get months => 'hónapok';
  @override
  String get startDate => 'Kezdő dátum';
  @override
  String get pickATime => 'Válasszon egy időt';
  @override
  String get addIntakeTime => 'Idő hozzáadása';
  @override
  String get editScheduleInfo => 'Beosztás infó szerkeztése';
  @override
  String get scheduling => 'Ütemezés';
  @override
  String get editSchedule => 'Beosztás módosítása';
  @override
  String deleteSchedule({required Object name}) => 'Törli a(z) ${name}-et?';
  @override
  String get addNotification => 'Emlékeztető hozzáadása';
  @override
  String get empty_intakes => 'A bevitelek itt fognak megjelenni';
  @override
  String get HrtCounter => 'Idő hormon terápián';
  @override
  String get HrtCounterDescription =>
      'Mutassa az HRT-n töltött időm es az összes bevitelem';
  @override
  String get hrtWidgetPlaceholder =>
      'Nyist meg a Monát az első beviteled feljegyzéséhez';
  @override
  String get hrtWidgetPreviewSample => 'HRT-n 8 hónapja';
  @override
  String get hrtWidgetPreviewIntakeSample => '16 bevitel felírva';
  @override
  String get startOfDay => 'Nap kezdete';
  @override
  String startOfDayDescription({required Object time}) =>
      '${time} előtt az előző naphoz fog számítani';
  @override
  String get chooseSchedule => 'Válassz beosztást';
  @override
  String get addSchedulesFirst => 'Előbb adj hozzá egy beosztást.';
  @override
  String get editIntake => 'Bevutel módosítása';
  @override
  String get date => 'Dátum';
  @override
  String get amount => 'Mennyiség';
  @override
  String get takenAmount => 'Bevett mennyiség';
  @override
  String get wastedAmount => 'Elpazarolt mennyiség';
  @override
  String get none => 'Semmi';
  @override
  String get supplyItem => 'Készlet elem';
  @override
  String get chooseItem => 'Válassz egy elemet';
  @override
  String get noItemsToAdd => 'Nincs elérhető elem';
  @override
  String get injectionSide => 'Injekció oldal';
  @override
  String get deleteIntake => 'Szeretné törölni ezt a bevutelt?';
  @override
  String takeMedication({required Object scheduleName}) =>
      'Vedd be ${scheduleName}-t';
  @override
  String get takeIntake => 'Bevevés';
  @override
  String get intakeRecorded => 'Bevitel feljegyezve';
  @override
  String get needleDeadSpace => 'Tű holttér';
  @override
  String get notes => 'Megjegyzés';
  @override
  String get injectionType => 'Injekció típusa';
  @override
  String get intramuscular => 'Izomba adott';
  @override
  String get subcutaneous => 'Bőr alatti';
  @override
  String get microliters => 'μL';
  @override
  String get milliliters => 'mL';
  @override
  String get empty_levels =>
      'Elkezdéshez írj be egy vérvételt vagy jegyezz fel egy ösztradiol injekciót';
  @override
  String get bloodTestsTitle => 'Vérvételek';
  @override
  String get estradiolLevelsTitle => 'Ösztradiol szintek';
  @override
  String get week => 'H';
  @override
  String get twoWeeks => '2 H';
  @override
  String get threeMonths => '3 Hó';
  @override
  String get sixMonths => '6 Hó';
  @override
  String get month => 'Hó';
  @override
  String get year => 'É';
  @override
  String get empty_blood_tests =>
      'A vérvételek itt fognak megjelenni. Nyomd meg a hozzáad gombot!';
  @override
  String get addBloodTest => 'Vérvétel feljegyzése';
  @override
  String get editBloodTest => 'Vérvétel módosítása';
  @override
  String get newBloodTest => 'Új vérvétel';
  @override
  String get deleteBloodTest => 'Biztos törli ezt a vérvételt?';
  @override
  String get estradiolLevelLabel => 'Ösztradiol szint';
  @override
  String get testosteroneLevelLabel => 'Tesztoszteron szint';
  @override
  String get bloodTestDateLabel => 'Vérvétel ideje';
  @override
  String chartNowConcentration({required Object value}) => 'Most ${value}';
  @override
  String chartBloodTestLevelTooltip(
          {required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String chartLevelTooltip({required Object date, required Object level}) =>
      '${date}: ${level}';
  @override
  String get empty_supplies => 'Nincs készlet. Kezdd egy elem hozzáadásával.';
  @override
  String get newItem => 'Új elem';
  @override
  String get adminRoute => 'Adminisztrációs út';
  @override
  String get totalAmount => 'Teljes mennyiség';
  @override
  String get concentration => 'Koncentráció';
  @override
  String get editItem => 'Elem szerkesztése';
  @override
  String get usedAmount => 'Elhasznált mennyiség';
  @override
  String deleteItem({required Object name}) => 'Törli ${name}-at/et?';
  @override
  String get allItemsFilter => 'Összes';
  @override
  String get medicationItemsFilter => 'Gyógyszer';
  @override
  String get genericItems => 'Fogyóeszközök';
  @override
  String get medicationItemType => 'Gyógyszer';
  @override
  String get genericItemType => 'Fogyóeszköz';
  @override
  String get supplyType => 'Típus';
  @override
  String get syringe => 'Fecskendők';
  @override
  String get wipe => 'Törlők';
  @override
  String get needle => 'Tűk';
  @override
  String get gloves => 'Kesztyűk';
  @override
  String get bandage => 'Kötszerek';
  @override
  String get add => 'Hozzáad';
  @override
  String get save => 'Mentés';
  @override
  String get cancel => 'Mégse';
  @override
  String get next => 'Következő';
  @override
  String get delete => 'Törlés';
  @override
  String get deleteElement => 'Törli ezt az elemet?';
  @override
  String get irreversibleAction => 'Ezt a műveletet nem lehet visszafordítani.';
  @override
  String get name => 'Név';
  @override
  String get molecule => 'Molekula';
  @override
  String get ester => 'Észter';
  @override
  String get estradiol => 'Ösztradiol';
  @override
  String get progesterone => 'Progeszteron';
  @override
  String get testosterone => 'Tesztoszteron';
  @override
  String get nandrolone => 'Nandrolon';
  @override
  String get dihydrotestosterone => 'Dihidrotesztoszteron';
  @override
  String get spironolactone => 'Spironolakton';
  @override
  String get cyproteroneAcetate => 'Ciproteron-acetát';
  @override
  String get leuprorelinAcetate => 'Leuprorelin-acetát';
  @override
  String get bicalutamide => 'Bicalutamid';
  @override
  String get decapeptyl => 'Decapeptyl';
  @override
  String get raloxifene => 'Raloxifen';
  @override
  String get tamoxifen => 'Tamoxifen';
  @override
  String get finasteride => 'Finaszterid';
  @override
  String get dutasteride => 'Dutaszterid';
  @override
  String get minoxidil => 'Minoxidil';
  @override
  String get pioglitazone => 'Pioglitazon';
  @override
  String get enanthate => 'Enantát';
  @override
  String get valerate => 'Valerát';
  @override
  String get cypionate => 'Cypionát';
  @override
  String get undecylate => 'Undecilát';
  @override
  String get benzoate => 'Benzoát';
  @override
  String get cypionateSuspension => 'Cypionát felfüggesztés';
  @override
  String get medicationEstradiolEnanthate => 'Ösztradiol enantát';
  @override
  String get medicationEstradiolValerate => 'Ösztradiol valerate';
  @override
  String get medicationEstradiolCypionate => 'Ösztradiol cypionate';
  @override
  String get medicationEstradiolUndecylate => 'Ösztradiol undecylate';
  @override
  String get medicationEstradiolBenzoate => 'Ösztradiol benzoát';
  @override
  String get medicationEstradiolCypionateSuspension =>
      'Ösztradiol cypionate felfüggesztése';
  @override
  String get medicationTestosteroneEnanthate => 'Tesztoszteron enantát';
  @override
  String get medicationTestosteroneValerate => 'Tesztoszteron valerát';
  @override
  String get medicationTestosteroneCypionate => 'Tesztoszteron cypionate';
  @override
  String get medicationTestosteroneUndecylate => 'Tesztoszteron undecilát';
  @override
  String get medicationTestosteroneBenzoate => 'Tesztoszteron benzoát';
  @override
  String get medicationTestosteroneCypionateSuspension =>
      'Tesztoszteron cypionát felfüggesztés';
  @override
  String get injection => 'Injekció';
  @override
  String get oral => 'Orális';
  @override
  String get sublingual => 'Nyelv alatti';
  @override
  String get patch => 'Tapasz';
  @override
  String get gel => 'Gél';
  @override
  String get implant => 'Beültetés';
  @override
  String get suppository => 'Kúp';
  @override
  String get transdermalSpray => 'Bőrön keresztüli spray';
  @override
  String get transdermalDrops => 'Bőrön keresztüli csepp';
  @override
  String get deliveryForm => 'Forma';
  @override
  String get deliveryFormPump => 'Nyomás';
  @override
  String get deliveryFormSachet => 'Tasak';
  @override
  String get deliveryFormGram => 'Cső';
  @override
  String get unitMilligram => 'mg';
  @override
  String get unitMicrogramPerDay => 'µg/nap';
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
  String get injectionSideLeft => 'Bal';
  @override
  String get injectionSideRight => 'Jobb';
  @override
  String get placementLeft => 'Bal oldal';
  @override
  String get placementRight => 'Jobb oldal';
  @override
  String get placementLeftThigh => 'Bal comb';
  @override
  String get placementRightThigh => 'Jobb comb';
  @override
  String get placementLeftArm => 'Bal kéz';
  @override
  String get placementRightArm => 'Jobb kéz';
  @override
  String get placementLeftButtock => 'Bal fenék';
  @override
  String get placementRightButtock => 'Jobb fenék';
  @override
  String get placementLeftAbdomen => 'Has bal oldala';
  @override
  String get placementRightAbdomen => 'Has jobb oldala';
  @override
  String get applicationSites => 'Beviteli oldalak';
  @override
  String get applicationSitesDescription =>
      'Kezelje a beviteli oldalakat amelyek között váltogatsz';
  @override
  String get applicationSitesInstructions =>
      'Kezelje a beviteli oldalakat amelyek között váltogatsz. Az oldalak a beviteli előzmenyeid alapján ajánlottak. Nyomd hosszan a rendezéshez.';
  @override
  String get addApplicationSite => 'Oldal hozzáadása';
  @override
  String get customSiteLabel => 'Egyedi oldal név';
  @override
  String get noApplicationSitesYet => 'Még nincsenek oldalak';
  @override
  String get addSiteToGetStarted => 'Kezdéshez adjon hozzá egy oldalt.';
  @override
  String get placementSuggestionPerScheduleTitle => 'Ajánljon beosztásonként';
  @override
  String get placementSuggestionPerScheduleDescription =>
      'Csak ezen a beosztás előzményei alapján ajánljon oldalt.';
  @override
  String get requiredField => 'Kötelező mező';
  @override
  String get mustBePositiveNumber => 'Kérem pozítív számot adj meg';
  @override
  String get mustBeBetween1And28 => '1 és 28 között kell lennie';
  @override
  String mustBeAtMost({required Object max}) => 'Maximum ${max} lehet';
  @override
  String get invalidTotalAmount => 'Érvénytelen mennyiség';
  @override
  String get cannotExceedTotalCapacity => 'Nem lépheti túl a kapacítást';
  @override
  String dosePerUnitLabel({required Object unit}) => 'Dózis per ${unit}';
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
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'Minden nap',
        other: '${count} naponta',
      );
  @override
  String scheduleFrequencyOnDayEveryNMonths(
          {required num count, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'Minden hónap ${day}.-je',
        other: '${day}.-án/én, minden ${count}. -dik hónapban',
      );
  @override
  String schedulesCreated({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '${count} létrehozva',
        other: '${count} létrehozva',
      );
  @override
  String onHrtForDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'HRT-n 1 napja',
        other: 'HRT-n ${count} napja',
      );
  @override
  String onHrtForWeeks({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'HRT-n 1 hete',
        other: 'HRT-n ${count} hete',
      );
  @override
  String onHrtForMonths({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'HRT-n 1 hónapja',
        other: 'HRT-n ${count} hónapja',
      );
  @override
  String onHrtForYears({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'HRT-n 1 éve',
        other: 'HRT-n ${count} éve',
      );
  @override
  String intakesLoggedCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '1 bevitel felírva',
        other: '${count} bevitel felírva',
      );
  @override
  String remaining({required num count, required Object unit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '${count} ${unit} maradt',
        other: '${count} ${unit} maradt',
      );
  @override
  String syringeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '1 fecskendő maradt',
        other: '${count} fecsendő maradt',
      );
  @override
  String wipeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '1 törlő maradt',
        other: '${count} törlő maradt',
      );
  @override
  String needleRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '1 tű maradt',
        other: '${count} tű maradt',
      );
  @override
  String glovesRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '1 kesztyű maradt',
        other: '${count} kesztyű maradt',
      );
  @override
  String bandageRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: '1 kötszer maradt',
        other: '${count} kötszer maradt',
      );
  @override
  String administrationRouteUnitMl({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'ml',
        other: 'ml',
      );
  @override
  String administrationRouteUnitPill({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'pirula',
        other: 'pirula',
      );
  @override
  String administrationRouteUnitPatch({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'tapasz',
        other: 'tapasz',
      );
  @override
  String administrationRouteUnitPump({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'nyomás',
        other: 'nyomás',
      );
  @override
  String administrationRouteUnitSachet({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'tasak',
        other: 'tasak',
      );
  @override
  String administrationRouteUnitGram({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'gramm',
        other: 'gramm',
      );
  @override
  String administrationRouteUnitImplant({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'beültetés',
        other: 'beültetés',
      );
  @override
  String administrationRouteUnitSuppository({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'kúp',
        other: 'kúp',
      );
  @override
  String administrationRouteUnitSpray({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
        count,
        one: 'spray',
        other: 'spray',
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
      'nav_intakes' => 'Bevitelek',
      'nav_levels' => 'Hormonok',
      'nav_supplies' => 'Készlet',
      'takeAnIntake' => 'Bevevés felírása',
      'addAnItem' => 'Elem hozzáadása',
      'empty_home' => 'Kezdje egy időbeosztás hozzáadásával a Beállításokban',
      'allDone' => 'Kész!',
      'noIntakesDue' => 'Nincs mára felírt adag',
      'upcoming' => 'Közelgő',
      'asNeeded' => 'Ahogy szükséges',
      'taken' => 'Bevéve',
      'yesterday' => 'tegnap',
      'tomorrow' => 'holnap',
      'lastTaken' => 'Utolsó bevevés',
      'neverTakenYet' => 'Nincs bevitel',
      'scheduleFrequencyDaily' => 'Naponta',
      'scheduleFrequencyDailyDescription' => 'Minden nap, specifikus időben',
      'scheduleFrequencyInterval' => 'Intervallum',
      'scheduleFrequencyIntervalDescription' => 'Néhány naponta',
      'scheduleFrequencyWeekly' => 'Hetente',
      'scheduleFrequencyMonthly' => 'Havonta',
      'scheduleFrequencyMonthlyDescription' => 'Minden hónap ugyanazon napján',
      'scheduleFrequencyAsNeeded' => 'Szükség szerint',
      'scheduleFrequencyAsNeededDescription' => 'Nincs rögzített ütemezés',
      'newUpdateAvailable' => 'Új frissítés érhető el!',
      'settingsTitle' => 'Beállítások',
      'notifications' => 'Értesítések',
      'schedulesAndNotifications' => 'Ütemezések és értesítések',
      'general' => 'Általános',
      'schedules' => 'Ütemezések',
      'noSchedules' => 'Nincsen ütemezés',
      'language' => 'Nyelv',
      'languageFollowDevice' => 'Használja az eszköz nyelvét',
      'enableNotifications' => 'Érdesítések bekapcsolása',
      'enableNotificationsDescription' => 'Küldj emlékeztetőket',
      'anchorToLastIntake' => 'Újraszámítás a legútóbbi bevitel alapján',
      'scheduleFrequencyWeeklyDescription' => 'A hét egy napján',
      'goToSettings' => 'Menj a beállításokhoz',
      'anchorToLastIntakeDescription' =>
        'A következő bevétel utemezése az előző bevétel alapján, egy intervallummal későbbre',
      'notificationsDisabledTitle' => 'Az értesítések ki vannak kapcsolva',
      'clickToOpenSettings' => 'Kattintson beállítások megbyitásához',
      'exactRemindersDisabled' => 'A pontos emlékeztetők ki vannak kapcsolva',
      'remindersDelayed' =>
        'Az emlékeztetők kissé késhetnek. Kattintson beállítások megnyitásahoz.',
      'medicalSettings' => 'Egészségügyi beállítások',
      'theme' => 'Téma',
      'themeCustomizeColors' => 'App színek testreszabása',
      'customThemeEnabled' => 'Saját téma',
      'themeGenerate' => 'Frissítés',
      'importFailed' => ({required Object error}) =>
          'Importálás sikertelen: ${error}',
      'updates' => 'Frissítések',
      'dataManagement' => 'Adat Kezelés',
      'exportDataTitle' => 'Adatok Exportálása',
      'exportDataSubtitle' => 'Adatok mentése JSON fájlba',
      'units' => 'Mértékegységek',
      'updateNoCompatibleApk' =>
        'Nem található ezközöddel kompatibilis frissítés.',
      'updateAppUpToDate' => 'Az app naprakész!',
      'updateCheckNetworkError' => 'A frissítések ellenőrzése sikertelen.',
      'updateDialogTitle' => 'Új frissítés érhető el',
      'updateDialogBody' => (
              {required Object latest, required Object current}) =>
          'A(z) ${latest} verzió elérhetőve vált! (Jelenlegi: ${current})\n\nEgy ezközöddel kompartibilis frissítés készen áll a telepítésre.',
      'updateDownloadAndInstall' => 'Letöltés és Telepítés',
      'updateInstallPermissionRequired' =>
        'Engedély szükséges a frissítés telepítéséhez.',
      'updateDownloadingTitle' => 'Frissítés Letöltése...',
      'updateFailedOpenInstaller' => ({required Object message}) =>
          'A telepítő megnyitása sikertelen volt: ${message}',
      'updateDownloadFailed' =>
        'Letöltés sikertelen. Kérem ellenőrizze a kapcsolatát.',
      'secretSettings' => 'Titkos beállítások',
      'slimeMode' => 'Nyálka mód',
      'themeVariant' => 'Típús',
      'themeContrast' => 'Kontraszt',
      'themeContrastStandard' => 'Átlagos',
      'themeContrastMedium' => 'Közepes',
      'themeContrastHigh' => 'Magas',
      'autoUpdate' => 'Auto-Frissítés',
      'autoUpdateDescription' =>
        'Frissítes autómatikus ellenőrzése az app megnyitásakor',
      'checkForUpdates' => 'Frissítések ellenőrzése',
      'checkForUpdatesDescription' =>
        'Frissítések ellenőrzése manuálisan\nEz csatlakoztat az internethet\n(Adatot nem küld)',
      'appVersion' => ({required Object version}) => 'Mona verzió: ${version}',
      'getInvolved' => 'Kapcsolódj be',
      'reportBug' => 'Hiba jelentése',
      'reportBugDescription' => 'Probléma nyitása GitHub-on',
      'translateApp' => 'Segíts fordítani',
      'translateAppDescription' => 'Segíts Monát lefordítani Weblate-en',
      'missingTranslation' => 'Hiányzik egy fordítás?',
      'donate' => 'Adományozz',
      'donateDescription' => 'Támogast Monát Ko-Fi-n',
      'backupSaved' => 'Biztonsági mentés sikeres',
      'exportFailed' => ({required Object error}) =>
          'Sikertelen exportálás: ${error}',
      'importDataTitle' => 'Adatok Importálása',
      'importDataSubtitle' => 'Adatok helyreállítása JSON fájlból',
      'importDataOverwriteWarning' =>
        'Ez felülírja az összes adatod a biztonsági mentéssel. Ez a művelet visszafordíthatatlan. Szeretnéd folytatni?',
      'importConfirm' => 'Importálás',
      'importSuccessfulTitle' => 'Importálás Sikeres',
      'importRestartRequired' =>
        'Kérem indítsa újra az alkalmazást, hogy alkalmazza a helyreálított adatokat.',
      'closeApp' => 'Alkalmazás Bezárása',
      'notificationMedicationReminderTitle' => (
              {required Object scheduleName}) =>
          'Itt az idő a(z) ${scheduleName} bevevésére',
      'notificationMedicationReminderBodyDate' => ({required Object date}) =>
          '${date}-ra/re időzítve lett',
      'notificationMedicationReminderBodyTime' => ({required Object time}) =>
          '${time}-ra/re időzítve lett',
      'notificationMedicationReminderBodyWeekday' =>
        ({required Object weekday}) => '${weekday}-ra/re időzítve lett',
      'addSchedule' => 'Beosztás hozzádása',
      'addScheduleToGetStarted' => 'Kezdd egy beosztás hozzáadásával.',
      'newSchedule' => 'Új beosztás',
      'every' => 'Minden',
      'days' => 'napok',
      'dayOfMonth' => 'Hónap napja',
      'months' => 'hónapok',
      'startDate' => 'Kezdő dátum',
      'pickATime' => 'Válasszon egy időt',
      'addIntakeTime' => 'Idő hozzáadása',
      'editScheduleInfo' => 'Beosztás infó szerkeztése',
      'scheduling' => 'Ütemezés',
      'editSchedule' => 'Beosztás módosítása',
      'deleteSchedule' => ({required Object name}) => 'Törli a(z) ${name}-et?',
      'addNotification' => 'Emlékeztető hozzáadása',
      'empty_intakes' => 'A bevitelek itt fognak megjelenni',
      'HrtCounter' => 'Idő hormon terápián',
      'HrtCounterDescription' =>
        'Mutassa az HRT-n töltött időm es az összes bevitelem',
      'hrtWidgetPlaceholder' =>
        'Nyist meg a Monát az első beviteled feljegyzéséhez',
      'hrtWidgetPreviewSample' => 'HRT-n 8 hónapja',
      'hrtWidgetPreviewIntakeSample' => '16 bevitel felírva',
      'startOfDay' => 'Nap kezdete',
      'startOfDayDescription' => ({required Object time}) =>
          '${time} előtt az előző naphoz fog számítani',
      'chooseSchedule' => 'Válassz beosztást',
      'addSchedulesFirst' => 'Előbb adj hozzá egy beosztást.',
      'editIntake' => 'Bevutel módosítása',
      'date' => 'Dátum',
      'amount' => 'Mennyiség',
      'takenAmount' => 'Bevett mennyiség',
      'wastedAmount' => 'Elpazarolt mennyiség',
      'none' => 'Semmi',
      'supplyItem' => 'Készlet elem',
      'chooseItem' => 'Válassz egy elemet',
      'noItemsToAdd' => 'Nincs elérhető elem',
      'injectionSide' => 'Injekció oldal',
      'deleteIntake' => 'Szeretné törölni ezt a bevutelt?',
      'takeMedication' => ({required Object scheduleName}) =>
          'Vedd be ${scheduleName}-t',
      'takeIntake' => 'Bevevés',
      'intakeRecorded' => 'Bevitel feljegyezve',
      'needleDeadSpace' => 'Tű holttér',
      'notes' => 'Megjegyzés',
      'injectionType' => 'Injekció típusa',
      'intramuscular' => 'Izomba adott',
      'subcutaneous' => 'Bőr alatti',
      'microliters' => 'μL',
      'milliliters' => 'mL',
      'empty_levels' =>
        'Elkezdéshez írj be egy vérvételt vagy jegyezz fel egy ösztradiol injekciót',
      'bloodTestsTitle' => 'Vérvételek',
      'estradiolLevelsTitle' => 'Ösztradiol szintek',
      'week' => 'H',
      'twoWeeks' => '2 H',
      'threeMonths' => '3 Hó',
      'sixMonths' => '6 Hó',
      'month' => 'Hó',
      'year' => 'É',
      'empty_blood_tests' =>
        'A vérvételek itt fognak megjelenni. Nyomd meg a hozzáad gombot!',
      'addBloodTest' => 'Vérvétel feljegyzése',
      'editBloodTest' => 'Vérvétel módosítása',
      'newBloodTest' => 'Új vérvétel',
      'deleteBloodTest' => 'Biztos törli ezt a vérvételt?',
      'estradiolLevelLabel' => 'Ösztradiol szint',
      'testosteroneLevelLabel' => 'Tesztoszteron szint',
      'bloodTestDateLabel' => 'Vérvétel ideje',
      'chartNowConcentration' => ({required Object value}) => 'Most ${value}',
      'chartBloodTestLevelTooltip' =>
        ({required Object date, required Object level}) => '${date}: ${level}',
      'chartLevelTooltip' => ({required Object date, required Object level}) =>
          '${date}: ${level}',
      'empty_supplies' => 'Nincs készlet. Kezdd egy elem hozzáadásával.',
      'newItem' => 'Új elem',
      'adminRoute' => 'Adminisztrációs út',
      'totalAmount' => 'Teljes mennyiség',
      'concentration' => 'Koncentráció',
      'editItem' => 'Elem szerkesztése',
      'usedAmount' => 'Elhasznált mennyiség',
      'deleteItem' => ({required Object name}) => 'Törli ${name}-at/et?',
      'allItemsFilter' => 'Összes',
      'medicationItemsFilter' => 'Gyógyszer',
      'genericItems' => 'Fogyóeszközök',
      'medicationItemType' => 'Gyógyszer',
      'genericItemType' => 'Fogyóeszköz',
      'supplyType' => 'Típus',
      'syringe' => 'Fecskendők',
      'wipe' => 'Törlők',
      'needle' => 'Tűk',
      'gloves' => 'Kesztyűk',
      'bandage' => 'Kötszerek',
      'add' => 'Hozzáad',
      'save' => 'Mentés',
      'cancel' => 'Mégse',
      'next' => 'Következő',
      'delete' => 'Törlés',
      'deleteElement' => 'Törli ezt az elemet?',
      'irreversibleAction' => 'Ezt a műveletet nem lehet visszafordítani.',
      'name' => 'Név',
      'molecule' => 'Molekula',
      'ester' => 'Észter',
      'estradiol' => 'Ösztradiol',
      'progesterone' => 'Progeszteron',
      'testosterone' => 'Tesztoszteron',
      'nandrolone' => 'Nandrolon',
      'dihydrotestosterone' => 'Dihidrotesztoszteron',
      'spironolactone' => 'Spironolakton',
      'cyproteroneAcetate' => 'Ciproteron-acetát',
      'leuprorelinAcetate' => 'Leuprorelin-acetát',
      'bicalutamide' => 'Bicalutamid',
      'decapeptyl' => 'Decapeptyl',
      'raloxifene' => 'Raloxifen',
      'tamoxifen' => 'Tamoxifen',
      'finasteride' => 'Finaszterid',
      'dutasteride' => 'Dutaszterid',
      'minoxidil' => 'Minoxidil',
      'pioglitazone' => 'Pioglitazon',
      'enanthate' => 'Enantát',
      'valerate' => 'Valerát',
      'cypionate' => 'Cypionát',
      'undecylate' => 'Undecilát',
      'benzoate' => 'Benzoát',
      'cypionateSuspension' => 'Cypionát felfüggesztés',
      'medicationEstradiolEnanthate' => 'Ösztradiol enantát',
      'medicationEstradiolValerate' => 'Ösztradiol valerate',
      'medicationEstradiolCypionate' => 'Ösztradiol cypionate',
      'medicationEstradiolUndecylate' => 'Ösztradiol undecylate',
      'medicationEstradiolBenzoate' => 'Ösztradiol benzoát',
      'medicationEstradiolCypionateSuspension' =>
        'Ösztradiol cypionate felfüggesztése',
      'medicationTestosteroneEnanthate' => 'Tesztoszteron enantát',
      'medicationTestosteroneValerate' => 'Tesztoszteron valerát',
      'medicationTestosteroneCypionate' => 'Tesztoszteron cypionate',
      'medicationTestosteroneUndecylate' => 'Tesztoszteron undecilát',
      'medicationTestosteroneBenzoate' => 'Tesztoszteron benzoát',
      'medicationTestosteroneCypionateSuspension' =>
        'Tesztoszteron cypionát felfüggesztés',
      'injection' => 'Injekció',
      'oral' => 'Orális',
      'sublingual' => 'Nyelv alatti',
      'patch' => 'Tapasz',
      'gel' => 'Gél',
      'implant' => 'Beültetés',
      'suppository' => 'Kúp',
      'transdermalSpray' => 'Bőrön keresztüli spray',
      'transdermalDrops' => 'Bőrön keresztüli csepp',
      'deliveryForm' => 'Forma',
      'deliveryFormPump' => 'Nyomás',
      'deliveryFormSachet' => 'Tasak',
      'deliveryFormGram' => 'Cső',
      'unitMilligram' => 'mg',
      'unitMicrogramPerDay' => 'µg/nap',
      'unitPgPerMl' => 'pg/mL',
      'unitPmolPerL' => 'pmol/L',
      'unitNgPerDl' => 'ng/dL',
      'unitNmolPerL' => 'nmol/L',
      'unitNgPerMl' => 'ng/mL',
      'injectionSideLeft' => 'Bal',
      'injectionSideRight' => 'Jobb',
      'placementLeft' => 'Bal oldal',
      'placementRight' => 'Jobb oldal',
      'placementLeftThigh' => 'Bal comb',
      'placementRightThigh' => 'Jobb comb',
      'placementLeftArm' => 'Bal kéz',
      'placementRightArm' => 'Jobb kéz',
      'placementLeftButtock' => 'Bal fenék',
      'placementRightButtock' => 'Jobb fenék',
      'placementLeftAbdomen' => 'Has bal oldala',
      'placementRightAbdomen' => 'Has jobb oldala',
      'applicationSites' => 'Beviteli oldalak',
      'applicationSitesDescription' =>
        'Kezelje a beviteli oldalakat amelyek között váltogatsz',
      'applicationSitesInstructions' =>
        'Kezelje a beviteli oldalakat amelyek között váltogatsz. Az oldalak a beviteli előzmenyeid alapján ajánlottak. Nyomd hosszan a rendezéshez.',
      'addApplicationSite' => 'Oldal hozzáadása',
      'customSiteLabel' => 'Egyedi oldal név',
      'noApplicationSitesYet' => 'Még nincsenek oldalak',
      'addSiteToGetStarted' => 'Kezdéshez adjon hozzá egy oldalt.',
      'placementSuggestionPerScheduleTitle' => 'Ajánljon beosztásonként',
      'placementSuggestionPerScheduleDescription' =>
        'Csak ezen a beosztás előzményei alapján ajánljon oldalt.',
      'requiredField' => 'Kötelező mező',
      'mustBePositiveNumber' => 'Kérem pozítív számot adj meg',
      'mustBeBetween1And28' => '1 és 28 között kell lennie',
      'mustBeAtMost' => ({required Object max}) => 'Maximum ${max} lehet',
      'invalidTotalAmount' => 'Érvénytelen mennyiség',
      'cannotExceedTotalCapacity' => 'Nem lépheti túl a kapacítást',
      'dosePerUnitLabel' => ({required Object unit}) => 'Dózis per ${unit}',
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
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'Minden nap',
            other: '${count} naponta',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'Minden hónap ${day}.-je',
            other: '${day}.-án/én, minden ${count}. -dik hónapban',
          ),
      'schedulesCreated' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '${count} létrehozva',
            other: '${count} létrehozva',
          ),
      'onHrtForDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'HRT-n 1 napja',
            other: 'HRT-n ${count} napja',
          ),
      'onHrtForWeeks' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'HRT-n 1 hete',
            other: 'HRT-n ${count} hete',
          ),
      'onHrtForMonths' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'HRT-n 1 hónapja',
            other: 'HRT-n ${count} hónapja',
          ),
      'onHrtForYears' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'HRT-n 1 éve',
            other: 'HRT-n ${count} éve',
          ),
      'intakesLoggedCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '1 bevitel felírva',
            other: '${count} bevitel felírva',
          ),
      'remaining' => ({required num count, required Object unit}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '${count} ${unit} maradt',
            other: '${count} ${unit} maradt',
          ),
      'syringeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '1 fecskendő maradt',
            other: '${count} fecsendő maradt',
          ),
      'wipeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '1 törlő maradt',
            other: '${count} törlő maradt',
          ),
      'needleRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '1 tű maradt',
            other: '${count} tű maradt',
          ),
      'glovesRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '1 kesztyű maradt',
            other: '${count} kesztyű maradt',
          ),
      'bandageRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: '1 kötszer maradt',
            other: '${count} kötszer maradt',
          ),
      'administrationRouteUnitMl' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'ml',
            other: 'ml',
          ),
      'administrationRouteUnitPill' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'pirula',
            other: 'pirula',
          ),
      'administrationRouteUnitPatch' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'tapasz',
            other: 'tapasz',
          ),
      'administrationRouteUnitPump' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'nyomás',
            other: 'nyomás',
          ),
      'administrationRouteUnitSachet' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'tasak',
            other: 'tasak',
          ),
      'administrationRouteUnitGram' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'gramm',
            other: 'gramm',
          ),
      'administrationRouteUnitImplant' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'beültetés',
            other: 'beültetés',
          ),
      'administrationRouteUnitSuppository' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'kúp',
            other: 'kúp',
          ),
      'administrationRouteUnitSpray' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(
            count,
            one: 'spray',
            other: 'spray',
          ),
      _ => null,
    };
  }
}
