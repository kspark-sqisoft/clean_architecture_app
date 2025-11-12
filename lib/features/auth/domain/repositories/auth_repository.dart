import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_session_entity.dart';
import '../entities/auth_tokens_entity.dart';
import '../entities/auth_user_entity.dart';

/// AuthRepository - 인증 관련 도메인 인터페이스
abstract class AuthRepository {
  /// 로그인하여 사용자 정보와 토큰을 가져옵니다
  Future<Either<Failure, AuthSessionEntity>> login({
    required String username,
    required String password,
    int? expiresInMins,
  });

  /// 현재 인증된 사용자 정보를 가져옵니다
  Future<Either<Failure, AuthUserEntity>> getCurrentUser({
    required String accessToken,
  });

  /// 리프레시 토큰으로 세션을 갱신합니다
  Future<Either<Failure, AuthTokensEntity>> refreshSession({
    required String refreshToken,
    int? expiresInMins,
  });
}
