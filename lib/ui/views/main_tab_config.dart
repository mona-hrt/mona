// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter/material.dart';

class MainTabConfig {
  final String title;
  final Widget page;
  final IconData icon;
  final List<Widget> Function(BuildContext context)? buildActions;
  final FloatingActionButton? Function(BuildContext context)? buildFab;
  final Color? backgroundColor;

  /// Key applied to the [BottomNavigationBarItem] corresponding to this tab
  /// so e2e tests can target it without depending on its (localized) label.
  final Key? navKey;

  const MainTabConfig({
    required this.title,
    required this.page,
    required this.icon,
    this.buildActions,
    this.buildFab,
    this.navKey,
    this.backgroundColor,
  });
}
