//   _______
//  |_     _|.----.---.-.-----.-----.
//    |   |  |   _|  _  |     |__ --|
//    |___|  |__| |___._|__|__|_____|
//
//        _____ _______ ___ ___
//       |     \_     _|   |   |
//       |  --  ||   |_ \     /
//       |_____/_______| |___|
//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mona/data/providers/blood_test_provider.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/medication_schedule_provider.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import 'package:mona/l10n/locale_provider.dart';
import 'package:mona/services/db/app_database.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/services/sync_service.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tzdata.initializeTimeZones();

  final preferencesService = await PreferencesService.init();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: preferencesService),
        ChangeNotifierProvider(
            create: (_) => LocaleProvider(preferencesService)),
        ChangeNotifierProvider(
            create: (_) =>
                SyncService(preferencesService, AppDatabase.getInstance())),
        ChangeNotifierProxyProvider<SyncService, SupplyItemProvider>(
          create: (context) => SupplyItemProvider(
              syncService: Provider.of<SyncService>(context, listen: false)),
          update: (_, __, provider) => provider!,
        ),
        ChangeNotifierProxyProvider<SyncService, MedicationIntakeProvider>(
          create: (context) => MedicationIntakeProvider(
              syncService: Provider.of<SyncService>(context, listen: false)),
          update: (_, __, provider) => provider!,
        ),
        ChangeNotifierProxyProvider<SyncService, MedicationScheduleProvider>(
          create: (context) => MedicationScheduleProvider(
              syncService: Provider.of<SyncService>(context, listen: false)),
          update: (_, __, provider) => provider!,
        ),
        ChangeNotifierProxyProvider<SyncService, BloodTestProvider>(
          create: (context) => BloodTestProvider(
              syncService: Provider.of<SyncService>(context, listen: false)),
          update: (_, __, provider) => provider!,
        ),
      ],
      child: const MonaApp(),
    ),
  );
}

//  /|、 meow
//（ﾟ､ ｡ ７
//  l  ~ヽ
//  じしf_,)ノ
