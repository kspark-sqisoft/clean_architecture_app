import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/features/auth/domain/entities/auth_session_entity.dart';
import 'package:clean_architectue_app/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:clean_architectue_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:clean_architectue_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architectue_app/features/auth/domain/usecases/login_user.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repository;
  late LoginUser usecase;

  const tUsername = 'emilys';
  const tPassword = 'emilyspass';
  const tSession = AuthSessionEntity(
    user: AuthUserEntity(
      id: 1,
      username: tUsername,
      email: 'emily.johnson@x.dummyjson.com',
      firstName: 'Emily',
      lastName: 'Johnson',
      gender: 'female',
      image: 'https://dummyjson.com/icon/emilys/128',
    ),
    tokens: AuthTokensEntity(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
    ),
  );

  setUp(() {
    repository = _MockAuthRepository();
    usecase = LoginUser(repository);
  });

  test('should call repository and return AuthSessionEntity', () async {
    when(
      () => repository.login(
        username: any(named: 'username'),
        password: any(named: 'password'),
        expiresInMins: any(named: 'expiresInMins'),
      ),
    ).thenAnswer((_) async => const Right(tSession));

    const params = LoginParams(username: tUsername, password: tPassword);
    final result = await usecase(params);

    expect(result, const Right(tSession));
    verify(
      () => repository.login(
        username: tUsername,
        password: tPassword,
        expiresInMins: null,
      ),
    ).called(1);
  });
}
