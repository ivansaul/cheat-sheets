import 'package:cheat_sheets/src/shared/services/storage/key_value_storage_service.dart';
import 'package:cheat_sheets/src/shared/services/storage/key_value_storage_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:flutter_highlight/themes/idea.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/xcode.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  final String _appThemeKey = 'app_theme';

  @override
  Future<ThemeMode> build() async {
    return _loadTheme();
  }

  Future<void> setTheme(ThemeMode theme) async {
    state = AsyncValue.data(theme);
    await _storage.set<String>(_appThemeKey, theme.name);
  }

  Future<ThemeMode> _loadTheme() async {
    final stored = await _storage.get<String>(_appThemeKey);
    return switch (stored) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.light,
    };
  }

  KeyValueStorageService get _storage {
    return ref.read(keyValueStorageServiceProvider);
  }
}

enum CodeStyleEnum {
  darcula,
  atomOneLight,
  atomOneDark,
  vsCode,
  xCode,
  idea,
  nord,
}

@Riverpod(keepAlive: true)
class CodeStyle extends _$CodeStyle {
  @override
  Map<String, TextStyle> build() {
    return darculaTheme;
  }

  void toggle(CodeStyleEnum codeStyle) {
    state = switch (codeStyle) {
      CodeStyleEnum.darcula => darculaTheme,
      CodeStyleEnum.atomOneLight => atomOneLightTheme,
      CodeStyleEnum.atomOneDark => atomOneDarkTheme,
      CodeStyleEnum.vsCode => vsTheme,
      CodeStyleEnum.xCode => xcodeTheme,
      CodeStyleEnum.idea => ideaTheme,
      CodeStyleEnum.nord => nordTheme,
    };
  }
}
