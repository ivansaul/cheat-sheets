import 'package:flutter/material.dart';

extension NullableExtension<T> on T? {
  R fold<R>(R Function() onNone, R Function(T r) onSome) {
    return this == null ? onNone() : onSome(this as T);
  }
}

extension WidgetX<T> on T? {
  Widget toWidget(Widget Function(T r) onSome) {
    return fold(
      () => const SizedBox.shrink(),
      onSome,
    );
  }
}
