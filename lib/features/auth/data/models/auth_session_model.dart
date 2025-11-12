import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_session_entity.dart';
import 'auth_tokens_model.dart';
import 'auth_user_model.dart';

part 'auth_session_model.freezed.dart';
part 'auth_session_model.g.dart';

@freezed
class AuthSessionModel with _$AuthSessionModel {
  const AuthSessionModel._();

  const factory AuthSessionModel({
    required AuthUserModel user,
    required AuthTokensModel tokens,
  }) = _AuthSessionModel;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  factory AuthSessionModel.fromLoginResponse(Map<String, dynamic> json) {
    final user = AuthUserModel.fromJson(json);
    final tokens = AuthTokensModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
    return AuthSessionModel(user: user, tokens: tokens);
  }

  AuthSessionEntity toEntity() {
    return AuthSessionEntity(user: user.toEntity(), tokens: tokens.toEntity());
  }
}

extension AuthSessionEntityX on AuthSessionEntity {
  AuthSessionModel toModel() {
    return AuthSessionModel(user: user.toModel(), tokens: tokens.toModel());
  }
}
