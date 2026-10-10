// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'dart:convert';
import 'package:clock/clock.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/services/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../util/test_clock.dart';

class FakeFlutterLocalNotificationsPlugin
    implements FlutterLocalNotificationsPlugin {
  final List<Map<String, dynamic>> scheduled = [];
  final List<Map<String, dynamic>> shown = [];
  void Function(NotificationResponse)? capturedOnTap;
  NotificationAppLaunchDetails? launchDetails;

  @override
  Future<bool?> initialize({
    required InitializationSettings settings,
    void Function(NotificationResponse)? onDidReceiveNotificationResponse,
    void Function(NotificationResponse)?
        onDidReceiveBackgroundNotificationResponse,
  }) async {
    capturedOnTap = onDidReceiveNotificationResponse;
    return true;
  }

  @override
  Future<void> show(
      {required int id,
      String? title,
      String? body,
      NotificationDetails? notificationDetails,
      String? payload}) async {
    shown.add({'id': id, 'title': title, 'body': body, 'payload': payload});
  }

  @override
  Future<void> zonedSchedule(
      {required int id,
      String? title,
      String? body,
      required tz.TZDateTime scheduledDate,
      required NotificationDetails notificationDetails,
      required AndroidScheduleMode androidScheduleMode,
      DateTimeComponents? matchDateTimeComponents,
      String? payload}) async {
    scheduled.add({
      'id': id,
      'title': title,
      'body': body,
      'date': scheduledDate,
      'payload': payload,
      'matchDateTimeComponents': matchDateTimeComponents,
    });
  }

  @override
  Future<List<PendingNotificationRequest>> pendingNotificationRequests() async {
    return scheduled
        .map((n) => PendingNotificationRequest(
            n['id'] as int,
            n['title'] as String?,
            n['body'] as String?,
            n['payload'] as String?))
        .toList();
  }

  @override
  Future<void> cancel({required int id, String? tag}) async {
    scheduled.removeWhere((n) => n['id'] == id);
  }

  @override
  Future<void> cancelAll() async {
    scheduled.clear();
  }

  @override
  Future<void> cancelAllPendingNotifications() async {
    scheduled.clear();
  }

  @override
  Future<List<ActiveNotification>> getActiveNotifications() async {
    return [];
  }

  @override
  Future<NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() async {
    return launchDetails;
  }

  @override
  Future<void> periodicallyShow({
    required int id,
    String? title,
    String? body,
    required RepeatInterval repeatInterval,
    required NotificationDetails notificationDetails,
    required AndroidScheduleMode androidScheduleMode,
    String? payload,
  }) async {}

  @override
  Future<void> periodicallyShowWithDuration({
    required int id,
    String? title,
    String? body,
    required Duration repeatDurationInterval,
    required NotificationDetails notificationDetails,
    AndroidScheduleMode? androidScheduleMode,
    String? payload,
  }) async {}

  @override
  T? resolvePlatformSpecificImplementation<
      T extends FlutterLocalNotificationsPlatform>() {
    return null;
  }
}

void main() {
  late NotificationService service;
  late FakeFlutterLocalNotificationsPlugin fakePlugin;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Etc/UTC'));

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('flutter_timezone'),
            (call) async =>
                call.method == 'getLocalTimezone' ? 'Etc/UTC' : null);

    NotificationService.isPlatformSupported = () => true;
    fakePlugin = FakeFlutterLocalNotificationsPlugin();
    service = NotificationService(plugin: fakePlugin);
  });

  tearDownAll(() {
    NotificationService.isPlatformSupported = null;
  });

  test('scheduleNotification adds a notification', () async {
    await service.scheduleNotification(
      id: 1,
      scheduleId: 1,
      title: 'Test',
      body: 'Body',
      scheduledTime: DateTime(2026, 2, 8, 10, 30),
    );

    expect(fakePlugin.scheduled.length, 1);
    final n = fakePlugin.scheduled.first;
    expect(n['id'], 1);
    expect(n['title'], 'Test');
    expect(n['body'], 'Body');
    expect((n['date'] as tz.TZDateTime).hour, 10);
    expect((n['date'] as tz.TZDateTime).minute, 30);
  });

  test('scheduleNotification writes the schedule id into the payload',
      () async {
    // Arrange
    // Act
    await service.scheduleNotification(
      id: 1,
      scheduleId: 42,
      title: 'Test',
      body: 'Body',
      scheduledTime: DateTime(2026, 2, 8, 10, 30),
    );

    // Assert
    final payload = jsonDecode(fakePlugin.scheduled.single['payload'] as String)
        as Map<String, Object?>;
    expect(payload['scheduleId'], 42);
  });

  test('showNotification adds a shown notification', () async {
    await service.showNotification(title: 'Show', body: 'Body');
    expect(fakePlugin.shown.length, 1);
    final n = fakePlugin.shown.first;
    expect(n['title'], 'Show');
    expect(n['body'], 'Body');
  });

  test('cancelAllNotifications clears scheduled', () async {
    await service.scheduleNotification(
      id: 1,
      scheduleId: 1,
      title: 'T1',
      body: 'B1',
      scheduledTime: DateTime(2026, 2, 8, 10, 0),
    );
    await service.cancelAllNotifications();
    expect(fakePlugin.scheduled.length, 0);
  });

  test('cancelPendingNotifications removes only pending', () async {
    await service.scheduleNotification(
      id: 1,
      scheduleId: 1,
      title: 'T1',
      body: 'B1',
      scheduledTime: DateTime(2026, 2, 8, 10, 0),
    );
    await service.scheduleNotification(
      id: 2,
      scheduleId: 2,
      title: 'T2',
      body: 'B2',
      scheduledTime: DateTime(2026, 2, 9, 10, 0),
    );

    await service.cancelPendingNotifications();
    expect(fakePlugin.scheduled.length, 0);
  });

  test('triggerPastPendingNotifications shows past notifications', () async {
    await withFixedClockAsync(() async {
      final payload = jsonEncode({
        'scheduledTime':
            clock.now().subtract(Duration(days: 1)).toIso8601String()
      });
      fakePlugin.scheduled.add({
        'id': 1,
        'title': 'Past',
        'body': 'B',
        'date': clock.now(),
        'payload': payload
      });

      await service.triggerPastPendingNotifications();
      expect(fakePlugin.shown.length, 1);
      expect(fakePlugin.shown.first['title'], 'Past');
    });
  });

  test(
      'triggerPastPendingNotifications does not re-show recurring notifications',
      () async {
    await withFixedClockAsync(() async {
      // Arrange
      final payload = jsonEncode({
        'scheduledTime':
            clock.now().subtract(Duration(days: 1)).toIso8601String(),
        'isRepeating': true,
      });
      fakePlugin.scheduled.add({
        'id': 1,
        'title': 'Recurring',
        'body': 'B',
        'date': clock.now(),
        'payload': payload,
      });

      // Act
      await service.triggerPastPendingNotifications();

      // Assert
      expect(fakePlugin.shown, isEmpty);
    });
  });

  test('scheduleDailyNotification matches on time only and marks repeating',
      () async {
    // Arrange
    final firstFire = DateTime.utc(2026, 2, 8, 10, 30);

    // Act
    await service.scheduleDailyNotification(
      id: 7,
      scheduleId: 7,
      title: 'D',
      body: 'B',
      firstOccurrence: firstFire,
    );

    // Assert
    final n = fakePlugin.scheduled.single;
    final payload = jsonDecode(n['payload'] as String) as Map<String, Object?>;
    expect(n['matchDateTimeComponents'], DateTimeComponents.time);
    expect(payload['isRepeating'], isTrue);
  });

  test(
      'scheduleWeeklyNotification matches on dayOfWeek+time and marks repeating',
      () async {
    // Arrange
    final firstFire = DateTime.utc(2026, 2, 9, 8, 0); // Mon

    // Act
    await service.scheduleWeeklyNotification(
      id: 9,
      scheduleId: 9,
      title: 'W',
      body: 'B',
      firstOccurrence: firstFire,
    );

    // Assert
    final n = fakePlugin.scheduled.single;
    final payload = jsonDecode(n['payload'] as String) as Map<String, Object?>;
    expect(n['matchDateTimeComponents'], DateTimeComponents.dayOfWeekAndTime);
    expect(payload['isRepeating'], isTrue);
  });

  group('notification taps', () {
    test('initialize forwards a parsed tap to onTap', () async {
      // Arrange
      NotificationPayload? capturedPayload;
      await service.initialize(onTap: (payload) => capturedPayload = payload);

      // Act
      fakePlugin.capturedOnTap!(NotificationResponse(
        notificationResponseType: NotificationResponseType.selectedNotification,
        id: 99,
        payload: jsonEncode({
          'scheduleId': 5,
          'scheduledTime': DateTime(2026, 2, 8, 9, 0).toIso8601String(),
        }),
      ));

      // Assert
      expect(capturedPayload, (
        scheduleId: 5,
        scheduledTime: DateTime(2026, 2, 8, 9, 0),
        isRepeating: false,
        notificationId: 99,
      ));
    });

    test('getAppLaunchTap returns the tap when a notification launched the app',
        () async {
      // Arrange
      fakePlugin.launchDetails = NotificationAppLaunchDetails(
        true,
        notificationResponse: NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          id: 7,
          payload: jsonEncode({
            'scheduleId': 3,
            'scheduledTime': DateTime(2026, 2, 8, 9, 0).toIso8601String(),
            'isRepeating': true,
          }),
        ),
      );

      // Act
      final payload = await service.getAppLaunchTap();

      // Assert
      expect(payload, (
        scheduleId: 3,
        scheduledTime: DateTime(2026, 2, 8, 9, 0),
        isRepeating: true,
        notificationId: 7,
      ));
    });

    test('getAppLaunchTap returns null when no notification launched the app',
        () async {
      // Arrange
      fakePlugin.launchDetails = NotificationAppLaunchDetails(
        false,
        notificationResponse: NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          id: 7,
          payload: jsonEncode({
            'scheduleId': 3,
            'scheduledTime': DateTime(2026, 2, 8, 9, 0).toIso8601String(),
          }),
        ),
      );

      // Act
      final payload = await service.getAppLaunchTap();

      // Assert
      expect(payload, isNull);
    });
  });

  test('cancel removes the scheduled notification', () async {
    // Arrange
    await service.scheduleNotification(
      id: 1,
      scheduleId: 1,
      title: 'T',
      body: 'B',
      scheduledTime: DateTime(2026, 2, 8, 10, 0),
    );

    // Act
    await service.cancel(1);

    // Assert
    expect(fakePlugin.scheduled, isEmpty);
  });
}
