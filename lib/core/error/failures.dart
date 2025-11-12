import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Failure 클래스
/// - Either의 Left에 사용되는 실패 케이스를 정의합니다
/// - freezed를 사용하여 여러 타입의 실패를 union type으로 표현합니다
@freezed
class Failure with _$Failure {
  // 서버 에러 (5xx, 네트워크 문제 등)
  const factory Failure.server([String? message]) = ServerFailure;

  // 캐시 에러 (로컬 데이터 문제)
  const factory Failure.cache([String? message]) = CacheFailure;

  // 일반 에러
  const factory Failure.general([String? message]) = GeneralFailure;
}
