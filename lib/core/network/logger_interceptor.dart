import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../logger/app_logger.dart';

/// Dio Logger Interceptor
///
/// Dio의 LogInterceptor 대신 logger 패키지를 사용하는 커스텀 인터셉터
/// HTTP 요청/응답을 구조화된 로그로 출력합니다
class LoggerInterceptor extends Interceptor {
  final Logger _logger;

  LoggerInterceptor({Logger? logger}) : _logger = logger ?? appLogger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('┌─────────────────────────────────────────────────────────────');
    _logger.d('│ Request: ${options.method} ${options.uri}');
    _logger.d('│ Headers: ${options.headers}');
    if (options.data != null) {
      _logger.d('│ Body: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      _logger.d('│ Query Parameters: ${options.queryParameters}');
    }
    _logger.d('└─────────────────────────────────────────────────────────────');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('┌─────────────────────────────────────────────────────────────');
    _logger.i(
      '│ Response: ${response.statusCode} ${response.requestOptions.uri}',
    );
    if (response.headers.map.isNotEmpty) {
      _logger.i('│ Headers: ${response.headers.map}');
    }
    _logger.i('│ Data: ${response.data}');
    _logger.i('└─────────────────────────────────────────────────────────────');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('┌─────────────────────────────────────────────────────────────');
    _logger.e('│ Error: ${err.type}');
    _logger.e(
      '│ Request: ${err.requestOptions.method} ${err.requestOptions.uri}',
    );
    _logger.e('│ Status Code: ${err.response?.statusCode}');
    _logger.e('│ Message: ${err.message}');
    if (err.response != null) {
      _logger.e('│ Response Data: ${err.response?.data}');
    }
    _logger.e(
      '└─────────────────────────────────────────────────────────────',
      error: err,
      stackTrace: err.stackTrace,
    );
    super.onError(err, handler);
  }
}
