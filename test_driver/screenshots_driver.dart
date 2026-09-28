import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

const _screens = <(String, String?)>[
  ('01_home', null),
  ('02_intakes', 'navTabIntakes'),
  ('03_levels', 'navTabLevels'),
  ('04_supplies', 'navTabSupplies'),
];

Future<void> _adb(String serial, List<String> args) async {
  final result = await Process.run(
    'adb',
    [
      if (serial.isNotEmpty) ...['-s', serial],
      ...args
    ],
  );
  if (result.exitCode != 0) {
    throw Exception('adb ${args.join(' ')} failed: ${result.stderr}');
  }
}

Future<void> main() async {
  final outDir = Platform.environment['SCREENSHOT_OUT'] ?? 'build/screenshots';
  final iosUdid = Platform.environment['SCREENSHOT_IOS_UDID'] ?? '';
  final androidSerial = Platform.environment['SCREENSHOT_ANDROID_SERIAL'] ?? '';

  final driver = await FlutterDriver.connect();

  for (var attempt = 0;; attempt++) {
    try {
      await driver.waitFor(
        find.byValueKey('navTabIntakes'),
        timeout: const Duration(seconds: 2),
      );
      break;
    } catch (_) {
      if (attempt >= 60) rethrow;
      await Future<void>.delayed(const Duration(seconds: 1));
    }
  }

  if (iosUdid.isNotEmpty) {
    final result = await Process.run('xcrun', [
      'simctl', 'status_bar', iosUdid, 'override', //
      '--time', '14:28',
      '--dataNetwork', 'wifi', '--wifiMode', 'active', '--wifiBars', '3',
      '--cellularMode', 'active', '--cellularBars', '4',
      '--batteryState', 'discharging', '--batteryLevel', '100',
    ]);
    if (result.exitCode != 0) {
      throw Exception('simctl status_bar override failed: ${result.stderr}');
    }
  } else {
    const demo = [
      'shell',
      'am',
      'broadcast',
      '-a',
      'com.android.systemui.demo'
    ];
    await _adb(androidSerial,
        ['shell', 'settings', 'put', 'system', 'time_12_24', '24']);
    await _adb(androidSerial,
        ['shell', 'settings', 'put', 'global', 'sysui_demo_allowed', '1']);
    await _adb(androidSerial, [...demo, '-e', 'command', 'enter']);
    await _adb(androidSerial,
        [...demo, '-e', 'command', 'clock', '-e', 'hhmm', '1428']);
  }

  Future<void> capture(String name) async {
    await driver.waitUntilNoTransientCallbacks();
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final path = '$outDir/$name.png';
    if (iosUdid.isNotEmpty) {
      final result = await Process.run(
        'xcrun',
        ['simctl', 'io', iosUdid, 'screenshot', path],
      );
      if (result.exitCode != 0) {
        throw Exception('simctl screenshot failed: ${result.stderr}');
      }
    } else {
      final result = await Process.run(
        'adb',
        [
          if (androidSerial.isNotEmpty) ...['-s', androidSerial],
          'exec-out',
          'screencap',
          '-p',
        ],
        stdoutEncoding: null,
      );
      if (result.exitCode != 0) {
        throw Exception('adb screencap failed: ${result.stderr}');
      }
      await File(path).writeAsBytes(result.stdout as List<int>);
    }
  }

  for (final (name, tapKey) in _screens) {
    if (tapKey != null) {
      await driver.tap(find.byValueKey(tapKey));
    }
    await capture(name);
  }

  await driver.close();
}
