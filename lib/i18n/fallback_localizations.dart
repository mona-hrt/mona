// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Flutter lacks some or all built-in Material/Cupertino/Widgets localizations
// for these
const Map<String, Locale> _fallbackLocales = {
  'ckb': Locale('fa'),
  'kmr': Locale('en'),
  'lrc': Locale('fa'),
  'prs': Locale('fa'),
  'ps': Locale('fa'),
  'tg': Locale('ru'),
  'tok': Locale('en'),
};

bool _hasFallback(Locale locale, LocalizationsDelegate<dynamic> builtIn) =>
    _fallbackLocales.containsKey(locale.languageCode) &&
    !builtIn.isSupported(locale);

Locale _fallbackOf(Locale locale) => _fallbackLocales[locale.languageCode]!;

class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      _hasFallback(locale, GlobalMaterialLocalizations.delegate);

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(_fallbackOf(locale));

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      _hasFallback(locale, GlobalCupertinoLocalizations.delegate);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(_fallbackOf(locale));

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}

class FallbackWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const FallbackWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      _hasFallback(locale, GlobalWidgetsLocalizations.delegate);

  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      GlobalWidgetsLocalizations.delegate.load(_fallbackOf(locale));

  @override
  bool shouldReload(FallbackWidgetsLocalizationsDelegate old) => false;
}
