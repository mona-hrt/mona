import 'package:flutter/material.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/theme/custom_theme_schemes.dart';
import 'package:mona/theme/default_color_schemes.dart';

class AppThemeProvider extends ChangeNotifier {
  AppThemeProvider(this._prefs) {
    _prefs.addListener(_onPrefsChanged);
  }

  final PreferencesService _prefs;

  void _onPrefsChanged() => notifyListeners();

  @override
  void dispose() {
    _prefs.removeListener(_onPrefsChanged);
    super.dispose();
  }

  static const _useMaterial3 = true;

  ({ThemeData theme, ThemeData darkTheme}) buildThemeData({
    required ColorScheme? systemLight,
    required ColorScheme? systemDark,
  }) {
    if (_prefs.customThemeEnabled) {
      final schemes = CustomThemeSchemes.fromSettings(_prefs.customTheme);
      return (
        theme: _themeFor(schemes.light),
        darkTheme: _themeFor(schemes.dark)
      );
    }

    return (
      theme: _themeFor(systemLight ?? _fallbackScheme(Brightness.light)),
      darkTheme: _themeFor(systemDark ?? _fallbackScheme(Brightness.dark)),
    );
  }

  ThemeData _themeFor(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: _useMaterial3,
      colorScheme: scheme,
      iconTheme: const IconThemeData(weight: 600),
      splashFactory: InkSparkle.splashFactory, // match m3e_core widgets ink
    );
  }

  ColorScheme _fallbackScheme(Brightness brightness) {
    return brightness == Brightness.dark
        ? DefaultColorSchemes.dark
        : DefaultColorSchemes.light;
  }
}
