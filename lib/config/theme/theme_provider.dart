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
class IsDarkMode extends _$IsDarkMode {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
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
