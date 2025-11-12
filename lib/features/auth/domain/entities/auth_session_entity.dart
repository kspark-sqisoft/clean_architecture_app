import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_tokens_entity.dart';
import 'auth_user_entity.dart';

part 'auth_session_entity.freezed.dart';

/// AuthSessionEntity - 로그인 세션 정보 (사용자 + 토큰)
@freezed
class AuthSessionEntity with _$AuthSessionEntity {
  const factory AuthSessionEntity({
    required AuthUserEntity user,
    required AuthTokensEntity tokens,
  }) = _AuthSessionEntity;
}
