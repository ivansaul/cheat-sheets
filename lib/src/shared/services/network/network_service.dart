import 'package:cheat_sheets/src/shared/services/network/network_exception.dart';
import 'package:fpdart/fpdart.dart';

abstract class NetworkService {
  TaskEither<NetworkException, NetworkResponse> request(
    NetworkResource resource,
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

/// The [NetworkResponse] class contains the payload (could be transformed)
/// that respond from the request, and other information of the response.
class NetworkResponse {
  NetworkResponse({
    this.statusCode,
    this.data,
  });

  /// The HTTP status code for the response.
  final int? statusCode;

  /// The response payload.
  /// The content could have been parsed to a specific type.
  final dynamic data;
}
