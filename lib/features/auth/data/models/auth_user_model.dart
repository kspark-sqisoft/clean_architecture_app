import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_user_entity.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const AuthUserModel._();

  const factory AuthUserModel({
    required int id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    required String image,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  AuthUserEntity toEntity() {
    return AuthUserEntity(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
    );
  }
}

extension AuthUserEntityX on AuthUserEntity {
  AuthUserModel toModel() {
    return AuthUserModel(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
    );
  }
}
