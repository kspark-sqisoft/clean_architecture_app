import 'package:dio/dio.dart';
import 'logger_interceptor.dart';

/// API 클라이언트 설정
///
/// **역할:**
/// - DummyJSON API와 통신하기 위한 Dio 클라이언트를 제공합니다
/// - 기본 URL, 타임아웃, 인터셉터 등을 설정합니다
class ApiClient {
  static const String baseUrl = 'https://dummyjson.com';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Logger 인터셉터 추가 (구조화된 로그 출력)
    dio.interceptors.add(LoggerInterceptor());
  }
}
