// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter/widgets.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/app_localizations_en.dart';

extension BuildContextL10n on BuildContext {
  /// Current [Locale] for this context (same as [MaterialApp.locale] when set).
  Locale get locale => Localizations.maybeLocaleOf(this) ?? const Locale('en');

  /// Current [Locale] as a string (same as [MaterialApp.locale] when set).
  String get languageTag => locale.toLanguageTag();

  /// Localized strings for the active locale.
  AppLocalizations get l10n =>
      AppLocalizations.of(this) ?? AppLocalizationsEn();
}
