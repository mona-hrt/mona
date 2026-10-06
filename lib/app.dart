// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Robin Hirst
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:clock/clock.dart';
import 'package:dynamic_system_colors/dynamic_system_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mona/controllers/notification_planner.dart';
import 'package:mona/controllers/notification_scheduler.dart';
import 'package:mona/controllers/slot_finder.dart';
import 'package:mona/controllers/slots_builder.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/i18n/build_context_extensions.dart';
import 'package:mona/i18n/locale_provider.dart';
import 'package:mona/i18n/tok_localizations.dart';
import 'package:mona/services/home_widget_service.dart';
import 'package:mona/services/notification_service.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/theme/app_theme_controller.dart';
import 'package:mona/theme/material_ui_theme.dart';
import 'package:mona/ui/views/home/take_medication_page.dart';
import 'package:provider/provider.dart';
import 'ui/views/main_page.dart';

const bool _forceDefaultColors = bool.fromEnvironment(
    'SCREENSHOT_DEFAULT_COLORS'); // avoid dynamic colors when generating store screenshots

class MonaApp extends StatefulWidget {
  const MonaApp({super.key});

  @override
  State<MonaApp> createState() => _MonaAppState();
}

class _MonaAppState extends State<MonaApp> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String? _lastTimeZone;
  NotificationPayload? _pendingLaunchTap;
  late MedicationScheduleProvider _medicationScheduleProvider;
  late MedicationIntakeProvider _medicationIntakeProvider;
  late PreferencesService _preferencesService;
  late LocaleProvider _localeProvider;
  late NotificationScheduler _notificationScheduler;
  final HomeWidgetService _homeWidgetService = HomeWidgetService();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lastTimeZone = clock.now().timeZoneOffset.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NotificationService().initialize(onTap: _handleNotificationTap);
      if (!mounted) return;
      _medicationScheduleProvider = context.read<MedicationScheduleProvider>();
      _medicationIntakeProvider = context.read<MedicationIntakeProvider>();
      _preferencesService = context.read<PreferencesService>();
      _localeProvider = context.read<LocaleProvider>();
      _notificationScheduler = NotificationScheduler(
        NotificationPlanner(
            _medicationIntakeProvider, _medicationScheduleProvider),
        _preferencesService,
      );
      _initialized = true;

      _medicationScheduleProvider.addListener(_regenerateNotifications);
      _medicationIntakeProvider.addListener(_regenerateNotifications);
      _preferencesService.addListener(_regenerateNotifications);
      _regenerateNotifications();

      _medicationIntakeProvider.addListener(_regenerateHomeWidget);
      _localeProvider.addListener(_regenerateHomeWidget);
      _regenerateHomeWidget();

      _medicationScheduleProvider.addListener(_routeLaunchTap);
      _medicationIntakeProvider.addListener(_routeLaunchTap);
      _pendingLaunchTap = await NotificationService().getAppLaunchTap();
      _routeLaunchTap();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_initialized) {
      _medicationScheduleProvider.removeListener(_regenerateNotifications);
      _medicationIntakeProvider.removeListener(_regenerateNotifications);
      _preferencesService.removeListener(_regenerateNotifications);
      _medicationIntakeProvider.removeListener(_regenerateHomeWidget);
      _localeProvider.removeListener(_regenerateHomeWidget);
      _medicationScheduleProvider.removeListener(_routeLaunchTap);
      _medicationIntakeProvider.removeListener(_routeLaunchTap);
    }
    super.dispose();
  }

  void _regenerateNotifications() {
    if (!_initialized || !mounted) return;

    final locale = context.read<LocaleProvider>().locale;
    _notificationScheduler.regenerateAll(locale.intlLanguageTag);
  }

  void _regenerateHomeWidget() {
    if (!_initialized || !mounted) return;

    _homeWidgetService.sync(
      _medicationIntakeProvider,
      _localeProvider,
    );
  }

  void _routeLaunchTap() {
    final tap = _pendingLaunchTap;
    if (tap == null || !_initialized || !mounted) return;
    if (_medicationScheduleProvider.isLoading ||
        _medicationIntakeProvider.isLoading) {
      return;
    }

    _pendingLaunchTap = null;
    _handleNotificationTap(tap);
  }

  void _handleNotificationTap(NotificationPayload payload) {
    if (!_initialized || !mounted) return;

    final slots = SlotsBuilder(
      _medicationIntakeProvider,
      _medicationScheduleProvider,
    ).intakeSlots();
    final target = findSlot(payload.scheduleId, payload.scheduledTime, slots);

    if (target != null) {
      _navigatorKey.currentState?.push(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (_) =>
              TakeMedicationPage(target.schedule, scheduledTime: target.time),
        ),
      );
    }

    final notificationId = payload.notificationId;
    if (notificationId != null) NotificationService().cancel(notificationId);
    if (payload.isRepeating) _regenerateNotifications();
  }

  void _checkTimezoneChange() {
    final currentTimezone = clock.now().timeZoneOffset.toString();
    if (_lastTimeZone != currentTimezone) {
      _lastTimeZone = currentTimezone;
      _regenerateNotifications();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkTimezoneChange();
    } else if (state == AppLifecycleState.paused) {
      _regenerateHomeWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppThemeProvider>();
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final themes = context.read<AppThemeProvider>().buildThemeData(
              systemLight: _forceDefaultColors ? null : lightDynamic,
              systemDark: _forceDefaultColors ? null : darkDynamic,
            );
        return MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Mona',
          locale: context.watch<LocaleProvider>().locale,
          supportedLocales: context.watch<LocaleProvider>().supportedLocales,
          localizationsDelegates: const [
            TokMaterialLocalizationsDelegate(),
            TokCupertinoLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: themes.theme,
          darkTheme: themes.darkTheme,
          themeMode: ThemeMode.system,
          builder: (context, child) => withMaterialUiTheme(
            scheme: Theme.of(context).colorScheme,
            child: child ?? const SizedBox.shrink(),
          ),
          home: const MainPage(),
        );
      },
    );
  }
}
