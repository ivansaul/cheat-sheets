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
  String message() {
    return switch (this) {
      AppExceptionNotFound() => "We couldn’t find what you're looking for.",
      AppExceptionUnavailable() => "The requested resource is unavailable.",
      AppExceptionUnknown() => "Something went wrong. Please try again later.",
    };
  }
}
