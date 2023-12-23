import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/xcode.dart';
import 'package:flutter_highlight/themes/idea.dart';
import 'package:flutter_highlight/themes/nord.dart';

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
    switch (codeStyle) {
      case CodeStyleEnum.darcula:
        state = darculaTheme;
        break;
      case CodeStyleEnum.atomOneLight:
        state = atomOneLightTheme;
        break;
      case CodeStyleEnum.atomOneDark:
        state = atomOneDarkTheme;
        break;
      case CodeStyleEnum.vsCode:
        state = vsTheme;
        break;
      case CodeStyleEnum.xCode:
        state = xcodeTheme;
        break;
      case CodeStyleEnum.idea:
        state = ideaTheme;
        break;
      case CodeStyleEnum.nord:
        state = nordTheme;
        break;
      default:
        state = darculaTheme;
        break;
    }
  }
}
