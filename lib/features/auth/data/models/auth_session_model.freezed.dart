// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) {
  return _AuthSessionModel.fromJson(json);
}

/// @nodoc
mixin _$AuthSessionModel {
  AuthUserModel get user => throw _privateConstructorUsedError;
  AuthTokensModel get tokens => throw _privateConstructorUsedError;

  /// Serializes this AuthSessionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthSessionModelCopyWith<AuthSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthSessionModelCopyWith<$Res> {
  factory $AuthSessionModelCopyWith(
    AuthSessionModel value,
    $Res Function(AuthSessionModel) then,
  ) = _$AuthSessionModelCopyWithImpl<$Res, AuthSessionModel>;
  @useResult
  $Res call({AuthUserModel user, AuthTokensModel tokens});

  $AuthUserModelCopyWith<$Res> get user;
  $AuthTokensModelCopyWith<$Res> get tokens;
}

/// @nodoc
class _$AuthSessionModelCopyWithImpl<$Res, $Val extends AuthSessionModel>
    implements $AuthSessionModelCopyWith<$Res> {
  _$AuthSessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? tokens = null}) {
    return _then(
      _value.copyWith(
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AuthUserModel,
            tokens: null == tokens
                ? _value.tokens
                : tokens // ignore: cast_nullable_to_non_nullable
                      as AuthTokensModel,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthUserModelCopyWith<$Res> get user {
    return $AuthUserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthTokensModelCopyWith<$Res> get tokens {
    return $AuthTokensModelCopyWith<$Res>(_value.tokens, (value) {
      return _then(_value.copyWith(tokens: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthSessionModelImplCopyWith<$Res>
    implements $AuthSessionModelCopyWith<$Res> {
  factory _$$AuthSessionModelImplCopyWith(
    _$AuthSessionModelImpl value,
    $Res Function(_$AuthSessionModelImpl) then,
  ) = __$$AuthSessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthUserModel user, AuthTokensModel tokens});

  @override
  $AuthUserModelCopyWith<$Res> get user;
  @override
  $AuthTokensModelCopyWith<$Res> get tokens;
}

/// @nodoc
class __$$AuthSessionModelImplCopyWithImpl<$Res>
    extends _$AuthSessionModelCopyWithImpl<$Res, _$AuthSessionModelImpl>
    implements _$$AuthSessionModelImplCopyWith<$Res> {
  __$$AuthSessionModelImplCopyWithImpl(
    _$AuthSessionModelImpl _value,
    $Res Function(_$AuthSessionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? tokens = null}) {
    return _then(
      _$AuthSessionModelImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AuthUserModel,
        tokens: null == tokens
            ? _value.tokens
            : tokens // ignore: cast_nullable_to_non_nullable
                  as AuthTokensModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthSessionModelImpl extends _AuthSessionModel {
  const _$AuthSessionModelImpl({required this.user, required this.tokens})
    : super._();

  factory _$AuthSessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthSessionModelImplFromJson(json);

  @override
  final AuthUserModel user;
  @override
  final AuthTokensModel tokens;

  @override
  String toString() {
    return 'AuthSessionModel(user: $user, tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSessionModelImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.tokens, tokens) || other.tokens == tokens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, tokens);

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSessionModelImplCopyWith<_$AuthSessionModelImpl> get copyWith =>
      __$$AuthSessionModelImplCopyWithImpl<_$AuthSessionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthSessionModelImplToJson(this);
  }
}

abstract class _AuthSessionModel extends AuthSessionModel {
  const factory _AuthSessionModel({
    required final AuthUserModel user,
    required final AuthTokensModel tokens,
  }) = _$AuthSessionModelImpl;
  const _AuthSessionModel._() : super._();

  factory _AuthSessionModel.fromJson(Map<String, dynamic> json) =
      _$AuthSessionModelImpl.fromJson;

  @override
  AuthUserModel get user;
  @override
  AuthTokensModel get tokens;

  /// Create a copy of AuthSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSessionModelImplCopyWith<_$AuthSessionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
