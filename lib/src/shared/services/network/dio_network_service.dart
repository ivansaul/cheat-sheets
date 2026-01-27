import 'package:cheat_sheets/src/shared/services/network/network_exception.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class DioNetworkService implements NetworkService {
  final _dio = Dio()..interceptors.add(_ErrorInterceptors());

  @override
  TaskEither<NetworkException, NetworkResponse> request(
    NetworkResource resource,
  ) {
    return _request(resource);
  }

  TaskEither<NetworkException, NetworkResponse> _request(
    NetworkResource resource,
  ) {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.request(
          _buildUrl(resource),
          options: Options(
            method: resource.method.name.toUpperCase(),
            headers: resource.headers,
          ),
          data: resource.body,
          queryParameters: resource.queryParam,
        );
        return NetworkResponse(
          statusCode: response.statusCode,
          data: response.data,
        );
      },
      (error, st) {
        if (error is DioException && error.error is NetworkException) {
          return (error.error as NetworkException)
              .copyWith(error: error, stackTrace: st);
        }

        return NetworkException.unknown(error: error, stackTrace: st);
      },
    );
  }

  String _buildUrl(NetworkResource resource) {
    final base = resource.baseURL;
    final path = resource.path?.replaceFirst(RegExp(r"^/"), "") ?? "";
    final uri = Uri.parse(base.endsWith("/") ? "$base$path" : "$base/$path");
    return uri.toString();
  }
}

class _ErrorInterceptors extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    if (statusCode != null && statusCode >= 200 && statusCode < 300) {
      handler.next(response);
      return;
    }

    handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      ),
      true,
    );
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode;
    final exception = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        NetworkException.timeout(error: err, stackTrace: StackTrace.current),
      DioExceptionType.connectionError => NetworkException.noConnection(
          error: err, stackTrace: StackTrace.current),
      DioExceptionType.badResponse => _mapStatusCode(status, err),
      _ => NetworkException.unknown(error: err, stackTrace: StackTrace.current),
    };

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }

  NetworkException _mapStatusCode(int? status, DioException err) {
    return switch (status) {
      401 => NetworkException.unauthorized(
          error: err, stackTrace: StackTrace.current),
      403 =>
        NetworkException.forbidden(error: err, stackTrace: StackTrace.current),
      404 =>
        NetworkException.notFound(error: err, stackTrace: StackTrace.current),
      429 => NetworkException.rateLimited(
          error: err, stackTrace: StackTrace.current),
      _ when status != null && status >= 400 && status < 500 =>
        NetworkException.badRequest(error: err, stackTrace: StackTrace.current),
      _ when status != null && status >= 500 && status < 600 =>
        NetworkException.serverError(
            error: err, stackTrace: StackTrace.current),
      _ => NetworkException.unknown(error: err, stackTrace: StackTrace.current),
    };
  }
}
