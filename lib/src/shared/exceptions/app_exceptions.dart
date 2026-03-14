import 'package:cheat_sheets/src/i18n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exceptions.freezed.dart';

@freezed
sealed class AppException with _$AppException {
  const AppException._();

  const factory AppException.notFound({
    Object? error,
    StackTrace? stackTrace,
  }) = AppExceptionNotFound;

  const factory AppException.unavailable({
    Object? error,
    StackTrace? stackTrace,
  }) = AppExceptionUnavailable;

  const factory AppException.unknown({
    Object? error,
    StackTrace? stackTrace,
  }) = AppExceptionUnknown;
}

extension AppExceptionMessage on AppException {
  String message(Translations loc) {
    return switch (this) {
      AppExceptionNotFound() => loc.errors.messages.notFound,
      AppExceptionUnavailable() => loc.errors.messages.unavailable,
      AppExceptionUnknown() => loc.errors.messages.unknown,
    };
  }
}
