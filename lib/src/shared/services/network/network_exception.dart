import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

/// Represents network exceptions that can occur during
/// network operations.
@freezed
sealed class NetworkException with _$NetworkException {
  const NetworkException._();

  /// Authentication is required or no longer valid.
  const factory NetworkException.unauthorized({
    Object? error,
    StackTrace? stackTrace,
  }) = NetworkExceptionUnauthorized;

  /// The operation is not allowed for the current context.
  const factory NetworkException.forbidden({
    Object? error,
    StackTrace? stackTrace,
  }) = NetworkExceptionForbidden;

  /// The requested resource could not be found or is unavailable.
  const factory NetworkException.notFound({
    Object? error,
    StackTrace? stackTrace,
  }) = NetworkExceptionNotFound;

  /// The operation did not complete within the expected time.
  const factory NetworkException.timeout({
    Object? error,
    StackTrace? stackTrace,
  }) = NetworkExceptionTimeout;

  /// Requests are being limited by the remote system.
  const factory NetworkException.rateLimited({
    Object? error,
    StackTrace? stackTrace,
  }) = NetworkExceptionRateLimited;

  /// No connection to the remote system could be established.
  const factory NetworkException.noConnection({
    Object? error,
    StackTrace? stackTrace,
  }) = NetworkExceptionNoConnection;

  /// The request is not acceptable in its current form.
  const factory NetworkException.badRequest({
    Object? error,
    StackTrace? stackTrace,
  }) = NetworkExceptionBadRequest;

  /// The remote system failed while processing the request.
  const factory NetworkException.serverError({
    Object? error,
    StackTrace? stackTrace,
  }) = NetworkExceptionServerError;

  /// An unexpected error occurred.
  const factory NetworkException.unknown({
    Object? error,
    StackTrace? stackTrace,
  }) = NetworkExceptionUnknown;
}
