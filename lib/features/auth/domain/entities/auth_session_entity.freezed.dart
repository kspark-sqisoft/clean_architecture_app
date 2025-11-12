// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthSessionEntity {
  AuthUserEntity get user => throw _privateConstructorUsedError;
  AuthTokensEntity get tokens => throw _privateConstructorUsedError;

  /// Create a copy of AuthSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthSessionEntityCopyWith<AuthSessionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthSessionEntityCopyWith<$Res> {
  factory $AuthSessionEntityCopyWith(
    AuthSessionEntity value,
    $Res Function(AuthSessionEntity) then,
  ) = _$AuthSessionEntityCopyWithImpl<$Res, AuthSessionEntity>;
  @useResult
  $Res call({AuthUserEntity user, AuthTokensEntity tokens});

  $AuthUserEntityCopyWith<$Res> get user;
  $AuthTokensEntityCopyWith<$Res> get tokens;
}

/// @nodoc
class _$AuthSessionEntityCopyWithImpl<$Res, $Val extends AuthSessionEntity>
    implements $AuthSessionEntityCopyWith<$Res> {
  _$AuthSessionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? tokens = null}) {
    return _then(
      _value.copyWith(
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AuthUserEntity,
            tokens: null == tokens
                ? _value.tokens
                : tokens // ignore: cast_nullable_to_non_nullable
                      as AuthTokensEntity,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthUserEntityCopyWith<$Res> get user {
    return $AuthUserEntityCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of AuthSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthTokensEntityCopyWith<$Res> get tokens {
    return $AuthTokensEntityCopyWith<$Res>(_value.tokens, (value) {
      return _then(_value.copyWith(tokens: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthSessionEntityImplCopyWith<$Res>
    implements $AuthSessionEntityCopyWith<$Res> {
  factory _$$AuthSessionEntityImplCopyWith(
    _$AuthSessionEntityImpl value,
    $Res Function(_$AuthSessionEntityImpl) then,
  ) = __$$AuthSessionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthUserEntity user, AuthTokensEntity tokens});

  @override
  $AuthUserEntityCopyWith<$Res> get user;
  @override
  $AuthTokensEntityCopyWith<$Res> get tokens;
}

/// @nodoc
class __$$AuthSessionEntityImplCopyWithImpl<$Res>
    extends _$AuthSessionEntityCopyWithImpl<$Res, _$AuthSessionEntityImpl>
    implements _$$AuthSessionEntityImplCopyWith<$Res> {
  __$$AuthSessionEntityImplCopyWithImpl(
    _$AuthSessionEntityImpl _value,
    $Res Function(_$AuthSessionEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? tokens = null}) {
    return _then(
      _$AuthSessionEntityImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AuthUserEntity,
        tokens: null == tokens
            ? _value.tokens
            : tokens // ignore: cast_nullable_to_non_nullable
                  as AuthTokensEntity,
      ),
    );
  }
}

/// @nodoc

class _$AuthSessionEntityImpl implements _AuthSessionEntity {
  const _$AuthSessionEntityImpl({required this.user, required this.tokens});

  @override
  final AuthUserEntity user;
  @override
  final AuthTokensEntity tokens;

  @override
  String toString() {
    return 'AuthSessionEntity(user: $user, tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSessionEntityImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.tokens, tokens) || other.tokens == tokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, tokens);

  /// Create a copy of AuthSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSessionEntityImplCopyWith<_$AuthSessionEntityImpl> get copyWith =>
      __$$AuthSessionEntityImplCopyWithImpl<_$AuthSessionEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _AuthSessionEntity implements AuthSessionEntity {
  const factory _AuthSessionEntity({
    required final AuthUserEntity user,
    required final AuthTokensEntity tokens,
  }) = _$AuthSessionEntityImpl;

  @override
  AuthUserEntity get user;
  @override
  AuthTokensEntity get tokens;

  /// Create a copy of AuthSessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSessionEntityImplCopyWith<_$AuthSessionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
