// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'Mona';

  @override
  String get nav_home => 'Mona';

  @override
  String get nav_intakes => 'การทาน';

  @override
  String get nav_levels => 'ระดับ';

  @override
  String get nav_supplies => 'สต็อก';

  @override
  String get takeAnIntake => 'ทานยา';

  @override
  String get addAnItem => 'เพื่มสต็อก';

  @override
  String get empty_home => 'เริ่มด้วยการเพื่มตารางเวลาในการตั้งค่า';

  @override
  String get allDone => 'ครบหมดแล้ว!';

  @override
  String get noIntakesDue => 'ไม่มียาที่ต้องทานวันนี้';

  @override
  String get upcoming => 'เร็วๆนี้';

  @override
  String get taken => 'ทานแล้ว';

  @override
  String daysAgoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count วันที่แล้ว',
      one: 'เมื่อวาน',
    );
    return '$_temp0';
  }

  @override
  String inDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ใน $count วัน',
      one: 'พรุ่งนี้',
    );
    return '$_temp0';
  }

  @override
  String get lastTaken => 'ทานไป';

  @override
  String get neverTakenYet => 'ยังไม่เคยทาน';

  @override
  String get scheduleFrequencyDaily => 'ทุกวัน';

  @override
  String scheduleFrequencyEveryNDays(num days) {
    return '$days วันครั้ง';
  }

  @override
  String get scheduleFrequencyInterval => 'ระยะห่าง';

  @override
  String get scheduleFrequencyWeekly => 'Weekly';

  @override
  String get newUpdateAvailable => 'มีอัพเดตใหม่!';

  @override
  String get goToSettings => 'ไปที่การตั้งค่า';

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get notifications => 'การแจ้งเตือน';

  @override
  String get schedulesAndNotifications => 'กำหนดเวลาและการแจ้งเตือน';

  @override
  String get general => 'ทั่วไป';

  @override
  String get schedules => 'ตารางเวลา';

  @override
  String get noSchedules => 'ไม่มีตารางเวลา';

  @override
  String schedulesCreated(num count) {
    return 'สร้างแล้ว $count';
  }

  @override
  String get language => 'ภาษา';

  @override
  String get languageFollowDevice => 'ตามภาษาระบบ';

  @override
  String get selectLanguage => 'เลือกภาษา';

  @override
  String get enableNotifications => 'เปิดการแจ้งเตือน';

  @override
  String get enableNotificationsDescription => 'ส่งการแจ้งเตือน';

  @override
  String get notificationsDisabledTitle => 'การแจ้งเตือนได้ปิดอยู่';

  @override
  String get clickToOpenSettings => 'แตะเพื่อเปิดการตั้งค่า';

  @override
  String get exactRemindersDisabled => 'การแจ้งเตือนแบบตรงเวลาได้ปิดอยู่';

  @override
  String get remindersDelayed =>
      'การแจ้งเตือนอาจล่าช้าได้ แตะเพื่อเปิดการตั้งค่า';

  @override
  String get autoUpdate => 'อัพเดตอัตโนมัติ';

  @override
  String get autoUpdateDescription => 'ตรวจหาอัพเดตอัตโนมัติตอนที่เปิดแอพ';

  @override
  String get checkForUpdates => 'ตรวจหาอัพเดตใหม่';

  @override
  String get checkForUpdatesDescription =>
      'ฉันจะตรวจหาอัพเดตใหม่ล่าสุดเอง\nจะทำให้เปิดเครือข่าย\n(จะไม่มีข้อมูลใดๆส่งออกนอกเครื่อง)';

  @override
  String appVersion(Object version) {
    return 'Mona เวอร์ชั่น $version';
  }

  @override
  String backupSavedTo(Object path) {
    return 'แบ็คอัพบันทึกไปที่ $path';
  }

  @override
  String exportFailed(Object error) {
    return 'นำออกล้มเหลว: $error';
  }

  @override
  String get importDataTitle => 'นำเข้าข้อมูล';

  @override
  String get importDataSubtitle => 'กู้คืนข้อมูลจากแบ็คอัพ JSON';

  @override
  String get importDataOverwriteWarning =>
      'จะแทนที่ข้อมูลทั้งหมดด้วยข้อมูลจากแบ็คอัพ โดยที่ย้อนกลับไม่ได้ ทำต่อ?';

  @override
  String get importConfirm => 'นำเข้า';

  @override
  String get importSuccessfulTitle => 'นำเข้าสำเร็จ';

  @override
  String get importRestartRequired =>
      'โปรดปิดแล้วเปิดแอพใหม่เพื่อให้ข้อมูลที่กู้คืนมาแสดงผล';

  @override
  String get closeApp => 'ปิดแอพ';

  @override
  String importFailed(Object error) {
    return 'นำเข้าล้มเหลว: $error';
  }

  @override
  String get updates => 'อัพเดต';

  @override
  String get dataManagement => 'การจัดการข้อมูล';

  @override
  String get exportDataTitle => 'ส่งออกข้อมูล';

  @override
  String get exportDataSubtitle => 'บันทึกข้อมูลไปยังไฟล์ JSON';

  @override
  String get units => 'หน่วย';

  @override
  String get updateNoCompatibleApk => 'ไม่มีอัพเดตที่รับรองระบบของคุณ';

  @override
  String get updateAppUpToDate => 'แอพเป็นเวอร์ชั่นล่าสุดแล้ว';

  @override
  String get updateCheckNetworkError => 'ไม่สามารถตรวจสอบอัพเดทในขณะนี้ได้';

  @override
  String get updateDialogTitle => 'มีอัพเดตใหม่';

  @override
  String updateDialogBody(Object current, Object latest) {
    return 'มีเวอร์ชั่นใหม่ $latest (ติดตั้งอยู่: $current)\n\nมีอัพเดตใหม่ที่พร้อมที่จะติดตั้งแล้ว';
  }

  @override
  String get updateDownloadAndInstall => 'ดาวน์โหลดและติดตั้ง';

  @override
  String get updateInstallPermissionRequired =>
      'ต้องอนุญาตการติดตั้งอัพเดตก่อน';

  @override
  String get updateDownloadingTitle => 'กำลังดาวน์โหลดอัพเดต…';

  @override
  String updateFailedOpenInstaller(Object message) {
    return 'เปิดตัวติดตั้งล้มเหลว: $message';
  }

  @override
  String get updateDownloadFailed =>
      'ดาวน์โหลดล้มเหลว โปรดตรวจสอบเครือข่ายของคุณ';

  @override
  String notificationMedicationReminderTitle(Object scheduleName) {
    return 'เวลาทาน $scheduleName';
  }

  @override
  String notificationMedicationReminderBodyDate(Object date) {
    return 'Scheduled for $date';
  }

  @override
  String notificationMedicationReminderBodyTime(Object time) {
    return 'Scheduled for $time';
  }

  @override
  String notificationMedicationReminderBodyWeekday(Object weekday) {
    return 'Scheduled for $weekday';
  }

  @override
  String get addSchedule => 'เพื่มตารางเวลา';

  @override
  String get addScheduleToGetStarted => 'เพื่มตารางเวลาเพื่อเรื่ม';

  @override
  String get newSchedule => 'ตารางเวลาใหม่';

  @override
  String get every => 'ทุกๆ';

  @override
  String get days => 'วัน';

  @override
  String get startDate => 'วันที่เรื่ม';

  @override
  String get pickATime => 'เลือกเวลา';

  @override
  String get addIntakeTime => 'เพื่มเวลา';

  @override
  String get editScheduleInfo => 'แก้ไขข้อมูลตารางเวลา';

  @override
  String get scheduling => 'การจัดเวลา';

  @override
  String get noNotifications => 'ไม่มีการแจ้งเตือน';

  @override
  String notificationsCount(num count) {
    return '$count การแจ้งเตือน';
  }

  @override
  String get editSchedule => 'แก้ไขตารางเวลา';

  @override
  String deleteSchedule(Object name) {
    return 'ลบ $name?';
  }

  @override
  String get scheduleNotifications => 'การแจ้งเตือนตารางเวลา';

  @override
  String get addNotification => 'เพื่มการแจ้งเตือน';

  @override
  String noNotificationsForSchedule(Object scheduleName) {
    return 'ไม่มีการแจ้งเตือนสำหรับ $scheduleName สามารถเพื่มได้ด้วยปุ่ม “เพื่ม”';
  }

  @override
  String get notificationsUpdated => 'การแจ้งเตือนอัพเดตแล้ว';

  @override
  String get notificationsUpdatedDescription =>
      'ทุกตารางเวลามีการแจ้งเตือนของตนเองแล้ว\n\nโปรดตั้งการแจ้งเตือนของตารางเวลาของคุณเพื่อที่จะไม่ลืม';

  @override
  String get dontShowAgain => 'อย่าแสตงอีก';

  @override
  String get scheduleSettings => 'ตั้งค่าตารางเวลา';

  @override
  String get empty_intakes => 'ยาที่ทานแล้วจะมาอยู่ที่นี่';

  @override
  String get chooseSchedule => 'เลือกตารางเวลา';

  @override
  String get addSchedulesFirst => 'เพื่มตารางเวลาก่อน';

  @override
  String get editIntake => 'แก้ไขการทาน';

  @override
  String get date => 'วันที่';

  @override
  String get amount => 'ปริมาณ';

  @override
  String get none => 'ไม่มี';

  @override
  String get supplyItem => 'ของในสต็อก';

  @override
  String get injectionSide => 'ข้างที่ฉีด';

  @override
  String get deleteIntake => 'ลบโดสยานี้?';

  @override
  String takeMedication(Object scheduleName) {
    return 'ทาน $scheduleName';
  }

  @override
  String get takeIntake => 'ทานโดสยา';

  @override
  String get needleDeadSpace => 'ปริมาณเว้นเปล่าในเข็ม';

  @override
  String get notes => 'บันทึก';

  @override
  String get microliters => 'ไมโครลิตร';

  @override
  String get empty_levels => 'การฉีดเอสตราไดออลจะขึ้นในแท็บนี้';

  @override
  String get bloodTestsTitle => 'การตรวจเลือด';

  @override
  String get empty_blood_tests =>
      'ผลตรวจเลือดจะมาขึ้นที่นี่ เรื่มด้วยการกดปุ่ม “เพื่ม”';

  @override
  String get addBloodTest => 'เพิ่มผลตรวจเลือด';

  @override
  String get editBloodTest => 'แก้ไขผลตรวจเลือด';

  @override
  String get newBloodTest => 'ผลตรวจเลือดใหม่';

  @override
  String get deleteBloodTest => 'ลบผลตรวจเลือดนี้ใหม';

  @override
  String get estradiolLevelLabel => 'ระดับเอสตราไดออล';

  @override
  String get testosteroneLevelLabel => 'ระดับเทสโทสเตอโรน';

  @override
  String get bloodTestDateLabel => 'วันที่ตรวจ';

  @override
  String chartNowConcentration(Object value) {
    return 'ตอนนี้ $value';
  }

  @override
  String chartBloodTestLevelTooltip(Object date, Object level) {
    return 'ณ $date: $level';
  }

  @override
  String get empty_supplies => 'ไม่มีสต็อกอยู่ โปรดเพื่มสต็อก';

  @override
  String get newItem => 'สต็อกใหม่';

  @override
  String get adminRoute => 'วิธีนำเข้าร่างกาย';

  @override
  String get totalAmount => 'ปริมาณทั้งหมด';

  @override
  String get concentration => 'ความเข้มข้น';

  @override
  String get editItem => 'แก้ไขสต็อก';

  @override
  String get usedAmount => 'ปริมาณที่ใช้ไป';

  @override
  String deleteItem(Object name) {
    return 'ลบ $name?';
  }

  @override
  String remaining(num amount, Object unit) {
    return 'เหลือ $amount $unit';
  }

  @override
  String get allItemsFilter => 'ทั้งหมด';

  @override
  String get medicationItemsFilter => 'ยา';

  @override
  String get genericItemsFilter => 'ของใช้';

  @override
  String get medicationItemType => 'ยา';

  @override
  String get genericItemType => 'ของใช้';

  @override
  String get supplyType => 'ชนิด';

  @override
  String syringe(num count) {
    return 'กระบอกฉีดยา';
  }

  @override
  String wipe(num count) {
    return 'ผ้าเช็ด';
  }

  @override
  String needle(num count) {
    return 'เข็มฉีดยา';
  }

  @override
  String gloves(num count) {
    return 'ถุงมือ';
  }

  @override
  String bandage(num count) {
    return 'พลาสเตอร์';
  }

  @override
  String get add => 'เพื่ม';

  @override
  String get save => 'บันทึก';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get next => 'ถัดไป';

  @override
  String get delete => 'ลบ';

  @override
  String get deleteElement => 'ลบสต็อกนี้ใหม?';

  @override
  String get irreversibleAction => 'จะไม่สามารถย้อนกลับได้';

  @override
  String get name => 'ชื่อ';

  @override
  String get molecule => 'ชนิดยา';

  @override
  String get ester => 'เอสเทอร์';

  @override
  String get estradiol => 'เอสตราไดออล';

  @override
  String get progesterone => 'โปรเจสเตอโรน';

  @override
  String get testosterone => 'เทสโทสเตอโรน';

  @override
  String get nandrolone => 'นันโดรโลน';

  @override
  String get dihydrotestosterone => 'ไดไฮโดรเทสโทสเตอโรน';

  @override
  String get spironolactone => 'สไปโรโนแลคโทน';

  @override
  String get cyproteroneAcetate => 'ไซโปรเทอโรน อะซิเตท';

  @override
  String get leuprorelinAcetate => 'ลิวโปรเรลิน อะซิเตท';

  @override
  String get bicalutamide => 'บิคาลูทาไมด์';

  @override
  String get decapeptyl => 'เดแคปติล';

  @override
  String get raloxifene => 'ราลอกซิเฟน';

  @override
  String get tamoxifen => 'ทาม็อกซิเฟน';

  @override
  String get finasteride => 'ฟินาสเตอไรด์';

  @override
  String get dutasteride => 'ดูทาสเตอไรด์';

  @override
  String get minoxidil => 'มิน็อกซิดิล';

  @override
  String get pioglitazone => 'ปิโอไกลตาโซน';

  @override
  String get enanthate => 'เอนันเทต';

  @override
  String get valerate => 'วาเลอเรต';

  @override
  String get cypionate => 'ไซพิโอเนต';

  @override
  String get undecylate => 'อันเดซิเลต';

  @override
  String get benzoate => 'เบนโซเอต';

  @override
  String get cypionateSuspension => 'สารแขวนลอยไซพิโอเนต';

  @override
  String get medicationEstradiolEnanthate => 'เอสตราไดออล เอนันเทต';

  @override
  String get medicationEstradiolValerate => 'เอสตราไดออล วาเลอเรต';

  @override
  String get medicationEstradiolCypionate => 'เอสตราไดออล ไซพิโอเนต';

  @override
  String get medicationEstradiolUndecylate => 'เอสตราไดออล อันเดซิเลต';

  @override
  String get medicationEstradiolBenzoate => 'เอสตราไดออล เบนโซเอต';

  @override
  String get medicationEstradiolCypionateSuspension =>
      'สารแขวนลอยในเอสตราไดออล ไซพิโอเนต';

  @override
  String get medicationTestosteroneEnanthate => 'เทสโทสเตอโรน เอนันเทต';

  @override
  String get medicationTestosteroneValerate => 'เทสโทสเตอโรน วาเลอเรต';

  @override
  String get medicationTestosteroneCypionate => 'เทสโทสเตอโรน ไซพิโอเนต';

  @override
  String get medicationTestosteroneUndecylate => 'เทสโทสเตอโรน อันเดซิเลต';

  @override
  String get medicationTestosteroneBenzoate => 'เทสโทสเตอโรน เบนโซเอต';

  @override
  String get medicationTestosteroneCypionateSuspension =>
      'สารแขวนลอยในเทสโทสเตอโรน ไซพิโอเนต';

  @override
  String get injection => 'ยาฉีด';

  @override
  String get oral => 'ยาทาน';

  @override
  String get sublingual => 'ยาแช่ใต้ลิ้น';

  @override
  String get patch => 'แผ่นแปะ';

  @override
  String get gel => 'ยาเจล';

  @override
  String get implant => 'ยาเม็ดแบบฝัง';

  @override
  String get suppository => 'ยาเหน็บทวาร';

  @override
  String get transdermalSpray => 'สเปรย์ซึมผิวหนัง';

  @override
  String get transdermalDrops => 'ยาหยอดซึมผิวหนัง';

  @override
  String get unitMilligram => 'TODO';

  @override
  String administrationRouteUnitMl(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'มิลลิลิตร',
      one: 'มิลลิลิตร',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitPill(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'เม็ด',
      one: 'เม็ด',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitPatch(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'แผ่น',
      one: 'แผ่น',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitPump(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ปั้ม',
      one: 'ปั้ม',
    );
    return '$_temp0';
  }

  @override
  String administrationRouteUnitImplant(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ที่',
      one: 'ที่',
    );
    return 'ฝัง $_temp0';
  }

  @override
  String administrationRouteUnitSuppository(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'เม็ด',
      one: 'เม็ด',
    );
    return 'ยาเหน็บ $_temp0';
  }

  @override
  String administrationRouteUnitSpray(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'สเปรย์',
      one: 'สเปรย์',
    );
    return '$_temp0';
  }

  @override
  String get injectionSideLeft => 'ซ้าย';

  @override
  String get injectionSideRight => 'ขวา';

  @override
  String get intakeSummaryInjectionSideLeft => 'ด้านซ้าย';

  @override
  String get intakeSummaryInjectionSideRight => 'ด้านขวา';

  @override
  String get requiredField => 'ต้องใส่';

  @override
  String get mustBePositiveNumber => 'ต้องเป็นตัวเลขมากกว่า 0';

  @override
  String get invalidTotalAmount => 'จำนวนรวมผิดรูปแบบ';

  @override
  String get cannotExceedTotalCapacity => 'จำนวนเกินรวมไม่ได้';
}
