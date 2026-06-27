import 'package:flutter/material.dart';
import 'package:intl/locale.dart' as intl;
import 'package:mona/i18n/locale_provider.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  static final languages = [
    ('en', 'English', 'English'),
    ('fr', 'French', 'Français'),
    ('es', 'Spanish', 'Español'),
    ('de', 'German', 'Deutsch'),
    ('pt', 'Portuguese', 'Português'),
    ('pt-BR', 'Brazilian Portuguese', 'Português do Brasil'),
    ('sk', 'Slovak', 'Slovenský'),
    ('uk', 'Ukrainian', 'Українська'),
    ('ru', 'Russian', 'Русский'),
    ('th', 'Thai', 'ภาษาไทย')
  ];

  @override
  Widget build(BuildContext context) {
    final preferencesService = context.watch<PreferencesService>();
    final localeProvider = context.read<LocaleProvider>();
    final savedTag = preferencesService.savedLanguageTag;

    void onLanguageChanged(String? value) {
      if (value == null) {
        localeProvider.setFollowSystemLocale();
        return;
      }

      final parsed = intl.Locale.tryParse(value);
      if (parsed == null) return;

      localeProvider.setLocale(Locale.fromSubtags(
        languageCode: parsed.languageCode,
        scriptCode: parsed.scriptCode,
        countryCode: parsed.countryCode,
      ));
    }

    return Scaffold(
      appBar: AppBar(title: Text(t.language)),
      body: RadioGroup<String?>(
        groupValue: savedTag,
        onChanged: onLanguageChanged,
        child: ListView(
          children: [
            RadioListTile<String?>(
              title: Text(t.languageFollowDevice),
              value: null,
            ),
            for (final (code, englishName, nativeName) in languages)
              RadioListTile<String?>(
                title: Text(nativeName),
                subtitle: code != 'en' ? Text(englishName) : null,
                value: code,
              ),
          ],
        ),
      ),
    );
  }
}
