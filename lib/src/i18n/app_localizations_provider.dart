import 'package:cheat_sheets/src/extensions/nullable.dart';
import 'package:cheat_sheets/src/i18n/app_localizations.dart';
import 'package:cheat_sheets/src/shared/services/storage/key_value_storage_service_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_localizations_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Translations> localizations(Ref ref) async {
  final locale = await ref.watch(localeControllerProvider.future);
  return locale.build();
}

@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  static const _appLocaleKey = 'app_locale';

  @override
  Future<AppLocale> build() async {
    final storage = ref.read(keyValueStorageServiceProvider);
    final stored = await storage.get<String>(_appLocaleKey);
    return stored.fold(
      () => AppLocaleUtils.findDeviceLocale(),
      (tag) => AppLocaleUtils.parse(tag),
    );
  }

  Future<void> setLocale(AppLocale locale) async {
    final storage = ref.read(keyValueStorageServiceProvider);
    await storage.set<String>(_appLocaleKey, locale.languageTag);
    state = AsyncValue.data(locale);
  }
}
