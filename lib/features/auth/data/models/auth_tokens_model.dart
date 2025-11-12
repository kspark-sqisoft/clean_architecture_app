import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_tokens_entity.dart';

part 'auth_tokens_model.freezed.dart';
part 'auth_tokens_model.g.dart';

@freezed
class AuthTokensModel with _$AuthTokensModel {
  const AuthTokensModel._();

  const factory AuthTokensModel({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokensModel;

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensModelFromJson(json);

  AuthTokensEntity toEntity() {
    return AuthTokensEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

extension AuthTokensEntityX on AuthTokensEntity {
  AuthTokensModel toModel() {
    return AuthTokensModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
