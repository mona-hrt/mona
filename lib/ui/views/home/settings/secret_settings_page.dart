// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/widgets/switch_tile.dart';
import 'package:provider/provider.dart';

class SecretSettingsPage extends StatelessWidget {
  const SecretSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesService = context.watch<PreferencesService>();

    return Scaffold(
      appBar: AppBar(title: Text(t.secretSettings)),
      body: ListView(
        padding: pagePadding +
            EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
        children: [
          M3ESegmentedColumn(
            padding: EdgeInsets.zero,
            children: [
              SwitchTile(
                title: t.slimeMode,
                value: preferencesService.slimeModeEnabled,
                onChanged: (value) =>
                    preferencesService.setSlimeModeEnabled(value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
