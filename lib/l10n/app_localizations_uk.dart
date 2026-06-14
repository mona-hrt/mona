// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Mona';

  @override
  String get nav_home => 'Mona';

  @override
  String get nav_intakes => 'Прийоми';

  @override
  String get nav_levels => 'Рівні';

  @override
  String get nav_supplies => 'Препарати';

  @override
  String get takeAnIntake => 'Прийняти препарат';

  @override
  String get addAnItem => 'Додати елемент';

  @override
  String get empty_home => 'Почніть з додавання розкладу в Налаштуваннях';

  @override
  String get allDone => 'Все прийнято!';

  @override
  String get noIntakesDue => 'На сьогодні все прийнято';

  @override
  String get upcoming => 'Найближче';

  @override
  String get taken => 'Прийнято';

  @override
  String daysAgoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count днів тому',
      few: '$count дні тому',
      one: 'вчора',
    );
    return '$_temp0';
  }

  @override
  String inDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'через $count днів',
      many: 'через $count днів',
      few: 'через $count дні',
      one: 'завтра',
    );
    return '$_temp0';
  }

  @override
  String get lastTaken => 'Востаннє прийнято';

  @override
  String get neverTakenYet => 'Ще не приймалось';

  @override
  String get scheduleFrequencyDaily => 'Щодня';

  @override
  String scheduleFrequencyEveryNDays(num days) {
    return 'Кожні $days днів';
  }

  @override
  String get scheduleFrequencyInterval => 'Інтервал';

  @override
  String get scheduleFrequencyWeekly => 'Weekly';

  @override
  String get newUpdateAvailable => 'Нове оновлення!';

  @override
  String get goToSettings => 'Перейти в Налаштування';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get notifications => 'Сповіщення';

  @override
  String get schedulesAndNotifications => 'Розклади та Сповіщення';

  @override
  String get general => 'Загальне';

  @override
  String get schedules => 'Розклад';

  @override
  String get noSchedules => 'Розкладів немає';

  @override
  String schedulesCreated(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Створено $count розкладів',
      few: 'Створено $count розклади',
      one: 'Створено $count розклад',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Мова';

  @override
  String get languageFollowDevice => 'Мова пристрою';

  @override
  String get selectLanguage => 'Вибрати мову';

  @override
  String get enableNotifications => 'Увімкнути сповіщення';

  @override
  String get enableNotificationsDescription => 'Надсилати нагадування';

  @override
  String get notificationsDisabledTitle => 'Сповіщення вимкнено';

  @override
  String get clickToOpenSettings => 'Натисніть для відкриття налаштувань';

  @override
  String get exactRemindersDisabled => 'Точний час нагадувань вимкнено';

  @override
  String get remindersDelayed =>
      'Нагадування можуть злегка затримуватись. Натисніть щоб відкрити сповіщення.';

  @override
  String get autoUpdate => 'Само-Оновлення';

  @override
  String get autoUpdateDescription =>
      'Самочинно перевіряти на оновлення коли застосунок запущено';

  @override
  String get checkForUpdates => 'Перевірити на оновлення';

  @override
  String get checkForUpdatesDescription =>
      'Перевірити на наявність крайньої версії вручну\nЦе підключить вас до мережі\n(Жодних даних не буде надіслано)';

  @override
  String appVersion(Object version) {
    return 'Версія Mona - $version';
  }

  @override
  String backupSavedTo(Object path) {
    return 'Бекап збережено до: $path';
  }

  @override
  String exportFailed(Object error) {
    return 'Не вдалося експортувати: $error';
  }

  @override
  String get importDataTitle => 'Імпортувати дані';

  @override
  String get importDataSubtitle => 'Відновити дані з JSON бекапу';

  @override
  String get importDataOverwriteWarning =>
      'Бекап перепише усі ваші поточні дані. Цю дію неможливо скасувати. Продовжити?';

  @override
  String get importConfirm => 'Імпорт';

  @override
  String get importSuccessfulTitle => 'Успішно імпортовано';

  @override
  String get importRestartRequired =>
      'Будь ласка, перезапустіть застосунок для застосування відновлених даних.';

  @override
  String get closeApp => 'Закрити Застосунок';

  @override
  String importFailed(Object error) {
    return 'Невдача: $error';
  }

  @override
  String get updates => 'Оновлення';

  @override
  String get dataManagement => 'Керування даними';

  @override
  String get exportDataTitle => 'Експортувати дані';

  @override
  String get exportDataSubtitle => 'Зберегти дані в JSON файл';

  @override
  String get units => 'Одиниці виміру';

  @override
  String get updateNoCompatibleApk =>
      'Сумісних оновлень для вашого пристрою не знайдено.';

  @override
  String get updateAppUpToDate => 'Ваш застосунок останньої версії!';

  @override
  String get updateCheckNetworkError => 'Невдалося перевірити на оновлення.';

  @override
  String get updateDialogTitle => 'Доступне оновлення!';

  @override
  String updateDialogBody(Object current, Object latest) {
    return 'Версія $latest доступна! (Поточна: $current)\n\nОновлення, сумісне з вашим пристроєм, готове до завантаження!.';
  }

  @override
  String get updateDownloadAndInstall => 'Завантажити та встановити';

  @override
  String get updateInstallPermissionRequired =>
      'Надайте дозвіл для встановлення оновлення.';

  @override
  String get updateDownloadingTitle => 'Встановлюємо оновлення...';

  @override
  String updateFailedOpenInstaller(Object message) {
    return 'Невдалося відкрити встановлювач: $message';
  }

  @override
  String get updateDownloadFailed =>
      'Завантаження невдалося. Будь ласка, перевірте вашу мережу..';

  @override
  String notificationMedicationReminderTitle(Object scheduleName) {
    return 'Час прийняти $scheduleName';
  }

  @override
  String notificationMedicationReminderBodyDate(Object date) {
    return 'Заплановано на $date';
  }

  @override
  String notificationMedicationReminderBodyTime(Object time) {
    return 'Заплановано на $time';
  }

  @override
  String notificationMedicationReminderBodyWeekday(Object weekday) {
    return 'Заплановано на $weekday';
  }

  @override
  String get addSchedule => 'Додати розклад';

  @override
  String get addScheduleToGetStarted => 'Додайте розклад щоб почати.';

  @override
  String get newSchedule => 'Новий розклад';

  @override
  String get every => 'Кожні';

  @override
  String get days => 'дні';

  @override
  String get startDate => 'Дата початку';

  @override
  String get pickATime => 'Вибрати час';

  @override
  String get addIntakeTime => 'Додати час';

  @override
  String get editScheduleInfo => 'Виправити інформацію';

  @override
  String get scheduling => 'Планування';

  @override
  String get noNotifications => 'Сповіщення відсутні';

  @override
  String notificationsCount(num count) {
    return '$count сповіщень';
  }

  @override
  String get editSchedule => 'Змінити розклад';

  @override
  String deleteSchedule(Object name) {
    return 'Видалити $name?';
  }

  @override
  String get scheduleNotifications => 'Сповіщення розкладу';

  @override
  String get addNotification => 'Додати сповіщення';

  @override
  String noNotificationsForSchedule(Object scheduleName) {
    return 'Сповіщення для $scheduleName відсутні. Натисніть Додати.';
  }

  @override
  String get notificationsUpdated => 'Оновлено сповіщення!';

  @override
  String get notificationsUpdatedDescription =>
      'Кожний розклад тепер має свої сповіщення.\n\nБажано увімкнути сповіщення для ваших розкладів щоб нічого не пропустити.';

  @override
  String get dontShowAgain => 'Більше не показувати';

  @override
  String get scheduleSettings => 'Налаштування розкладу';

  @override
  String get empty_intakes => 'Прийняті дози відображатимуться тут';

  @override
  String get chooseSchedule => 'Вибрати розклад';

  @override
  String get addSchedulesFirst => 'Спочатку додайте розклади.';

  @override
  String get editIntake => 'Редагування прийому';

  @override
  String get date => 'Дата';

  @override
  String get amount => 'Кількість';

  @override
  String get none => 'Відсутнє';

  @override
  String get supplyItem => 'Препарат';

  @override
  String get injectionSide => 'Сторона';

  @override
  String get deleteIntake => 'Видалити прийом?';

  @override
  String takeMedication(Object scheduleName) {
    return 'Прийняти $scheduleName';
  }

  @override
  String get takeIntake => 'Прийняти препарат';

  @override
  String get needleDeadSpace => 'Мертва зона голки';

  @override
  String get notes => 'Примітки';

  @override
  String get microliters => 'μL';

  @override
  String get empty_levels => 'Ін\'єкції відображатимуться тут';

  @override
  String get bloodTestsTitle => 'Аналізи крові';

  @override
  String get empty_blood_tests =>
      'Висновки з аналізів крові з\'являтимуться тут. Натисніть Додати!';

  @override
  String get addBloodTest => 'Додати аналіз крові';

  @override
  String get editBloodTest => 'Редагувати аналіз крові';

  @override
  String get newBloodTest => 'Новий аналіз крові';

  @override
  String get deleteBloodTest => 'Видалити аналіз?';

  @override
  String get estradiolLevelLabel => 'Рівень Естрадіолу';

  @override
  String get testosteroneLevelLabel => 'Рівень Тестостерону';

  @override
  String get bloodTestDateLabel => 'Дата аналізу';

  @override
  String chartNowConcentration(Object value) {
    return 'Поточна $value';
  }

  @override
  String chartBloodTestLevelTooltip(Object date, Object level) {
    return '$date: $level';
  }

  @override
  String get empty_supplies => 'Додайте препарат, щоб почати.';

  @override
  String get newItem => 'Новий препарат';

  @override
  String get adminRoute => 'Шлях введення';

  @override
  String get totalAmount => 'Загальна кількість';

  @override
  String get concentration => 'Насиченість';

  @override
  String get editItem => 'Змінити';

  @override
  String get usedAmount => 'Використано';

  @override
  String deleteItem(Object name) {
    return 'Видалити $name?';
  }

  @override
  String remaining(num amount, Object unit) {
    return '$amount $unit залишилось';
  }

  @override
  String get allItemsFilter => 'All';

  @override
  String get medicationItemsFilter => 'Medication';

  @override
  String get genericItemsFilter => 'Consumables';

  @override
  String get medicationItemType => 'Medication';

  @override
  String get genericItemType => 'Consumable';

  @override
  String get supplyType => 'Type';

  @override
  String get syringe => 'Шприци';

  @override
  String get wipe => 'Серветки';

  @override
  String get needle => 'Голки';

  @override
  String get gloves => 'Рукавички';

  @override
  String get bandage => 'Пластирі';

  @override
  String syringeRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count шприців залишилось',
      one: '1 шприц залишилось',
      few: '$count шприца залишилось',
    );
    return '$_temp0';
  }

  @override
  String wipeRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count серветок залишилось',
      one: '1 серветка залишилось',
      few: '$count серветки залишилось',
    );
    return '$_temp0';
  }

  @override
  String needleRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count голок залишилось',
      one: '1 голка залишилось',
      few: '$count голки залишилось',
    );
    return '$_temp0';
  }

  @override
  String glovesRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count рукавичок залишилось',
      one: '1 рукавичка залишилось',
      few: '$count рукавички залишилось',
    );
    return '$_temp0';
  }

  @override
  String bandageRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пластирів залишилось',
      one: '1 пластир залишилось',
      few: '$count пластирі залишилось',
    );
    return '$_temp0';
  }

  @override
  String get add => 'Додати';

  @override
  String get save => 'Зберегти';

  @override
  String get cancel => 'Скасувати';

  @override
  String get next => 'Далі';

  @override
  String get delete => 'Видалити';

  @override
  String get deleteElement => 'Видалити цей елемент?';

  @override
  String get irreversibleAction => 'Цю дію неможливо скасувати.';

  @override
  String get name => 'Назва';

  @override
  String get molecule => 'Молекула';

  @override
  String get ester => 'Естер';

  @override
  String get estradiol => 'Естрадіол';

  @override
  String get progesterone => 'Прогестерон';

  @override
  String get testosterone => 'Тестостерон';

  @override
  String get nandrolone => 'Нандролон';

  @override
  String get dihydrotestosterone => 'Дигідротестостерон';

  @override
  String get spironolactone => 'Спіронолактон';

  @override
  String get cyproteroneAcetate => 'Ципротерон ацетат';

  @override
  String get leuprorelinAcetate => 'Лейпрорелін ацетат';

  @override
  String get bicalutamide => 'Бікалутамід';

  @override
  String get decapeptyl => 'Декапептил';

  @override
  String get raloxifene => 'Ралоксифен';

  @override
  String get tamoxifen => 'Тамоксифен';

  @override
  String get finasteride => 'Фінастерид';

  @override
  String get dutasteride => 'Дутастерид';

  @override
  String get minoxidil => 'Міноксидил';

  @override
  String get pioglitazone => 'Піоґлітазон';

  @override
  String get enanthate => 'Енантат';

  @override
  String get valerate => 'Валерат';

  @override
  String get cypionate => 'Ципіонат';

  @override
  String get undecylate => 'Ундецилат';

  @override
  String get benzoate => 'Бензоат';

  @override
  String get cypionateSuspension => 'Суспенція Ципіонату';

  @override
  String get medicationEstradiolEnanthate => 'Естрадіол енантат';

  @override
  String get medicationEstradiolValerate => 'Естрадіол валерат';

  @override
  String get medicationEstradiolCypionate => 'Естрадіол ципіонат';

  @override
  String get medicationEstradiolUndecylate => 'Естрадіол ундецилат';

  @override
  String get medicationEstradiolBenzoate => 'Естрадіол бензоат';

  @override
  String get medicationEstradiolCypionateSuspension =>
      'Естрадіол суспенція ципіонату';

  @override
  String get medicationTestosteroneEnanthate => 'Тестостерон енантат';

  @override
  String get medicationTestosteroneValerate => 'Тестостерон валерат';

  @override
  String get medicationTestosteroneCypionate => 'Тестостерон ципіонат';

  @override
  String get medicationTestosteroneUndecylate => 'Тестостерон ундецилат';

  @override
  String get medicationTestosteroneBenzoate => 'Тестостерон бензоат';

  @override
  String get medicationTestosteroneCypionateSuspension =>
      'Тестостерон суспенція ципіонату';

  @override
  String get injection => 'Ін\'єкції';

  @override
  String get oral => 'Орально';

  @override
  String get sublingual => 'Під\'язиково';

  @override
  String get patch => 'Патч';

  @override
  String get gel => 'Гель';

  @override
  String get implant => 'Імплант';

  @override
  String get suppository => 'Супозиторій';

  @override
  String get transdermalSpray => 'Трансдермальний спрей';

  @override
  String get transdermalDrops => 'Трансдермальні краплі';

  @override
  String get unitMilligram => 'мг';

  @override
  String get unitPgPerMl => 'пг/мл';

  @override
  String get unitPmolPerL => 'пмоль/л';

  @override
  String get unitNgPerDl => 'нг/дл';

  @override
  String get unitNmolPerL => 'нмоль/л';

  @override
  String administrationRouteUnitMl(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ml',
      one: 'ml',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitPill(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      few: 'пігулки',
      other: 'пігулок',
      one: 'пігулка',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitPatch(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      few: 'патчі',
      other: 'патчів',
      one: 'патч',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitPump(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'натискань',
      few: 'натискання',
      one: 'натискання',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitImplant(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      few: 'імпланти',
      other: 'імплантів',
      one: 'імплант',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitSuppository(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      few: 'супозиторії',
      other: 'супозиторіїв',
      one: 'супозиторій',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitSpray(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      few: 'спреї',
      other: 'спреїв',
      one: 'спрей',
    );
    return '$_temp0';
  }

  @override
  String get injectionSideLeft => 'Ліва';

  @override
  String get injectionSideRight => 'Права';

  @override
  String get intakeSummaryInjectionSideLeft => 'Ліва сторона';

  @override
  String get intakeSummaryInjectionSideRight => 'Права сторона';

  @override
  String get requiredField => 'Обов\'язкове поле';

  @override
  String get mustBePositiveNumber => 'Має бути додатнім числом';

  @override
  String get invalidTotalAmount => 'Невірна сумарна кількість';

  @override
  String get cannotExceedTotalCapacity =>
      'Не може перевищувати загальну ємність';
}
