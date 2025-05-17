import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exceptions.freezed.dart';

@freezed
sealed class AppException with _$AppException {
  const factory AppException.decodingFailure() = DecodingFailure;
  const factory AppException.notFoundItem() = NotFoundItem;
}

extension AppExceptionMessage on AppException {
  String message() {
    return switch (this) {
      DecodingFailure() => "Something’s wrong with the data structure.",
      NotFoundItem() => "We couldn’t find what you're looking for.",
    };
  }
}
