import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:cheat_sheets/src/shared/services/network/network_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_data_source_exception.freezed.dart';

@freezed
sealed class CouponDataSourceException with _$CouponDataSourceException {
  const CouponDataSourceException._();

  const factory CouponDataSourceException.notFound({
    Object? error,
    StackTrace? stackTrace,
  }) = CouponDataSourceExceptionNotFound;

  const factory CouponDataSourceException.unavailable({
    Object? error,
    StackTrace? stackTrace,
  }) = CouponDataSourceExceptionUnavailable;

  const factory CouponDataSourceException.parsing({
    Object? error,
    StackTrace? stackTrace,
  }) = CouponDataSourceExceptionParsing;

  const factory CouponDataSourceException.unknown({
    Object? error,
    StackTrace? stackTrace,
  }) = CouponDataSourceExceptionUnknown;
}

extension CouponDataSourceExceptionExtension on CouponDataSourceException {
  AppException toAppException() {
    return switch (this) {
      CouponDataSourceExceptionNotFound(:final error, :final stackTrace) =>
        AppException.notFound(error: error, stackTrace: stackTrace),
      CouponDataSourceExceptionUnavailable(:final error, :final stackTrace) =>
        AppException.unavailable(error: error, stackTrace: stackTrace),
      CouponDataSourceExceptionParsing(:final error, :final stackTrace) ||
      CouponDataSourceExceptionUnknown(:final error, :final stackTrace) =>
        AppException.unknown(error: error, stackTrace: stackTrace),
    };
  }
}

extension NetworkExceptionExtension on NetworkException {
  CouponDataSourceException toCouponDataSourceException() {
    return switch (this) {
      NetworkExceptionNotFound(:final error, :final stackTrace) =>
        CouponDataSourceException.notFound(
          error: error,
          stackTrace: stackTrace,
        ),
      NetworkExceptionServerError(:final error, :final stackTrace) ||
      NetworkExceptionTimeout(:final error, :final stackTrace) ||
      NetworkExceptionNoConnection(:final error, :final stackTrace) ||
      NetworkExceptionRateLimited(:final error, :final stackTrace) =>
        CouponDataSourceException.unavailable(
          error: error,
          stackTrace: stackTrace,
        ),
      NetworkExceptionUnauthorized(:final error, :final stackTrace) ||
      NetworkExceptionForbidden(:final error, :final stackTrace) ||
      NetworkExceptionBadRequest(:final error, :final stackTrace) ||
      NetworkExceptionUnknown(:final error, :final stackTrace) =>
        CouponDataSourceException.unknown(
          error: error,
          stackTrace: stackTrace,
        ),
    };
  }
}
