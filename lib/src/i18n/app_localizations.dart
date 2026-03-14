import 'package:cheat_sheets/src/i18n/translations.g.dart';

export 'package:flutter_localizations/flutter_localizations.dart';

export 'translations.g.dart';

part 'english_locales.slang.dart';

extension AppLocaleExtension on AppLocale {
  /// Get the english name of the locale.
  ///
  /// For Example:
  /// ```dart
  /// AppLocale.es.englishName; // → "Spanish"
  /// AppLocale.esPe.englishName; // → "Spanish (Peru)"
  /// ```
  String get englishName {
    return _englishLocales[languageTag] ?? languageTag;
  }
}
