import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class DioNetworkService extends NetworkService {
  final _dio = Dio()..interceptors.add(_ErrorInterceptors());

  @override
  TaskEither<AppException, T> request<T, R>(
    NetworkResource resource,
    T Function(R data) parser,
  ) {
    return _request<R>(resource).flatMap(
      (data) => Either.tryCatch(
        () => parser(data),
        (e, st) => AppException.decodingFailure(error: e, stackTrace: st),
      ).toTaskEither(),
    );
  }

  TaskEither<AppException, R> _request<R>(NetworkResource resource) {
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
        return response.data as R;
      },
      (error, st) {
        if (error is DioException && error.error is AppException) {
          return (error.error as AppException)
              .copyWith(error: error, stackTrace: st);
        }

        if (error is TypeError) {
          return AppException.decodingFailure(error: error, stackTrace: st);
        }

        return AppException.unknown(error: error, stackTrace: st);
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
        const AppException.requestTimeout(),
      DioExceptionType.connectionError => const AppException.noConnection(),
      DioExceptionType.badResponse => _mapStatusCode(status),
      _ => const AppException.unknown(),
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

  AppException _mapStatusCode(int? status) {
    return switch (status) {
      400 => const AppException.badRequest(),
      401 => const AppException.unauthorized(),
      403 => const AppException.forbidden(),
      404 => const AppException.notFound(),
      429 => const AppException.tooManyRequests(),
      _ when status != null && status >= 400 && status < 500 =>
        const AppException.badRequest(),
      _ when status != null && status >= 500 && status < 600 =>
        const AppException.serverError(),
      _ => const AppException.unknown(),
    };
  }
}
