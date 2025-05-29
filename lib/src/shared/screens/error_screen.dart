import 'package:cheat_sheets/src/constants/constants.dart';
import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/nullable.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:cheat_sheets/src/shared/utils/link.dart';
import 'package:cheat_sheets/src/shared/widgets/cached_svg_picture.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

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
    this.onRetry,
  });

  final Object error;
  final StackTrace? stackTrace;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return kDebugMode
        ? _DebugView(
            error: error,
            stackTrace: stackTrace,
            onRetry: onRetry,
          )
        : _UserView(
            message: _message,
            onRetry: onRetry,
          );
  }

  String get _message {
    if (error is AppException) {
      return (error as AppException).message();
    }
    return const AppException.unknown().message();
  }
}

class _UserView extends StatelessWidget {
  const _UserView({
    required this.message,
    this.onRetry,
  });

  final String message;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Oops!",
            style: context.textTheme.headlineMedium?.bold(),
          ),
          const Gap(20),
          const CachedNetworkSvgPicture(
            url: "https://files.catbox.moe/uv3d72.svg",
            height: 200,
            fit: BoxFit.fitHeight,
          ),
          const Gap(20),
          Text(
            message,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: context.textTheme.bodyMedium,
              children: [
                const TextSpan(
                  text: "Be a part of this ",
                ),
                TextSpan(
                  text: "open-source",
                  style: context.textTheme.bodyMedium?.semibold(),
                ),
                const TextSpan(
                  text: " project! Help us make this app awesome!",
                ),
              ],
            ),
          ),
          const Gap(10),
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              onRetry.toWidget(
                (retry) => GestureDetector(
                  onTap: retry,
                  child: const Chip(
                    padding: EdgeInsets.zero,
                    avatar: Icon(Icons.refresh_rounded),
                    label: Text("Try Again"),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => openLink(Links.reportIssue),
                child: const Chip(
                  padding: EdgeInsets.zero,
                  avatar: Icon(FontAwesomeIcons.github),
                  label: Text("Report an Issue"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DebugView extends StatelessWidget {
  const _DebugView({
    required this.error,
    this.stackTrace,
    this.onRetry,
  });

  final Object error;
  final StackTrace? stackTrace;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        onRetry.toWidget(
          (retry) => OutlinedButton.icon(
            onPressed: retry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text("Try Again"),
          ),
        ),
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
