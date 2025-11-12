import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens_entity.freezed.dart';

/// AuthTokensEntity - 액세스/리프레시 토큰 정보
@freezed
class AuthTokensEntity with _$AuthTokensEntity {
  const factory AuthTokensEntity({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokensEntity;
}
