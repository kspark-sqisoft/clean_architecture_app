// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthSessionModelImpl _$$AuthSessionModelImplFromJson(
  Map<String, dynamic> json,
) => _$AuthSessionModelImpl(
  user: AuthUserModel.fromJson(json['user'] as Map<String, dynamic>),
  tokens: AuthTokensModel.fromJson(json['tokens'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AuthSessionModelImplToJson(
  _$AuthSessionModelImpl instance,
) => <String, dynamic>{'user': instance.user, 'tokens': instance.tokens};
