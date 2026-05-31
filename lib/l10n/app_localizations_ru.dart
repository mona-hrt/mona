// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Mona';

  @override
  String get nav_home => 'Mona';

  @override
  String get nav_intakes => 'Приёмы';

  @override
  String get nav_levels => 'Уровни';

  @override
  String get nav_supplies => 'Препараты';

  @override
  String get takeAnIntake => 'Добавить приём';

  @override
  String get addAnItem => 'Добавить препарат';

  @override
  String get empty_home => 'Начните с добавления расписания в настройках';

  @override
  String get allDone => 'Всё принято!';

  @override
  String get noIntakesDue => 'На сегодня нет приёмов';

  @override
  String get upcoming => 'Ближайшие';

  @override
  String get taken => 'Принято';

  @override
  String daysAgoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дней назад',
      few: '$count дня назад',
      one: '$count день назад',
    );
    return '$_temp0';
  }

  @override
  String inDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'через $count дней',
      few: 'через $count дня',
      one: 'через $count день',
    );
    return '$_temp0';
  }

  @override
  String get lastTaken => 'Последний приём';

  @override
  String get neverTakenYet => 'Ещё не принято';

  @override
  String get scheduleFrequencyDaily => 'Ежедневно';

  @override
  String scheduleFrequencyEveryNDays(num days) {
    return 'Каждые $days дней';
  }

  @override
  String get scheduleFrequencyInterval => 'Интервально';

  @override
  String get newUpdateAvailable => 'Доступно новое обновление!';

  @override
  String get goToSettings => 'Перейти в настройки';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get notifications => 'Уведомления';

  @override
  String get schedulesAndNotifications => 'Расписания и уведомления';

  @override
  String get general => 'Общее';

  @override
  String get schedules => 'Расписания';

  @override
  String get noSchedules => 'Нет расписаний';

  @override
  String schedulesCreated(num count) {
    return '$count создано';
  }

  @override
  String get language => 'Язык';

  @override
  String get languageFollowDevice => 'Язык устройства';

  @override
  String get selectLanguage => 'Выбрать язык';

  @override
  String get enableNotifications => 'Включить уведомления';

  @override
  String get enableNotificationsDescription => 'Отправлять напоминания';

  @override
  String get notificationsDisabledTitle => 'Уведомления отключены';

  @override
  String get clickToOpenSettings => 'Нажмите для открытия настроек';

  @override
  String get exactRemindersDisabled => 'Точные напоминания недоступны';

  @override
  String get remindersDelayed =>
      'Напоминания могут отставать. Нажмите для открытия настроек.';

  @override
  String get autoUpdate => 'Авто-обновления';

  @override
  String get autoUpdateDescription =>
      'Автоматически проверять наличие обновлений при запуске приложения';

  @override
  String get checkForUpdates => 'Проверить наличие обновлений';

  @override
  String get checkForUpdatesDescription =>
      'Вручную проверить наличие обновлений\nДанное действие подключит вас к интернету\n(Данные переданы не будут)';

  @override
  String appVersion(Object version) {
    return 'Mona, версия $version';
  }

  @override
  String backupSavedTo(Object path) {
    return 'Копия данных сохранена в $path';
  }

  @override
  String exportFailed(Object error) {
    return 'Ошибка экспорта: $error';
  }

  @override
  String get importDataTitle => 'Импорт данных';

  @override
  String get importDataSubtitle => 'Восстановить копию данных из JSON-файла';

  @override
  String get importDataOverwriteWarning =>
      'Восстановление старой копии данных перезапишет все текущие данные, что невозможно отменить. Продолжить?';

  @override
  String get importConfirm => 'Импортировать';

  @override
  String get importSuccessfulTitle => 'Импорт успешен';

  @override
  String get importRestartRequired =>
      'Перезапустите приложение для завершения восстановления данных.';

  @override
  String get closeApp => 'Закрыть';

  @override
  String importFailed(Object error) {
    return 'Ошибка восстановления: $error';
  }

  @override
  String get updates => 'Обновления';

  @override
  String get dataManagement => 'Управление данными';

  @override
  String get exportDataTitle => 'Экспорт данных';

  @override
  String get exportDataSubtitle => 'Сохранить копию данных в JSON-файл';

  @override
  String get units => 'Единицы измерения';

  @override
  String get updateNoCompatibleApk => 'Совместимых обновлений не найдено.';

  @override
  String get updateAppUpToDate => 'Установлена последняя версия приложения!';

  @override
  String get updateCheckNetworkError =>
      'Не удалось проверить наличие обновлений.';

  @override
  String get updateDialogTitle => 'Доступно обновление';

  @override
  String updateDialogBody(Object current, Object latest) {
    return 'Доступна версия $latest! (Текущая: $current)\n\nСовместимое с Вашим устройством обновление доступно к установке.';
  }

  @override
  String get updateDownloadAndInstall => 'Обновить';

  @override
  String get updateInstallPermissionRequired =>
      'Для установки обновления необходимо выдать разрешение.';

  @override
  String get updateDownloadingTitle => 'Обновление скачивается...';

  @override
  String updateFailedOpenInstaller(Object message) {
    return 'Ошибка при открытии установщика: $message';
  }

  @override
  String get updateDownloadFailed =>
      'Ошибка скачивания. Пожалуйста, проверьте своё интернет соединение.';

  @override
  String notificationMedicationReminderTitle(Object scheduleName) {
    return 'Пора принять $scheduleName';
  }

  @override
  String notificationMedicationReminderBody(Object dateTime) {
    return 'Запланировано на $dateTime';
  }

  @override
  String get addSchedule => 'Добавить расписание';

  @override
  String get addScheduleToGetStarted => 'Добавьте расписание для начала.';

  @override
  String get newSchedule => 'Новое расписание';

  @override
  String get every => 'Каждые';

  @override
  String get days => 'дней';

  @override
  String get startDate => 'Дата начала';

  @override
  String get pickATime => 'Выберите время';

  @override
  String get addIntakeTime => 'Добавить время';

  @override
  String get editScheduleInfo => 'Изменить информацию расписания';

  @override
  String get scheduling => 'Расписание';

  @override
  String get noNotifications => 'Нет уведомлений';

  @override
  String notificationsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count уведомлений',
      few: '$count уведомления',
      one: '$count уведомление',
    );
    return '$_temp0';
  }

  @override
  String get editSchedule => 'Изменение расписания';

  @override
  String deleteSchedule(Object name) {
    return 'Удалить $name?';
  }

  @override
  String get scheduleNotifications => 'Уведомления расписания';

  @override
  String get addNotification => 'Добавить уведомление';

  @override
  String noNotificationsForSchedule(Object scheduleName) {
    return 'Для $scheduleName нет уведомлений. Вы можете создать их с помощью кнопки внизу.';
  }

  @override
  String get notificationsUpdated => 'Уведомления были обновлены!';

  @override
  String get notificationsUpdatedDescription =>
      'Каждое расписание теперь имеет свои уведомления.\n\nПожалуйста, (пере)настройте уведомления для своих расписаний.';

  @override
  String get dontShowAgain => 'Больше не показывать';

  @override
  String get scheduleSettings => 'Настройки расписания';

  @override
  String get empty_intakes => 'Добавленные приёмы будут отображаться тут.';

  @override
  String get chooseSchedule => 'Выберите расписание';

  @override
  String get addSchedulesFirst => 'Сначала добавьте расписание.';

  @override
  String get editIntake => 'Изменение приёма';

  @override
  String get date => 'Время';

  @override
  String get amount => 'Количество';

  @override
  String get none => 'Не выбрано';

  @override
  String get supplyItem => 'Препарат';

  @override
  String get injectionSide => 'Сторона';

  @override
  String get deleteIntake => 'Удалить приём?';

  @override
  String takeMedication(Object scheduleName) {
    return 'Принять $scheduleName';
  }

  @override
  String get takeIntake => 'Записать приём';

  @override
  String get needleDeadSpace => 'Мёртвое (пустое) пространство иглы';

  @override
  String get notes => 'Заметки';

  @override
  String get microliters => 'мкл';

  @override
  String get empty_levels =>
      'Приёмы эстрадиола будут отображаться в данной вкладке';

  @override
  String get bloodTestsTitle => 'Анализы крови';

  @override
  String get empty_blood_tests =>
      'Записанные результаты анализов будут отображаться тут. Вы можете создать их с помощью кнопки внизу.';

  @override
  String get addBloodTest => 'Добавить анализ';

  @override
  String get editBloodTest => 'Изменение результатов анализа';

  @override
  String get newBloodTest => 'Запись результатов анализа';

  @override
  String get deleteBloodTest => 'Удалить данный результат анализа?';

  @override
  String get estradiolLevelLabel => 'Уровень эстрадиола';

  @override
  String get testosteroneLevelLabel => 'Уровень тестостерона';

  @override
  String get bloodTestDateLabel => 'Дата анализа';

  @override
  String chartNowConcentration(Object value) {
    return 'Сейчас $value';
  }

  @override
  String chartBloodTestLevelTooltip(Object date, Object level) {
    return '$date: $level';
  }

  @override
  String get empty_supplies =>
      'Нет препаратов. Для начала работы добавьте препарат.';

  @override
  String get newItem => 'Новый препарат';

  @override
  String get adminRoute => 'Способ приёма';

  @override
  String get totalAmount => 'Общее количество';

  @override
  String get concentration => 'Концентрация';

  @override
  String get editItem => 'Изменение препарата';

  @override
  String get usedAmount => 'Использовано';

  @override
  String deleteItem(Object name) {
    return 'Удалить $name?';
  }

  @override
  String remaining(num amount, Object unit) {
    return '$amount $unit осталось';
  }

  @override
  String get allItemsFilter => 'All';

  @override
  String get medicationItemsFilter => 'Medication';

  @override
  String get genericItemsFilter => 'Consumables';

  @override
  String get medicationType => 'Medication';

  @override
  String get genericType => 'Consumable';

  @override
  String get genericItemType => 'Type';

  @override
  String syringe(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Syringes',
      one: 'Syringe',
    );
    return '$_temp0';
  }

  @override
  String wipe(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wipes',
      one: 'Wipe',
    );
    return '$_temp0';
  }

  @override
  String needle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Needles',
      one: 'Needle',
    );
    return '$_temp0';
  }

  @override
  String gloves(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gloves',
      one: 'Gloves',
    );
    return '$_temp0';
  }

  @override
  String bandage(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bandages',
      one: 'Bandage',
    );
    return '$_temp0';
  }

  @override
  String get add => 'Добавить';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отменить';

  @override
  String get next => 'Далее';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteElement => 'Удалить данный препарат?';

  @override
  String get irreversibleAction => 'Данное действие отменить невозможно.';

  @override
  String get name => 'Название';

  @override
  String get molecule => 'Молекула';

  @override
  String get ester => 'Эфир';

  @override
  String get estradiol => 'Эстрадиол';

  @override
  String get progesterone => 'Прогестерон';

  @override
  String get testosterone => 'Тестостерон';

  @override
  String get nandrolone => 'Нандролон';

  @override
  String get spironolactone => 'Спиронолактон';

  @override
  String get cyproteroneAcetate => 'Ципротерона ацетат';

  @override
  String get leuprorelinAcetate => 'Леупрорелина ацетат';

  @override
  String get bicalutamide => 'Бикалутамид';

  @override
  String get decapeptyl => 'Декапептил';

  @override
  String get raloxifene => 'Ралоксифен';

  @override
  String get tamoxifen => 'Тамоксифен';

  @override
  String get finasteride => 'Финастерид';

  @override
  String get dutasteride => 'Дутастерид';

  @override
  String get minoxidil => 'Миноксидил';

  @override
  String get pioglitazone => 'Пиоглитазон';

  @override
  String get enanthate => 'Энантат';

  @override
  String get valerate => 'Валерат';

  @override
  String get cypionate => 'Ципионат';

  @override
  String get undecylate => 'Ундецилат';

  @override
  String get benzoate => 'Бензоат';

  @override
  String get cypionateSuspension => 'Суспензия ципионата';

  @override
  String get medicationEstradiolEnanthate => 'Эстрадиола энантат';

  @override
  String get medicationEstradiolValerate => 'Эстрадиола валерат';

  @override
  String get medicationEstradiolCypionate => 'Эстрадиола ципионат';

  @override
  String get medicationEstradiolUndecylate => 'Эстрадиола ундецилат';

  @override
  String get medicationEstradiolBenzoate => 'Эстрадиола бензоат';

  @override
  String get medicationEstradiolCypionateSuspension =>
      'Суспензия эстрадиола ципионата';

  @override
  String get medicationTestosteroneEnanthate => 'Тестостерона энантат';

  @override
  String get medicationTestosteroneValerate => 'Тестостерона валерат';

  @override
  String get medicationTestosteroneCypionate => 'Тестостерона ципионат';

  @override
  String get medicationTestosteroneUndecylate => 'Тестостерона ундецилат';

  @override
  String get medicationTestosteroneBenzoate => 'Тестостерона бензоат';

  @override
  String get medicationTestosteroneCypionateSuspension =>
      'Суспензия тестостерона ципионата';

  @override
  String get injection => 'Инъекционно';

  @override
  String get oral => 'Орально';

  @override
  String get sublingual => 'Сублингвально';

  @override
  String get patch => 'Пластырь';

  @override
  String get gel => 'Гель';

  @override
  String get implant => 'Имплант';

  @override
  String get suppository => 'Суппозитория';

  @override
  String get transdermalSpray => 'Трансдермальный спрей';

  @override
  String get transdermalDrops => 'Трансдермальные капли';

  @override
  String administrationRouteUnitMl(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'мл',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitPill(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'таблеток',
      few: 'таблетки',
      one: 'таблетка',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitPatch(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'пластырей',
      few: 'пластыря',
      one: 'пластырь',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitPump(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'помп',
      few: 'помпы',
      one: 'помпа',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitImplant(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'имплантов',
      few: 'импланта',
      one: 'имплант',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitSuppository(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'суппозиторий',
      few: 'суппозитории',
      one: 'суппозитория',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitSpray(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'брызгов',
      few: 'брызг',
      one: 'брызг',
    );
    return '$_temp0';
  }

  @override
  String get injectionSideLeft => 'Левая';

  @override
  String get injectionSideRight => 'Правая';

  @override
  String get intakeSummaryInjectionSideLeft => 'Левая сторона';

  @override
  String get intakeSummaryInjectionSideRight => 'Правая сторона';

  @override
  String get requiredField => 'Обязательное поле';

  @override
  String get mustBePositiveNumber => 'Число должно быть положительным';

  @override
  String get invalidTotalAmount => 'Неверное общее количество';

  @override
  String get cannotExceedTotalCapacity => 'Не может превышать общее количество';
}
