import 'package:flutter/material.dart';
import 'package:intl/locale.dart' as intl;
import 'package:m3e_core/m3e_core.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/i18n/locale_provider.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/widgets/tappable_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

typedef LanguageNames = ({String english, String native});

const _weblateUrl = 'https://hosted.weblate.org/engage/mona/';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  static const Map<String, LanguageNames> languageNames = {
    'de': (english: 'German', native: 'Deutsch'),
    'en': (english: 'English', native: 'English'),
    'en-GB': (english: 'British English', native: 'English (UK)'),
    'es': (english: 'Spanish', native: 'Español'),
    'et': (english: 'Estonian', native: 'Eesti'),
    'fr': (english: 'French', native: 'Français'),
    'gl': (english: 'Galician', native: 'Galego'),
    'hi': (english: 'Hindi', native: 'हिन्दी'),
    'hu': (english: 'Hungarian', native: 'Magyar'),
    'id': (english: 'Indonesian', native: 'Bahasa Indonesia'),
    'is': (english: 'Icelandic', native: 'Íslenska'),
    'it': (english: 'Italian', native: 'Italiano'),
    'ko': (english: 'Korean', native: '한국어'),
    'nl': (english: 'Dutch', native: 'Nederlands'),
    'pl': (english: 'Polish', native: 'Polski'),
    'pt': (english: 'Portuguese', native: 'Português'),
    'pt-BR': (english: 'Brazilian Portuguese', native: 'Português do Brasil'),
    'ru': (english: 'Russian', native: 'Русский'),
    'sk': (english: 'Slovak', native: 'Slovenský'),
    'sq': (english: 'Albanian', native: 'Shqip'),
    'sv': (english: 'Swedish', native: 'Svenska'),
    'th': (english: 'Thai', native: 'ภาษาไทย'),
    'tok': (english: 'Toki Pona', native: 'toki pona'),
    'uk': (english: 'Ukrainian', native: 'Українська'),
    'ur': (english: 'Urdu', native: 'اردو'),
    'zh-Hans': (english: 'Simplified Chinese', native: '简体中文'),
  };

  static String? nativeNameOf(String tag) => languageNames[tag]?.native;

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final _cardKey = GlobalKey();
  double _cardHeight = 0;

  void _measureCard() {
    if (!mounted) return;
    final height = _cardKey.currentContext?.size?.height;
    if (height != null && height != _cardHeight) {
      setState(() => _cardHeight = height);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureCard());

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
      body: Stack(
        children: [
          RadioGroup<String?>(
            groupValue: savedTag,
            onChanged: onLanguageChanged,
            child: ListView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom +
                    _cardHeight +
                    borderPadding,
              ),
              children: [
                RadioListTile<String?>(
                  title: Text(t.languageFollowDevice),
                  value: null,
                ),
                for (final tag in LanguagePage.languageNames.keys)
                  _buildTile(tag),
              ],
            ),
          ),
          Positioned(
            left: borderPadding,
            right: borderPadding,
            bottom: MediaQuery.paddingOf(context).bottom,
            child: M3ESegmentedColumn(
              key: _cardKey,
              padding: EdgeInsets.zero,
              elevation: 2,
              children: [
                TappableListTile(
                  leading: const Icon(Symbols.translate_rounded),
                  title: t.missingTranslation,
                  subtitle: t.translateAppDescription,
                  onTap: () => launchUrl(
                    Uri.parse(_weblateUrl),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(String tag) {
    final names = LanguagePage.languageNames[tag];
    return RadioListTile<String?>(
      title: Text(names?.native ?? tag),
      subtitle: (names != null && tag != 'en') ? Text(names.english) : null,
      value: tag,
    );
  }
}
