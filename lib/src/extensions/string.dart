import 'dart:ui';

extension StringExtensions on String {
  Color hexColorToColor() => Color(
        int.parse(
          removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );

  /// Capitalize the first letter in a string.
  /// ```dart
  /// 'hello world'.capitalize() // 'Hello world'
  /// ```
  String capitalize() =>
      length > 1 ? this[0].toUpperCase() + substring(1) : toUpperCase();
}

extension RemoveAll on String {
  String removeAll(Iterable<String> values) => values.fold(
        this,
        (
          String result,
          String pattern,
        ) =>
            result.replaceAll(pattern, ''),
      );
}
