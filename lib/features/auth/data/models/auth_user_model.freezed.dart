// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) {
  return _AuthUserModel.fromJson(json);
}

/// @nodoc
mixin _$AuthUserModel {
  int get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  /// Serializes this AuthUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthUserModelCopyWith<AuthUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserModelCopyWith<$Res> {
  factory $AuthUserModelCopyWith(
    AuthUserModel value,
    $Res Function(AuthUserModel) then,
  ) = _$AuthUserModelCopyWithImpl<$Res, AuthUserModel>;
  @useResult
  $Res call({
    int id,
    String username,
    String email,
    String firstName,
    String lastName,
    String gender,
    String image,
  });
}

/// @nodoc
class _$AuthUserModelCopyWithImpl<$Res, $Val extends AuthUserModel>
    implements $AuthUserModelCopyWith<$Res> {
  _$AuthUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? gender = null,
    Object? image = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            image: null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthUserModelImplCopyWith<$Res>
    implements $AuthUserModelCopyWith<$Res> {
  factory _$$AuthUserModelImplCopyWith(
    _$AuthUserModelImpl value,
    $Res Function(_$AuthUserModelImpl) then,
  ) = __$$AuthUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String username,
    String email,
    String firstName,
    String lastName,
    String gender,
    String image,
  });
}

/// @nodoc
class __$$AuthUserModelImplCopyWithImpl<$Res>
    extends _$AuthUserModelCopyWithImpl<$Res, _$AuthUserModelImpl>
    implements _$$AuthUserModelImplCopyWith<$Res> {
  __$$AuthUserModelImplCopyWithImpl(
    _$AuthUserModelImpl _value,
    $Res Function(_$AuthUserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? gender = null,
    Object? image = null,
  }) {
    return _then(
      _$AuthUserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        image: null == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUserModelImpl extends _AuthUserModel {
  const _$AuthUserModelImpl({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  }) : super._();

  factory _$AuthUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserModelImplFromJson(json);

  @override
  final int id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String gender;
  @override
  final String image;

  @override
  String toString() {
    return 'AuthUserModel(id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, gender: $gender, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    email,
    firstName,
    lastName,
    gender,
    image,
  );

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserModelImplCopyWith<_$AuthUserModelImpl> get copyWith =>
      __$$AuthUserModelImplCopyWithImpl<_$AuthUserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserModelImplToJson(this);
  }
}

abstract class _AuthUserModel extends AuthUserModel {
  const factory _AuthUserModel({
    required final int id,
    required final String username,
    required final String email,
    required final String firstName,
    required final String lastName,
    required final String gender,
    required final String image,
  }) = _$AuthUserModelImpl;
  const _AuthUserModel._() : super._();

  factory _AuthUserModel.fromJson(Map<String, dynamic> json) =
      _$AuthUserModelImpl.fromJson;

  @override
  int get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get gender;
  @override
  String get image;

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUserModelImplCopyWith<_$AuthUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
