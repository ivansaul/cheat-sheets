import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  Debouncer({
    required int milliseconds,
  }) : _milliseconds = milliseconds;

  final int _milliseconds;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: _milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
