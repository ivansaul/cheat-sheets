import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exceptions.freezed.dart';

@freezed
sealed class AppException with _$AppException {
  const factory AppException.decodingFailure({
    Object? error,
    StackTrace? stackTrace,
  }) = DecodingFailure;

  const factory AppException.notFoundItem({
    Object? error,
    StackTrace? stackTrace,
  }) = NotFoundItem;

  // network
  const factory AppException.unauthorized({
    Object? error,
    StackTrace? stackTrace,
  }) = Unauthorized;

  const factory AppException.forbidden({
    Object? error,
    StackTrace? stackTrace,
  }) = Forbidden;

  const factory AppException.notFound({
    Object? error,
    StackTrace? stackTrace,
  }) = NotFound;

  const factory AppException.requestTimeout({
    Object? error,
    StackTrace? stackTrace,
  }) = RequestTimeout;

  const factory AppException.tooManyRequests({
    Object? error,
    StackTrace? stackTrace,
  }) = TooManyRequests;

  const factory AppException.clientError({
    Object? error,
    StackTrace? stackTrace,
  }) = ClientError;

  const factory AppException.serverError({
    Object? error,
    StackTrace? stackTrace,
  }) = ServerError;

  const factory AppException.noConnection({
    Object? error,
    StackTrace? stackTrace,
  }) = NoConnection;

  const factory AppException.badRequest({
    Object? error,
    StackTrace? stackTrace,
  }) = BadRequest;

  // unknown
  const factory AppException.unknown({
    Object? error,
    StackTrace? stackTrace,
  }) = Unknown;
}

extension AppExceptionMessage on AppException {
  String message() {
    return switch (this) {
      DecodingFailure() => "Something’s wrong with the data structure.",
      NotFoundItem() => "We couldn’t find what you're looking for.",

      // network
      Unauthorized() => "You’re not authorized. Please log in again.",
      Forbidden() => "You don't have permission to access this.",
      NotFound() => "We couldn’t find what you're looking for.",
      RequestTimeout() => "The request took too long. Try again.",
      TooManyRequests() => "You’re sending too many requests. Slow down a bit.",
      ClientError() => "Oops! There’s an issue with your request.",
      ServerError() => "Oops! Something went wrong on our end.",
      NoConnection() => "Please check your internet connection.",
      BadRequest() => "Invalid request. Please try again.",

      // unknown
      Unknown() => "Something went wrong. Please try again later.",
    };
  }
}
