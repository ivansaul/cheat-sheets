import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cheatsheet_data_source_exception.freezed.dart';

@freezed
sealed class CheatsheetDataSourceException
    with _$CheatsheetDataSourceException {
  const CheatsheetDataSourceException._();

  const factory CheatsheetDataSourceException.notFound({
    Object? error,
    StackTrace? stackTrace,
  }) = CheatsheetDataSourceExceptionNotFound;

  const factory CheatsheetDataSourceException.unavailable({
    Object? error,
    StackTrace? stackTrace,
  }) = CheatsheetDataSourceExceptionUnavailable;

  const factory CheatsheetDataSourceException.parsing({
    Object? error,
    StackTrace? stackTrace,
  }) = CheatsheetDataSourceExceptionParsing;

  const factory CheatsheetDataSourceException.unknown({
    Object? error,
    StackTrace? stackTrace,
  }) = CheatsheetDataSourceExceptionUnknown;
}

extension CheatsheetDataSourceExceptionExtension
    on CheatsheetDataSourceException {
  AppException toAppException() {
    return switch (this) {
      CheatsheetDataSourceExceptionNotFound(:final error, :final stackTrace) =>
        AppException.notFound(error: error, stackTrace: stackTrace),
      CheatsheetDataSourceExceptionUnavailable(
        :final error,
        :final stackTrace
      ) =>
        AppException.unavailable(error: error, stackTrace: stackTrace),
      CheatsheetDataSourceExceptionParsing(:final error, :final stackTrace) ||
      CheatsheetDataSourceExceptionUnknown(:final error, :final stackTrace) =>
        AppException.unknown(error: error, stackTrace: stackTrace),
    };
  }
}
