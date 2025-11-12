import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/error/exceptions.dart';
import 'package:clean_architectue_app/core/error/failures.dart';
import 'package:clean_architectue_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architectue_app/features/auth/data/models/auth_session_model.dart';
import 'package:clean_architectue_app/features/auth/data/models/auth_tokens_model.dart';
import 'package:clean_architectue_app/features/auth/data/models/auth_user_model.dart';
import 'package:clean_architectue_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architectue_app/features/auth/domain/entities/auth_session_entity.dart';
import 'package:clean_architectue_app/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:clean_architectue_app/features/auth/domain/entities/auth_user_entity.dart';

class _MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late _MockAuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImpl repository;

  const tUsername = 'emilys';
  const tPassword = 'emilyspass';
  const tExpires = 30;
  const tAccessToken = 'access-token';
  const tRefreshToken = 'refresh-token';

  final tAuthUserModel = AuthUserModel(
    id: 1,
    username: tUsername,
    email: 'emily.johnson@x.dummyjson.com',
    firstName: 'Emily',
    lastName: 'Johnson',
    gender: 'female',
    image: 'https://dummyjson.com/icon/emilys/128',
  );

  final tAuthTokensModel = AuthTokensModel(
    accessToken: tAccessToken,
    refreshToken: tRefreshToken,
  );

  final tAuthSessionModel = AuthSessionModel(
    user: tAuthUserModel,
    tokens: tAuthTokensModel,
  );

  const tAuthUserEntity = AuthUserEntity(
    id: 1,
    username: tUsername,
    email: 'emily.johnson@x.dummyjson.com',
    firstName: 'Emily',
    lastName: 'Johnson',
    gender: 'female',
    image: 'https://dummyjson.com/icon/emilys/128',
  );

  const tAuthTokensEntity = AuthTokensEntity(
    accessToken: tAccessToken,
    refreshToken: tRefreshToken,
  );

  const tAuthSessionEntity = AuthSessionEntity(
    user: tAuthUserEntity,
    tokens: tAuthTokensEntity,
  );

  setUp(() {
    remoteDataSource = _MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  group('login', () {
    test(
      'should return AuthSessionEntity when remote data source succeeds',
      () async {
        when(
          () => remoteDataSource.login(
            username: any(named: 'username'),
            password: any(named: 'password'),
            expiresInMins: any(named: 'expiresInMins'),
          ),
        ).thenAnswer((_) async => tAuthSessionModel);

        final result = await repository.login(
          username: tUsername,
          password: tPassword,
          expiresInMins: tExpires,
        );

        expect(
          result,
          equals(const Right<Failure, AuthSessionEntity>(tAuthSessionEntity)),
        );
        verify(
          () => remoteDataSource.login(
            username: tUsername,
            password: tPassword,
            expiresInMins: tExpires,
          ),
        ).called(1);
      },
    );

    test('should return Failure when remote data source throws', () async {
      when(
        () => remoteDataSource.login(
          username: any(named: 'username'),
          password: any(named: 'password'),
          expiresInMins: any(named: 'expiresInMins'),
        ),
      ).thenThrow(ServerException('error'));

      final result = await repository.login(
        username: tUsername,
        password: tPassword,
      );

      expect(
        result,
        const Left<Failure, AuthSessionEntity>(Failure.server('error')),
      );
    });
  });

  group('getCurrentUser', () {
    test('should return AuthUserEntity when successful', () async {
      when(
        () => remoteDataSource.getCurrentUser(
          accessToken: any(named: 'accessToken'),
        ),
      ).thenAnswer((_) async => tAuthUserModel);

      final result = await repository.getCurrentUser(accessToken: tAccessToken);

      expect(
        result,
        equals(const Right<Failure, AuthUserEntity>(tAuthUserEntity)),
      );
      verify(
        () => remoteDataSource.getCurrentUser(accessToken: tAccessToken),
      ).called(1);
    });
  });

  group('refreshSession', () {
    test('should return AuthTokensEntity when successful', () async {
      when(
        () => remoteDataSource.refreshSession(
          refreshToken: any(named: 'refreshToken'),
          expiresInMins: any(named: 'expiresInMins'),
        ),
      ).thenAnswer((_) async => tAuthTokensModel);

      final result = await repository.refreshSession(
        refreshToken: tRefreshToken,
        expiresInMins: tExpires,
      );

      expect(
        result,
        equals(const Right<Failure, AuthTokensEntity>(tAuthTokensEntity)),
      );
      verify(
        () => remoteDataSource.refreshSession(
          refreshToken: tRefreshToken,
          expiresInMins: tExpires,
        ),
      ).called(1);
    });

    test('should return Failure when remote throws ServerException', () async {
      when(
        () => remoteDataSource.refreshSession(
          refreshToken: any(named: 'refreshToken'),
          expiresInMins: any(named: 'expiresInMins'),
        ),
      ).thenThrow(ServerException('fail'));

      final result = await repository.refreshSession(
        refreshToken: tRefreshToken,
      );

      expect(
        result,
        const Left<Failure, AuthTokensEntity>(Failure.server('fail')),
      );
    });
  });
}
