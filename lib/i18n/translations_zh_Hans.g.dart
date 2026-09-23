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
class TranslationsZhHans extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsZhHans(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.zhHans,
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

  /// Metadata for the translations of <zh-Hans>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsZhHans _root = this; // ignore: unused_field

  @override
  TranslationsZhHans $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsZhHans(meta: meta ?? this.$meta);

  // Translations
  @override
  String get appTitle => 'Mona';
  @override
  String get nav_home => 'Mona';
  @override
  String get nav_intakes => '服用';
  @override
  String get nav_levels => '数值';
  @override
  String get nav_supplies => '用品';
  @override
  String get takeAnIntake => '记录服用';
  @override
  String get addAnItem => '添加物品';
  @override
  String get empty_home => '先到设置里添加一个计划吧';
  @override
  String get allDone => '全部完成！';
  @override
  String get noIntakesDue => '今天没有待服用的药物';
  @override
  String get upcoming => '即将到来';
  @override
  String get asNeeded => '按需';
  @override
  String get taken => '已服用';
  @override
  String get yesterday => '昨天';
  @override
  String get tomorrow => '明天';
  @override
  String get lastTaken => '上次服用';
  @override
  String get neverTakenYet => '尚未服用过';
  @override
  String get scheduleFrequencyDaily => '每天';
  @override
  String get scheduleFrequencyDailyDescription => '每天在固定的时间';
  @override
  String get scheduleFrequencyInterval => '间隔';
  @override
  String get scheduleFrequencyIntervalDescription => '每隔几天';
  @override
  String get scheduleFrequencyWeekly => '每周';
  @override
  String get scheduleFrequencyWeeklyDescription => '每周固定的几天';
  @override
  String get scheduleFrequencyMonthly => '每月';
  @override
  String get scheduleFrequencyMonthlyDescription => '每月同一天';
  @override
  String get scheduleFrequencyAsNeeded => '按需';
  @override
  String get scheduleFrequencyAsNeededDescription => '没有固定计划';
  @override
  String get newUpdateAvailable => '有新版本可用！';
  @override
  String get goToSettings => '前往设置';
  @override
  String get settingsTitle => '设置';
  @override
  String get notifications => '通知';
  @override
  String get schedulesAndNotifications => '计划与通知';
  @override
  String get general => '通用';
  @override
  String get schedules => '用药计划';
  @override
  String get noSchedules => '暂无计划';
  @override
  String get language => '语言';
  @override
  String get languageFollowDevice => '跟随系统语言';
  @override
  String get selectLanguage => '选择语言';
  @override
  String get enableNotifications => '启用通知';
  @override
  String get enableNotificationsDescription => '发送提醒';
  @override
  String get anchorToLastIntake => '按上次服用时间重新计算';
  @override
  String get anchorToLastIntakeDescription => '在你上次服用满一个完整间隔之后，再安排下一次';
  @override
  String get notificationsDisabledTitle => '通知已关闭';
  @override
  String get clickToOpenSettings => '点击打开设置';
  @override
  String get exactRemindersDisabled => '精确提醒时间已关闭';
  @override
  String get remindersDelayed => '提醒可能会略有延迟。点击打开设置。';
  @override
  String get medicalSettings => '医疗设置';
  @override
  String get theme => '主题';
  @override
  String get themeCustomizeColors => '自定义应用配色';
  @override
  String get customThemeEnabled => '自定义主题';
  @override
  String get themeGenerate => '生成';
  @override
  String get themeVariant => '变体';
  @override
  String get themeContrast => '对比度';
  @override
  String get themeContrastStandard => '标准';
  @override
  String get themeContrastMedium => '中等';
  @override
  String get themeContrastHigh => '高';
  @override
  String get autoUpdate => '自动更新';
  @override
  String get autoUpdateDescription => '启动应用时自动检查新版本';
  @override
  String get checkForUpdates => '检查更新';
  @override
  String get checkForUpdatesDescription => '手动检查最新版本\n这将连接互联网\n（不会发送任何数据）';
  @override
  String appVersion({required Object version}) => 'Mona 版本 ${version}';
  @override
  String exportFailed({required Object error}) => '导出失败：${error}';
  @override
  String get importDataTitle => '导入数据';
  @override
  String get importDataSubtitle => '从 JSON 备份恢复数据';
  @override
  String get importDataOverwriteWarning => '这会用备份覆盖你当前的全部数据。此操作无法撤销。是否继续？';
  @override
  String get importConfirm => '导入';
  @override
  String get importSuccessfulTitle => '导入成功';
  @override
  String get importRestartRequired => '请重启应用以应用已恢复的数据。';
  @override
  String get closeApp => '关闭应用';
  @override
  String importFailed({required Object error}) => '导入失败：${error}';
  @override
  String get updates => '更新';
  @override
  String get dataManagement => '数据管理';
  @override
  String get exportDataTitle => '导出数据';
  @override
  String get exportDataSubtitle => '将你的数据保存为 JSON 文件';
  @override
  String get units => '单位';
  @override
  String get updateNoCompatibleApk => '未找到与你的设备兼容的更新。';
  @override
  String get updateAppUpToDate => '你的应用已是最新版本！';
  @override
  String get updateCheckNetworkError => '暂时无法检查更新。';
  @override
  String get updateDialogTitle => '有可用更新';
  @override
  String updateDialogBody({required Object latest, required Object current}) =>
      '版本 ${latest} 已发布！（当前：${current}）\n\n已准备好与你的设备兼容的更新，可以安装。';
  @override
  String get updateDownloadAndInstall => '下载并安装';
  @override
  String get updateInstallPermissionRequired => '需要授予权限才能安装更新。';
  @override
  String get updateDownloadingTitle => '正在下载更新…';
  @override
  String updateFailedOpenInstaller({required Object message}) =>
      '无法打开安装程序：${message}';
  @override
  String get updateDownloadFailed => '下载失败。请检查网络连接。';
  @override
  String notificationMedicationReminderTitle({required Object scheduleName}) =>
      '该服用 ${scheduleName} 了';
  @override
  String notificationMedicationReminderBodyDate({required Object date}) =>
      '计划时间：${date}';
  @override
  String notificationMedicationReminderBodyTime({required Object time}) =>
      '计划时间：${time}';
  @override
  String notificationMedicationReminderBodyWeekday({required Object weekday}) =>
      '计划时间：${weekday}';
  @override
  String get addSchedule => '添加用药计划';
  @override
  String get addScheduleToGetStarted => '添加一个用药计划开始使用。';
  @override
  String get newSchedule => '新建计划';
  @override
  String get every => '每';
  @override
  String get days => '天';
  @override
  String get dayOfMonth => '每月几号';
  @override
  String get months => '个月';
  @override
  String get startDate => '开始日期';
  @override
  String get pickATime => '选择时间';
  @override
  String get addIntakeTime => '添加时间';
  @override
  String get editScheduleInfo => '编辑计划信息';
  @override
  String get scheduling => '排期';
  @override
  String get editSchedule => '编辑计划';
  @override
  String deleteSchedule({required Object name}) => '删除 ${name}？';
  @override
  String get addNotification => '添加通知';
  @override
  String get empty_intakes => '已服用的记录会显示在这里';
  @override
  String get HrtCounter => 'HRT 时长';
  @override
  String get HrtCounterDescription => '显示你进行 HRT 的时长，以及服用总次数';
  @override
  String get hrtWidgetPlaceholder => '打开 Mona 记录你的第一次服用';
  @override
  String get hrtWidgetPreviewSample => 'HRT 已 8 个月';
  @override
  String get hrtWidgetPreviewIntakeSample => '已记录 16 次服用';
  @override
  String get startOfDay => '每日起始时间';
  @override
  String startOfDayDescription({required Object time}) => '${time} 之前的记录计入前一天';
  @override
  String get chooseSchedule => '选择计划';
  @override
  String get addSchedulesFirst => '请先添加计划。';
  @override
  String get editIntake => '编辑服用记录';
  @override
  String get date => '日期';
  @override
  String get amount => '用量';
  @override
  String get takenAmount => '服用量';
  @override
  String get wastedAmount => '废弃量';
  @override
  String get none => '无';
  @override
  String get supplyItem => '所用物品';
  @override
  String get chooseItem => '选择物品';
  @override
  String get noItemsToAdd => '没有可添加的物品';
  @override
  String get injectionSide => '注射侧';
  @override
  String get deleteIntake => '删除这条服用记录？';
  @override
  String takeMedication({required Object scheduleName}) => '服用 ${scheduleName}';
  @override
  String get takeIntake => '记录服用';
  @override
  String get intakeRecorded => '已记录服用';
  @override
  String get needleDeadSpace => '针头死腔';
  @override
  String get notes => '备注';
  @override
  String get microliters => 'μL';
  @override
  String get milliliters => 'mL';
  @override
  String get empty_levels => '添加一次血检，或记录一次雌二醇注射，就可以开始了';
  @override
  String get bloodTestsTitle => '血液检测';
  @override
  String get estradiolLevelsTitle => '雌二醇数值';
  @override
  String get empty_blood_tests => '已完成的血检会显示在这里。点击添加按钮开始吧！';
  @override
  String get addBloodTest => '添加血检';
  @override
  String get editBloodTest => '编辑血检';
  @override
  String get newBloodTest => '新建血检';
  @override
  String get deleteBloodTest => '删除这条血检？';
  @override
  String get estradiolLevelLabel => '雌二醇数值';
  @override
  String get testosteroneLevelLabel => '睾酮数值';
  @override
  String get bloodTestDateLabel => '检测日期';
  @override
  String chartNowConcentration({required Object value}) => '当前 ${value}';
  @override
  String chartBloodTestLevelTooltip(
          {required Object date, required Object level}) =>
      '${date}：${level}';
  @override
  String chartLevelTooltip({required Object date, required Object level}) =>
      '${date}：${level}';
  @override
  String get empty_supplies => '暂无用品。添加一个物品开始吧。';
  @override
  String get newItem => '新建物品';
  @override
  String get adminRoute => '给药途径';
  @override
  String get totalAmount => '总量';
  @override
  String get concentration => '浓度';
  @override
  String dosePerUnitLabel({required Object unit}) => '每 ${unit} 剂量';
  @override
  String get editItem => '编辑物品';
  @override
  String get usedAmount => '已用量';
  @override
  String deleteItem({required Object name}) => '删除 ${name}？';
  @override
  String get allItemsFilter => '全部';
  @override
  String get medicationItemsFilter => '药物';
  @override
  String get genericItems => '耗材';
  @override
  String get medicationItemType => '药物';
  @override
  String get genericItemType => '耗材';
  @override
  String get supplyType => '类型';
  @override
  String get syringe => '注射器';
  @override
  String get wipe => '酒精棉片';
  @override
  String get needle => '针头';
  @override
  String get gloves => '手套';
  @override
  String get bandage => '创可贴';
  @override
  String get add => '添加';
  @override
  String get save => '保存';
  @override
  String get cancel => '取消';
  @override
  String get next => '下一步';
  @override
  String get delete => '删除';
  @override
  String get deleteElement => '删除这个物品？';
  @override
  String get irreversibleAction => '此操作无法撤销。';
  @override
  String get name => '名称';
  @override
  String get molecule => '成分';
  @override
  String get ester => '酯类';
  @override
  String get estradiol => '雌二醇';
  @override
  String get progesterone => '孕酮';
  @override
  String get testosterone => '睾酮';
  @override
  String get nandrolone => '诺龙';
  @override
  String get dihydrotestosterone => '双氢睾酮';
  @override
  String get spironolactone => '螺内酯';
  @override
  String get cyproteroneAcetate => '醋酸环丙孕酮';
  @override
  String get leuprorelinAcetate => '醋酸亮丙瑞林';
  @override
  String get bicalutamide => '比卡鲁胺';
  @override
  String get decapeptyl => '达菲林';
  @override
  String get raloxifene => '雷洛昔芬';
  @override
  String get tamoxifen => '他莫昔芬';
  @override
  String get finasteride => '非那雄胺';
  @override
  String get dutasteride => '度他雄胺';
  @override
  String get minoxidil => '米诺地尔';
  @override
  String get pioglitazone => '吡格列酮';
  @override
  String get enanthate => '庚酸酯';
  @override
  String get valerate => '戊酸酯';
  @override
  String get cypionate => '环戊丙酸酯';
  @override
  String get undecylate => '十一酸酯';
  @override
  String get benzoate => '苯甲酸酯';
  @override
  String get cypionateSuspension => '环戊丙酸酯混悬液';
  @override
  String get medicationEstradiolEnanthate => '庚酸雌二醇';
  @override
  String get medicationEstradiolValerate => '戊酸雌二醇';
  @override
  String get medicationEstradiolCypionate => '环戊丙酸雌二醇';
  @override
  String get medicationEstradiolUndecylate => '十一酸雌二醇';
  @override
  String get medicationEstradiolBenzoate => '苯甲酸雌二醇';
  @override
  String get medicationEstradiolCypionateSuspension => '环戊丙酸雌二醇混悬液';
  @override
  String get medicationTestosteroneEnanthate => '庚酸睾酮';
  @override
  String get medicationTestosteroneValerate => '戊酸睾酮';
  @override
  String get medicationTestosteroneCypionate => '环戊丙酸睾酮';
  @override
  String get medicationTestosteroneUndecylate => '十一酸睾酮';
  @override
  String get medicationTestosteroneBenzoate => '苯甲酸睾酮';
  @override
  String get medicationTestosteroneCypionateSuspension => '环戊丙酸睾酮混悬液';
  @override
  String get injection => '注射';
  @override
  String get oral => '口服';
  @override
  String get sublingual => '舌下';
  @override
  String get patch => '贴片';
  @override
  String get gel => '凝胶';
  @override
  String get implant => '植入';
  @override
  String get suppository => '栓剂';
  @override
  String get transdermalSpray => '透皮喷雾';
  @override
  String get transdermalDrops => '透皮滴剂';
  @override
  String get deliveryForm => '剂型';
  @override
  String get deliveryFormPump => '泵';
  @override
  String get deliveryFormSachet => '袋装';
  @override
  String get deliveryFormGram => '管装';
  @override
  String get unitMilligram => 'mg';
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
  String get injectionSideLeft => '左侧';
  @override
  String get injectionSideRight => '右侧';
  @override
  String get placementLeft => '左侧';
  @override
  String get placementRight => '右侧';
  @override
  String get placementLeftThigh => '左大腿';
  @override
  String get placementRightThigh => '右大腿';
  @override
  String get placementLeftArm => '左臂';
  @override
  String get placementRightArm => '右臂';
  @override
  String get placementLeftButtock => '左臀';
  @override
  String get placementRightButtock => '右臀';
  @override
  String get placementLeftAbdomen => '左腹部';
  @override
  String get placementRightAbdomen => '右腹部';
  @override
  String get applicationSites => '用药部位';
  @override
  String get applicationSitesDescription => '管理你轮换使用的部位';
  @override
  String get applicationSitesInstructions =>
      '管理你轮换使用的部位。部位会根据你的服用历史推荐。长按可重新排序。';
  @override
  String get addApplicationSite => '添加部位';
  @override
  String get customSiteLabel => '自定义部位名称';
  @override
  String get noApplicationSitesYet => '暂无部位';
  @override
  String get addSiteToGetStarted => '在下方添加一个部位开始吧。';
  @override
  String get placementSuggestionPerScheduleTitle => '按计划分别推荐';
  @override
  String get placementSuggestionPerScheduleDescription => '仅根据该计划的历史记录推荐下一个部位。';
  @override
  String get requiredField => '必填项';
  @override
  String get mustBePositiveNumber => '必须是正数';
  @override
  String get mustBeBetween1And28 => '必须在 1 到 28 之间';
  @override
  String mustBeAtMost({required Object max}) => '不能超过 ${max}';
  @override
  String get invalidTotalAmount => '总量无效';
  @override
  String get cannotExceedTotalCapacity => '不能超过总容量';
  @override
  String daysAgoCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '${count} 天前',
      );
  @override
  String inDaysCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '${count} 天后',
      );
  @override
  String scheduleFrequencyEveryNDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '每 ${count} 天',
      );
  @override
  String scheduleFrequencyOnDayEveryNMonths(
          {required num count, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '每 ${count} 个月的 ${day} 日',
      );
  @override
  String schedulesCreated({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '已创建 ${count} 个',
      );
  @override
  String onHrtForDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: 'HRT 第 ${count} 天',
      );
  @override
  String onHrtForWeeks({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: 'HRT 第 ${count} 周',
      );
  @override
  String onHrtForMonths({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: 'HRT 第 ${count} 个月',
      );
  @override
  String onHrtForYears({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: 'HRT 第 ${count} 年',
      );
  @override
  String intakesLoggedCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '已记录 ${count} 次服用',
      );
  @override
  String remaining({required num count, required Object unit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '剩余 ${count} ${unit}',
      );
  @override
  String syringeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '剩余 ${count} 支注射器',
      );
  @override
  String wipeRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '剩余 ${count} 片酒精棉片',
      );
  @override
  String needleRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '剩余 ${count} 根针头',
      );
  @override
  String glovesRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '剩余 ${count} 只手套',
      );
  @override
  String bandageRemaining({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '剩余 ${count} 张创可贴',
      );
  @override
  String administrationRouteUnitMl({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '毫升',
      );
  @override
  String administrationRouteUnitPill({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '粒',
      );
  @override
  String administrationRouteUnitPatch({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '贴',
      );
  @override
  String administrationRouteUnitPump({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '泵',
      );
  @override
  String administrationRouteUnitSachet({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '袋',
      );
  @override
  String administrationRouteUnitGram({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '克',
      );
  @override
  String administrationRouteUnitImplant({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '粒',
      );
  @override
  String administrationRouteUnitSuppository({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '枚',
      );
  @override
  String administrationRouteUnitSpray({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
        count,
        other: '喷',
      );
}

/// The flat map containing all translations for locale <zh-Hans>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhHans {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'appTitle' => 'Mona',
      'nav_home' => 'Mona',
      'nav_intakes' => '服用',
      'nav_levels' => '数值',
      'nav_supplies' => '用品',
      'takeAnIntake' => '记录服用',
      'addAnItem' => '添加物品',
      'empty_home' => '先到设置里添加一个计划吧',
      'allDone' => '全部完成！',
      'noIntakesDue' => '今天没有待服用的药物',
      'upcoming' => '即将到来',
      'asNeeded' => '按需',
      'taken' => '已服用',
      'yesterday' => '昨天',
      'tomorrow' => '明天',
      'lastTaken' => '上次服用',
      'neverTakenYet' => '尚未服用过',
      'scheduleFrequencyDaily' => '每天',
      'scheduleFrequencyDailyDescription' => '每天在固定的时间',
      'scheduleFrequencyInterval' => '间隔',
      'scheduleFrequencyIntervalDescription' => '每隔几天',
      'scheduleFrequencyWeekly' => '每周',
      'scheduleFrequencyWeeklyDescription' => '每周固定的几天',
      'scheduleFrequencyMonthly' => '每月',
      'scheduleFrequencyMonthlyDescription' => '每月同一天',
      'scheduleFrequencyAsNeeded' => '按需',
      'scheduleFrequencyAsNeededDescription' => '没有固定计划',
      'newUpdateAvailable' => '有新版本可用！',
      'goToSettings' => '前往设置',
      'settingsTitle' => '设置',
      'notifications' => '通知',
      'schedulesAndNotifications' => '计划与通知',
      'general' => '通用',
      'schedules' => '用药计划',
      'noSchedules' => '暂无计划',
      'language' => '语言',
      'languageFollowDevice' => '跟随系统语言',
      'selectLanguage' => '选择语言',
      'enableNotifications' => '启用通知',
      'enableNotificationsDescription' => '发送提醒',
      'anchorToLastIntake' => '按上次服用时间重新计算',
      'anchorToLastIntakeDescription' => '在你上次服用满一个完整间隔之后，再安排下一次',
      'notificationsDisabledTitle' => '通知已关闭',
      'clickToOpenSettings' => '点击打开设置',
      'exactRemindersDisabled' => '精确提醒时间已关闭',
      'remindersDelayed' => '提醒可能会略有延迟。点击打开设置。',
      'medicalSettings' => '医疗设置',
      'theme' => '主题',
      'themeCustomizeColors' => '自定义应用配色',
      'customThemeEnabled' => '自定义主题',
      'themeGenerate' => '生成',
      'themeVariant' => '变体',
      'themeContrast' => '对比度',
      'themeContrastStandard' => '标准',
      'themeContrastMedium' => '中等',
      'themeContrastHigh' => '高',
      'autoUpdate' => '自动更新',
      'autoUpdateDescription' => '启动应用时自动检查新版本',
      'checkForUpdates' => '检查更新',
      'checkForUpdatesDescription' => '手动检查最新版本\n这将连接互联网\n（不会发送任何数据）',
      'appVersion' => ({required Object version}) => 'Mona 版本 ${version}',
      'exportFailed' => ({required Object error}) => '导出失败：${error}',
      'importDataTitle' => '导入数据',
      'importDataSubtitle' => '从 JSON 备份恢复数据',
      'importDataOverwriteWarning' => '这会用备份覆盖你当前的全部数据。此操作无法撤销。是否继续？',
      'importConfirm' => '导入',
      'importSuccessfulTitle' => '导入成功',
      'importRestartRequired' => '请重启应用以应用已恢复的数据。',
      'closeApp' => '关闭应用',
      'importFailed' => ({required Object error}) => '导入失败：${error}',
      'updates' => '更新',
      'dataManagement' => '数据管理',
      'exportDataTitle' => '导出数据',
      'exportDataSubtitle' => '将你的数据保存为 JSON 文件',
      'units' => '单位',
      'updateNoCompatibleApk' => '未找到与你的设备兼容的更新。',
      'updateAppUpToDate' => '你的应用已是最新版本！',
      'updateCheckNetworkError' => '暂时无法检查更新。',
      'updateDialogTitle' => '有可用更新',
      'updateDialogBody' => (
              {required Object latest, required Object current}) =>
          '版本 ${latest} 已发布！（当前：${current}）\n\n已准备好与你的设备兼容的更新，可以安装。',
      'updateDownloadAndInstall' => '下载并安装',
      'updateInstallPermissionRequired' => '需要授予权限才能安装更新。',
      'updateDownloadingTitle' => '正在下载更新…',
      'updateFailedOpenInstaller' => ({required Object message}) =>
          '无法打开安装程序：${message}',
      'updateDownloadFailed' => '下载失败。请检查网络连接。',
      'notificationMedicationReminderTitle' =>
        ({required Object scheduleName}) => '该服用 ${scheduleName} 了',
      'notificationMedicationReminderBodyDate' => ({required Object date}) =>
          '计划时间：${date}',
      'notificationMedicationReminderBodyTime' => ({required Object time}) =>
          '计划时间：${time}',
      'notificationMedicationReminderBodyWeekday' =>
        ({required Object weekday}) => '计划时间：${weekday}',
      'addSchedule' => '添加用药计划',
      'addScheduleToGetStarted' => '添加一个用药计划开始使用。',
      'newSchedule' => '新建计划',
      'every' => '每',
      'days' => '天',
      'dayOfMonth' => '每月几号',
      'months' => '个月',
      'startDate' => '开始日期',
      'pickATime' => '选择时间',
      'addIntakeTime' => '添加时间',
      'editScheduleInfo' => '编辑计划信息',
      'scheduling' => '排期',
      'editSchedule' => '编辑计划',
      'deleteSchedule' => ({required Object name}) => '删除 ${name}？',
      'addNotification' => '添加通知',
      'empty_intakes' => '已服用的记录会显示在这里',
      'HrtCounter' => 'HRT 时长',
      'HrtCounterDescription' => '显示你进行 HRT 的时长，以及服用总次数',
      'hrtWidgetPlaceholder' => '打开 Mona 记录你的第一次服用',
      'hrtWidgetPreviewSample' => 'HRT 已 8 个月',
      'hrtWidgetPreviewIntakeSample' => '已记录 16 次服用',
      'startOfDay' => '每日起始时间',
      'startOfDayDescription' => ({required Object time}) =>
          '${time} 之前的记录计入前一天',
      'chooseSchedule' => '选择计划',
      'addSchedulesFirst' => '请先添加计划。',
      'editIntake' => '编辑服用记录',
      'date' => '日期',
      'amount' => '用量',
      'takenAmount' => '服用量',
      'wastedAmount' => '废弃量',
      'none' => '无',
      'supplyItem' => '所用物品',
      'chooseItem' => '选择物品',
      'noItemsToAdd' => '没有可添加的物品',
      'injectionSide' => '注射侧',
      'deleteIntake' => '删除这条服用记录？',
      'takeMedication' => ({required Object scheduleName}) =>
          '服用 ${scheduleName}',
      'takeIntake' => '记录服用',
      'intakeRecorded' => '已记录服用',
      'needleDeadSpace' => '针头死腔',
      'notes' => '备注',
      'microliters' => 'μL',
      'milliliters' => 'mL',
      'empty_levels' => '添加一次血检，或记录一次雌二醇注射，就可以开始了',
      'bloodTestsTitle' => '血液检测',
      'estradiolLevelsTitle' => '雌二醇数值',
      'empty_blood_tests' => '已完成的血检会显示在这里。点击添加按钮开始吧！',
      'addBloodTest' => '添加血检',
      'editBloodTest' => '编辑血检',
      'newBloodTest' => '新建血检',
      'deleteBloodTest' => '删除这条血检？',
      'estradiolLevelLabel' => '雌二醇数值',
      'testosteroneLevelLabel' => '睾酮数值',
      'bloodTestDateLabel' => '检测日期',
      'chartNowConcentration' => ({required Object value}) => '当前 ${value}',
      'chartBloodTestLevelTooltip' =>
        ({required Object date, required Object level}) => '${date}：${level}',
      'chartLevelTooltip' => ({required Object date, required Object level}) =>
          '${date}：${level}',
      'empty_supplies' => '暂无用品。添加一个物品开始吧。',
      'newItem' => '新建物品',
      'adminRoute' => '给药途径',
      'totalAmount' => '总量',
      'concentration' => '浓度',
      'dosePerUnitLabel' => ({required Object unit}) => '每 ${unit} 剂量',
      'editItem' => '编辑物品',
      'usedAmount' => '已用量',
      'deleteItem' => ({required Object name}) => '删除 ${name}？',
      'allItemsFilter' => '全部',
      'medicationItemsFilter' => '药物',
      'genericItems' => '耗材',
      'medicationItemType' => '药物',
      'genericItemType' => '耗材',
      'supplyType' => '类型',
      'syringe' => '注射器',
      'wipe' => '酒精棉片',
      'needle' => '针头',
      'gloves' => '手套',
      'bandage' => '创可贴',
      'add' => '添加',
      'save' => '保存',
      'cancel' => '取消',
      'next' => '下一步',
      'delete' => '删除',
      'deleteElement' => '删除这个物品？',
      'irreversibleAction' => '此操作无法撤销。',
      'name' => '名称',
      'molecule' => '成分',
      'ester' => '酯类',
      'estradiol' => '雌二醇',
      'progesterone' => '孕酮',
      'testosterone' => '睾酮',
      'nandrolone' => '诺龙',
      'dihydrotestosterone' => '双氢睾酮',
      'spironolactone' => '螺内酯',
      'cyproteroneAcetate' => '醋酸环丙孕酮',
      'leuprorelinAcetate' => '醋酸亮丙瑞林',
      'bicalutamide' => '比卡鲁胺',
      'decapeptyl' => '达菲林',
      'raloxifene' => '雷洛昔芬',
      'tamoxifen' => '他莫昔芬',
      'finasteride' => '非那雄胺',
      'dutasteride' => '度他雄胺',
      'minoxidil' => '米诺地尔',
      'pioglitazone' => '吡格列酮',
      'enanthate' => '庚酸酯',
      'valerate' => '戊酸酯',
      'cypionate' => '环戊丙酸酯',
      'undecylate' => '十一酸酯',
      'benzoate' => '苯甲酸酯',
      'cypionateSuspension' => '环戊丙酸酯混悬液',
      'medicationEstradiolEnanthate' => '庚酸雌二醇',
      'medicationEstradiolValerate' => '戊酸雌二醇',
      'medicationEstradiolCypionate' => '环戊丙酸雌二醇',
      'medicationEstradiolUndecylate' => '十一酸雌二醇',
      'medicationEstradiolBenzoate' => '苯甲酸雌二醇',
      'medicationEstradiolCypionateSuspension' => '环戊丙酸雌二醇混悬液',
      'medicationTestosteroneEnanthate' => '庚酸睾酮',
      'medicationTestosteroneValerate' => '戊酸睾酮',
      'medicationTestosteroneCypionate' => '环戊丙酸睾酮',
      'medicationTestosteroneUndecylate' => '十一酸睾酮',
      'medicationTestosteroneBenzoate' => '苯甲酸睾酮',
      'medicationTestosteroneCypionateSuspension' => '环戊丙酸睾酮混悬液',
      'injection' => '注射',
      'oral' => '口服',
      'sublingual' => '舌下',
      'patch' => '贴片',
      'gel' => '凝胶',
      'implant' => '植入',
      'suppository' => '栓剂',
      'transdermalSpray' => '透皮喷雾',
      'transdermalDrops' => '透皮滴剂',
      'deliveryForm' => '剂型',
      'deliveryFormPump' => '泵',
      'deliveryFormSachet' => '袋装',
      'deliveryFormGram' => '管装',
      'unitMilligram' => 'mg',
      'unitPgPerMl' => 'pg/mL',
      'unitPmolPerL' => 'pmol/L',
      'unitNgPerDl' => 'ng/dL',
      'unitNmolPerL' => 'nmol/L',
      'unitNgPerMl' => 'ng/mL',
      'injectionSideLeft' => '左侧',
      'injectionSideRight' => '右侧',
      'placementLeft' => '左侧',
      'placementRight' => '右侧',
      'placementLeftThigh' => '左大腿',
      'placementRightThigh' => '右大腿',
      'placementLeftArm' => '左臂',
      'placementRightArm' => '右臂',
      'placementLeftButtock' => '左臀',
      'placementRightButtock' => '右臀',
      'placementLeftAbdomen' => '左腹部',
      'placementRightAbdomen' => '右腹部',
      'applicationSites' => '用药部位',
      'applicationSitesDescription' => '管理你轮换使用的部位',
      'applicationSitesInstructions' => '管理你轮换使用的部位。部位会根据你的服用历史推荐。长按可重新排序。',
      'addApplicationSite' => '添加部位',
      'customSiteLabel' => '自定义部位名称',
      'noApplicationSitesYet' => '暂无部位',
      'addSiteToGetStarted' => '在下方添加一个部位开始吧。',
      'placementSuggestionPerScheduleTitle' => '按计划分别推荐',
      'placementSuggestionPerScheduleDescription' => '仅根据该计划的历史记录推荐下一个部位。',
      'requiredField' => '必填项',
      'mustBePositiveNumber' => '必须是正数',
      'mustBeBetween1And28' => '必须在 1 到 28 之间',
      'mustBeAtMost' => ({required Object max}) => '不能超过 ${max}',
      'invalidTotalAmount' => '总量无效',
      'cannotExceedTotalCapacity' => '不能超过总容量',
      'daysAgoCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '${count} 天前',
          ),
      'inDaysCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '${count} 天后',
          ),
      'scheduleFrequencyEveryNDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '每 ${count} 天',
          ),
      'scheduleFrequencyOnDayEveryNMonths' => (
              {required num count, required Object day}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '每 ${count} 个月的 ${day} 日',
          ),
      'schedulesCreated' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '已创建 ${count} 个',
          ),
      'onHrtForDays' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: 'HRT 第 ${count} 天',
          ),
      'onHrtForWeeks' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: 'HRT 第 ${count} 周',
          ),
      'onHrtForMonths' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: 'HRT 第 ${count} 个月',
          ),
      'onHrtForYears' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: 'HRT 第 ${count} 年',
          ),
      'intakesLoggedCount' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '已记录 ${count} 次服用',
          ),
      'remaining' => ({required num count, required Object unit}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '剩余 ${count} ${unit}',
          ),
      'syringeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '剩余 ${count} 支注射器',
          ),
      'wipeRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '剩余 ${count} 片酒精棉片',
          ),
      'needleRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '剩余 ${count} 根针头',
          ),
      'glovesRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '剩余 ${count} 只手套',
          ),
      'bandageRemaining' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '剩余 ${count} 张创可贴',
          ),
      'administrationRouteUnitMl' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '毫升',
          ),
      'administrationRouteUnitPill' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '粒',
          ),
      'administrationRouteUnitPatch' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '贴',
          ),
      'administrationRouteUnitPump' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '泵',
          ),
      'administrationRouteUnitSachet' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '袋',
          ),
      'administrationRouteUnitGram' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '克',
          ),
      'administrationRouteUnitImplant' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '粒',
          ),
      'administrationRouteUnitSuppository' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '枚',
          ),
      'administrationRouteUnitSpray' => ({required num count}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(
            count,
            other: '喷',
          ),
      _ => null,
    };
  }
}
