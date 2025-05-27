import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.error,
    this.stackTrace,
  });

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return kDebugMode
        ? _DebugView(
            error: error,
            stackTrace: stackTrace,
          )
        : Center(
            child: Text(_message),
          );
  }

  String get _message {
    if (error is AppException) {
      return (error as AppException).message();
    }
    return const AppException.unknown().message();
  }
}

class _DebugView extends StatelessWidget {
  const _DebugView({
    required this.error,
    this.stackTrace,
  });

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(_message),
        if (_error != null) Text("\nError:\n$_error"),
        if (_stackTrace != null) Text("\nStack Trace:\n$_stackTrace"),
        if (stackTrace != null)
          Text("\nLast Stack Trace:\n${stackTrace.toString()}"),
      ],
    );
  }

  AppException? get _appException {
    return error is AppException ? error as AppException : null;
  }

  String get _message {
    return _appException?.message() ?? error.toString();
  }

  String? get _error {
    return _appException?.error.toString();
  }

  String? get _stackTrace {
    return _appException?.stackTrace?.toString();
  }
}
