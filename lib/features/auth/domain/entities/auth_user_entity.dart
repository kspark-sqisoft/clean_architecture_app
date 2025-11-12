import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_entity.freezed.dart';

/// AuthUserEntity - 인증된 사용자 정보
@freezed
class AuthUserEntity with _$AuthUserEntity {
  const factory AuthUserEntity({
    required int id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    required String image,
  }) = _AuthUserEntity;
}
