import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/constants/api_constants.dart';
import 'package:clean_architectue_app/core/error/exceptions.dart';
import 'package:clean_architectue_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architectue_app/features/auth/data/models/auth_session_model.dart';
import 'package:clean_architectue_app/features/auth/data/models/auth_tokens_model.dart';
import 'package:clean_architectue_app/features/auth/data/models/auth_user_model.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  late _MockDio dio;
  late AuthRemoteDataSource dataSource;

  const tUsername = 'emilys';
  const tPassword = 'emilyspass';
  const tExpires = 30;
  const tAccessToken = 'access-token';
  const tRefreshToken = 'refresh-token';

  final tLoginResponse = {
    'id': 1,
    'username': 'emilys',
    'email': 'emily.johnson@x.dummyjson.com',
    'firstName': 'Emily',
    'lastName': 'Johnson',
    'gender': 'female',
    'image': 'https://dummyjson.com/icon/emilys/128',
    'accessToken': tAccessToken,
    'refreshToken': tRefreshToken,
  };

  final tUserResponse = {
    'id': 1,
    'username': 'emilys',
    'email': 'emily.johnson@x.dummyjson.com',
    'firstName': 'Emily',
    'lastName': 'Johnson',
    'gender': 'female',
    'image': 'https://dummyjson.com/icon/emilys/128',
  };

  final tTokensResponse = {
    'accessToken': '$tAccessToken-new',
    'refreshToken': '$tRefreshToken-new',
  };

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
    registerFallbackValue(Options());
  });

  setUp(() {
    dio = _MockDio();
    dataSource = AuthRemoteDataSourceImpl(dio: dio);
  });

  group('login', () {
    test('should return AuthSessionModel when status code is 200', () async {
      final response = Response<dynamic>(
        data: tLoginResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.login),
      );

      when(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => response);

      final result = await dataSource.login(
        username: tUsername,
        password: tPassword,
        expiresInMins: tExpires,
      );

      expect(result, isA<AuthSessionModel>());
      expect(result.user.username, tUsername);
      expect(result.tokens.accessToken, tAccessToken);

      verify(
        () => dio.post(
          ApiConstants.login,
          data: {
            'username': tUsername,
            'password': tPassword,
            'expiresInMins': tExpires,
          },
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tLoginResponse,
        statusCode: 400,
        requestOptions: RequestOptions(path: ApiConstants.login),
      );

      when(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => response);

      expect(
        () => dataSource.login(username: tUsername, password: tPassword),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException on DioException', () async {
      when(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiConstants.login),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(
        () => dataSource.login(username: tUsername, password: tPassword),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getCurrentUser', () {
    test('should return AuthUserModel when status code is 200', () async {
      final response = Response<dynamic>(
        data: tUserResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.me),
      );

      when(
        () => dio.get(any(), options: any(named: 'options')),
      ).thenAnswer((_) async => response);

      final result = await dataSource.getCurrentUser(accessToken: tAccessToken);

      expect(result, isA<AuthUserModel>());
      expect(result.username, tUsername);

      verify(
        () => dio.get(ApiConstants.me, options: any(named: 'options')),
      ).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tUserResponse,
        statusCode: 401,
        requestOptions: RequestOptions(path: ApiConstants.me),
      );

      when(
        () => dio.get(any(), options: any(named: 'options')),
      ).thenAnswer((_) async => response);

      expect(
        () => dataSource.getCurrentUser(accessToken: tAccessToken),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('refreshSession', () {
    test('should return AuthTokensModel when status code is 200', () async {
      final response = Response<dynamic>(
        data: tTokensResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.refresh),
      );

      when(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => response);

      final result = await dataSource.refreshSession(
        refreshToken: tRefreshToken,
        expiresInMins: tExpires,
      );

      expect(result, isA<AuthTokensModel>());
      expect(result.accessToken, '$tAccessToken-new');

      verify(
        () => dio.post(
          ApiConstants.refresh,
          data: {'refreshToken': tRefreshToken, 'expiresInMins': tExpires},
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tTokensResponse,
        statusCode: 400,
        requestOptions: RequestOptions(path: ApiConstants.refresh),
      );

      when(
        () => dio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => response);

      expect(
        () => dataSource.refreshSession(refreshToken: tRefreshToken),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
