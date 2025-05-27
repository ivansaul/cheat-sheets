import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

abstract class NetworkService {
  TaskEither<AppException, T> request<T, R>(
    NetworkResource resource,
    T Function(R data) parser,
  );
}

abstract class NetworkResource {
  String get baseURL;
  String? get path;
  RequestType get method;
  Map<String, String>? get headers;
  Map<String, dynamic>? get queryParam;
  Map<String, dynamic>? get body;
}

enum RequestType {
  get,
  post,
  put,
  delete,
  patch,
}
