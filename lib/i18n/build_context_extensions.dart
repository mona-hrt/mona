import 'package:flutter/widgets.dart';

extension BuildContextL10n on BuildContext {
  /// Current [Locale] for this context (same as [MaterialApp.locale] when set).
  Locale get locale => Localizations.maybeLocaleOf(this) ?? const Locale('en');

  /// Current [Locale] as a string (same as [MaterialApp.locale] when set).
  String get languageTag => locale.toLanguageTag();
}
