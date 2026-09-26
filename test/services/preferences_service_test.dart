import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/date.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/placement.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../fixtures.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('PreferencesService', () {
    group('notificationsEnabled', () {
      test('should return default notifications enabled state when not set',
          () async {
        // Arrange
        final service = await PreferencesService.init();

        // Act
        final enabled = service.notificationsEnabled;

        // Assert
        expect(enabled, PreferencesService.defaultNotificationsEnabled);
      });

      test('should return saved notifications enabled state', () async {
        // Arrange
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('notifications_enabled', false);
        final service = await PreferencesService.init();

        // Act
        final enabled = service.notificationsEnabled;

        // Assert
        expect(enabled, isFalse);
      });
    });

    group('setNotificationsEnabled', () {
      test('should set notifications enabled and notify listeners', () async {
        // Arrange
        final service = await PreferencesService.init();
        var listenerNotified = false;
        service.addListener(() {
          listenerNotified = true;
        });

        // Act
        await service.setNotificationsEnabled(false);

        // Assert
        expect(service.notificationsEnabled, isFalse);
        expect(listenerNotified, isTrue);
      });
    });

    group('molecules', () {
      test('should return empty list when nothing saved', () async {
        // Arrange
        final service = await PreferencesService.init();

        // Act
        final molecules = service.customMolecules;

        // Assert
        expect(molecules, isEmpty);
      });

      test('should return saved custom molecules', () async {
        // Arrange
        final prefs = await SharedPreferences.getInstance();

        final jsonString = jsonEncode([
          {
            'name': 'nulcac2',
            'massUnit': 'mg',
          }
        ]);
        await prefs.setString('custom_molecules', jsonString);

        final service = await PreferencesService.init();

        // Act
        final molecules = service.customMolecules;

        // Assert
        expect(molecules, contains(aMolecule(name: 'nulcac2')));
      });

      test('should add new custom molecule', () async {
        // Arrange
        final service = await PreferencesService.init();

        // Act
        await service.addCustomMolecule(aMolecule(name: 'nulcac2'));

        expect(service.customMolecules, contains(aMolecule(name: 'nulcac2')));
      });

      test('should not add duplicate molecule', () async {
        // Arrange
        final service = await PreferencesService.init();
        await service.addCustomMolecule(aMolecule(name: 'nulcac2'));

        // Act
        await service.addCustomMolecule(aMolecule(name: 'Nulcac2'));

        // Assert
        expect(
            service.customMolecules
                .map((m) => m.name)
                .toList()
                .where((n) => n == 'nulcac2')
                .length,
            1);
      });

      test('should remove molecule by normalized name', () async {
        // Arrange
        final service = await PreferencesService.init();
        final molecule = aMolecule(name: 'DeleteMe');
        await service.addCustomMolecule(molecule);

        // Act
        await service.removeCustomMolecule('deleteme');

        // Assert
        expect(service.customMolecules, isEmpty);
      });

      test('should merge built-in and custom without duplicates', () async {
        // Arrange
        final service = await PreferencesService.init();

        final custom = aMolecule(name: 'bicanul');
        final customDuplicate = aMolecule(name: 'Estradiol');
        // built-in is named 'estradiol'

        await service.addCustomMolecule(custom);
        await service.addCustomMolecule(customDuplicate);

        // Act
        final all = service.allMolecules;

        // Assert
        expect(
            all,
            unorderedEquals([
              ...KnownMolecules.all,
              custom,
            ]));
      });
    });

    group('savedLanguageTag', () {
      test('returns null when unset or empty', () async {
        // Arrange
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language_tag', '');

        // Act
        final service = await PreferencesService.init();

        // Assert
        expect(service.savedLanguageTag, isNull);
      });

      test('returns stored tag', () async {
        // Arrange
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language_tag', 'fr');

        // Act
        final service = await PreferencesService.init();

        // Assert
        expect(service.savedLanguageTag, 'fr');
      });

      test('setSavedLanguageTag clears when null', () async {
        // Arrange
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language_tag', 'de');
        final service = await PreferencesService.init();

        // Act
        await service.setSavedLanguageTag(null);

        // Assert
        expect(service.savedLanguageTag, isNull);
      });
    });

    group('placementsList', () {
      test('defaults to left and right when nothing saved', () async {
        // Arrange
        final service = await PreferencesService.init();

        // Act
        final placements = service.placementsList;

        // Assert
        expect(placements, const [
          PresetPlacement(PlacementPreset.left),
          PresetPlacement(PlacementPreset.right),
        ]);
      });

      test('returns saved sites (preset + custom)', () async {
        // Arrange
        final placements = [
          const PresetPlacement(PlacementPreset.leftThigh),
          const CustomPlacement('belly'),
        ];
        final service = await PreferencesService.init();
        await service.setPlacementsList(placements);

        // Act
        final reloaded = (await PreferencesService.init()).placementsList;

        // Assert
        expect(reloaded, placements);
      });

      test('notifies listeners synchronously, before the write completes',
          () async {
        // Arrange
        final service = await PreferencesService.init();
        var notified = false;
        service.addListener(() => notified = true);

        // Act
        final write =
            service.setPlacementsList(const [CustomPlacement('belly')]);

        // Assert
        expect(notified, isTrue);
        await write;
      });
    });

    group('scheduleOrder', () {
      test('defaults to empty when nothing saved', () async {
        // Arrange
        final service = await PreferencesService.init();

        // Act
        final order = service.scheduleOrder;

        // Assert
        expect(order, isEmpty);
      });

      test('round-trips the saved order', () async {
        // Arrange
        final service = await PreferencesService.init();
        await service.setScheduleOrder([3, 1, 2]);

        // Act
        final reloaded = (await PreferencesService.init()).scheduleOrder;

        // Assert
        expect(reloaded, [3, 1, 2]);
      });

      test('notifies listeners synchronously, before the write completes',
          () async {
        // Arrange
        final service = await PreferencesService.init();
        var notified = false;
        service.addListener(() => notified = true);

        // Act
        final write = service.setScheduleOrder([2, 1]);

        // Assert
        expect(notified, isTrue);
        await write;
      });
    });

    group('placementSuggestionPerSchedule', () {
      test('defaults to false', () async {
        // Arrange
        final service = await PreferencesService.init();

        // Act
        final perMedicine = service.placementSuggestionPerSchedule;

        // Assert
        expect(perMedicine, isFalse);
      });

      test('returns the saved value', () async {
        // Arrange
        final service = await PreferencesService.init();
        await service.setPlacementSuggestionPerSchedule(true);

        // Act
        final reloaded =
            (await PreferencesService.init()).placementSuggestionPerSchedule;

        // Assert
        expect(reloaded, isTrue);
      });
    });

    group('hrtCounterEnabled', () {
      test('defaults to true when not set', () async {
        // Arrange
        final service = await PreferencesService.init();

        // Act
        final enabled = service.hrtCounterEnabled;

        // Assert
        expect(enabled, PreferencesService.defaultHrtCounterEnabled);
      });

      test('round-trips the saved value and notifies listeners', () async {
        // Arrange
        final service = await PreferencesService.init();
        var listenerNotified = false;
        service.addListener(() => listenerNotified = true);

        // Act
        await service.setHrtCounterEnabled(false);

        // Assert
        expect([service.hrtCounterEnabled, listenerNotified], [false, true]);
      });
    });

    group('logicalDayStart', () {
      tearDown(() => logicalDayStartMinutes = 240);

      test('defaults to 4:00am when not set', () async {
        // Arrange
        final service = await PreferencesService.init();

        // Act
        final start = service.logicalDayStart;

        // Assert
        expect(start, const TimeOfDay(hour: 4, minute: 0));
      });

      test('round-trips the saved value and notifies listeners', () async {
        // Arrange
        final service = await PreferencesService.init();
        var listenerNotified = false;
        service.addListener(() => listenerNotified = true);

        // Act
        await service.setLogicalDayStart(const TimeOfDay(hour: 6, minute: 30));

        // Assert
        expect(
          [service.logicalDayStart, listenerNotified],
          [const TimeOfDay(hour: 6, minute: 30), true],
        );
      });

      test('setLogicalDayStart syncs the Date global', () async {
        // Arrange
        final service = await PreferencesService.init();

        // Act
        await service.setLogicalDayStart(const TimeOfDay(hour: 6, minute: 30));

        // Assert
        expect(logicalDayStartMinutes, 390);
      });
    });
  });
}
