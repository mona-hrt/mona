// Patrol E2E tests for the Medication Schedules feature.
//
// These run on a real Android device/emulator (Patrol does not support Linux
// desktop), driving the actual app launched via `main()`. Run with:
//   patrol test --target integration_test/schedules_test.dart --flavor standalone
// See integration_test/README.md for the full setup and CI notes.
//
// Finder strategy: the schedules UI defines no widget Keys, so we target
// fields by their decoration label (`$(TextField).containing('Name')`) rather
// than by index — pushed routes stay mounted underneath, so index-based
// TextField finders would be ambiguous across the navigation stack.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/main.dart' as app;
import 'package:patrol/patrol.dart';

// English l10n strings exercised by these tests (see lib/l10n/app_en.arb).
const _emptyState = 'Add a schedule to get started.';
const _schedulesTile = 'Schedules';
const _nameLabel = 'Name';
const _amountLabel = 'Amount';
const _moleculeEstradiol = 'Estradiol';
const _routeOral = 'Oral';
const _next = 'Next';
const _save = 'Save';
const _intervalToggle = 'Interval';
const _everyLabel = 'Every';
const _addNotification = 'Add a notification';
const _editScheduleInfo = 'Edit schedule info';
const _delete = 'Delete';

void main() {
  patrolTest('shows empty state when there are no schedules', ($) async {
    await _launchApp($);
    await _openSchedules($);

    await $(_emptyState).waitUntilVisible();
    expect($(_emptyState), findsOneWidget);
  });

  patrolTest('creates an interval schedule', ($) async {
    await _launchApp($);
    await _openSchedules($);

    await $(Icons.add).tap(); // FAB: "Add a schedule"
    await _fillMainInfoAndNext($, name: 'Interval Estradiol');

    await $(_intervalToggle).tap();
    await $(TextField).containing(_everyLabel).enterText('3');
    await $(_save).tap();

    // provider.add() is fire-and-forget; wait for the list to rebuild.
    await $('Interval Estradiol').waitUntilVisible();
    expect($('Interval Estradiol'), findsOneWidget);
  });

  patrolTest('creates a daily schedule', ($) async {
    await _launchApp($);
    await _openSchedules($);

    await $(Icons.add).tap();
    await _fillMainInfoAndNext($, name: 'Daily Estradiol');

    // "Every day" is the default type. Add one intake time via the time
    // picker (a daily schedule requires at least one time to be valid).
    await $(_addNotification).tap();
    await $('OK').tap(); // accept the default time
    await $(_save).tap();

    await $('Daily Estradiol').waitUntilVisible();
    expect($('Daily Estradiol'), findsOneWidget);
  });

  patrolTest('edits a schedule name', ($) async {
    await _launchApp($);
    await _openSchedules($);
    await _createIntervalSchedule($, name: 'Old Name');

    await $(ListTile).containing('Old Name').tap(); // -> EditSchedulePage
    await $(_editScheduleInfo).tap(); // -> EditScheduleMainInfoPage
    await $(TextField).containing(_nameLabel).enterText('New Name');
    await $(_save).tap(); // pops back to EditSchedulePage

    await $.tester.pageBack(); // back to the schedules list
    await $.pumpAndSettle();

    await $('New Name').waitUntilVisible();
    expect($('New Name'), findsOneWidget);
    expect($('Old Name'), findsNothing);
  });

  patrolTest('deletes a schedule with confirmation', ($) async {
    await _launchApp($);
    await _openSchedules($);
    await _createIntervalSchedule($, name: 'To Delete');

    await $(ListTile).containing('To Delete').tap();
    await $(_editScheduleInfo).tap();

    await $(_delete).tap(); // form's Delete button -> confirmation dialog
    await $(AlertDialog).$(_delete).tap(); // confirm in the dialog

    await $.tester.pageBack(); // EditSchedulePage -> schedules list
    await $.pumpAndSettle();

    await $(_emptyState).waitUntilVisible();
    expect($('To Delete'), findsNothing);
    expect($(_emptyState), findsOneWidget);
  });
}

/// Launches the real app and waits for the home screen to be interactive.
Future<void> _launchApp(PatrolIntegrationTester $) async {
  app.main();
  await $.pumpAndSettle();
  // main() initialises asynchronously (timezone data, preferences) before
  // runApp; poll until the home AppBar's settings button is on screen.
  await $(Icons.settings).waitUntilVisible();
}

/// Home -> Settings -> Schedules.
Future<void> _openSchedules(PatrolIntegrationTester $) async {
  await $(Icons.settings).tap();
  await $(_schedulesTile).scrollTo().tap();
}

/// Fills the first create-schedule page (name, molecule, route, amount) with a
/// combination that does NOT surface the conditional Ester field
/// (Estradiol + Oral), then taps "Next".
Future<void> _fillMainInfoAndNext(
  PatrolIntegrationTester $, {
  required String name,
  String dose = '2',
}) async {
  await $(TextField).containing(_nameLabel).enterText(name);

  await $(DropdownButtonFormField<Molecule>).tap();
  await $(_moleculeEstradiol).tap();

  await $(DropdownButtonFormField<AdministrationRoute>).tap();
  await $(_routeOral).tap();

  await $(TextField).containing(_amountLabel).enterText(dose);

  await $(_next).tap();
}

/// End-to-end helper: creates a minimal interval schedule and returns to the
/// schedules list (used by the edit/delete tests as a precondition).
Future<void> _createIntervalSchedule(
  PatrolIntegrationTester $, {
  required String name,
}) async {
  await $(Icons.add).tap();
  await _fillMainInfoAndNext($, name: name);
  await $(_intervalToggle).tap();
  await $(TextField).containing(_everyLabel).enterText('3');
  await $(_save).tap();
  await $(ListTile).containing(name).waitUntilVisible();
}
