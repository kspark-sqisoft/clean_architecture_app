/// Exception 클래스
/// - 데이터 레이어에서 throw하는 예외를 정의합니다
/// - Repository에서 이를 catch하여 Failure로 변환합니다
library;

class ServerException implements Exception {
  final String? message;

  ServerException([this.message]);

  @override
  String toString() => message ?? 'ServerException';
}

class CacheException implements Exception {
  final String? message;

  CacheException([this.message]);

  @override
  String toString() => message ?? 'CacheException';
}
