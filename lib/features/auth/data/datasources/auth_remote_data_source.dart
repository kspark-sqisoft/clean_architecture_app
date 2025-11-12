import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/auth_session_model.dart';
import '../models/auth_tokens_model.dart';
import '../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String username,
    required String password,
    int? expiresInMins,
  });

  Future<AuthUserModel> getCurrentUser({required String accessToken});

  Future<AuthTokensModel> refreshSession({
    required String refreshToken,
    int? expiresInMins,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthSessionModel> login({
    required String username,
    required String password,
    int? expiresInMins,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {
          'username': username,
          'password': password,
          if (expiresInMins != null) 'expiresInMins': expiresInMins,
        },
        options: Options(extra: {'withCredentials': true}),
      );

      if (response.statusCode == 200) {
        return AuthSessionModel.fromLoginResponse(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException('Failed to login: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<AuthUserModel> getCurrentUser({required String accessToken}) async {
    try {
      final response = await dio.get(
        ApiConstants.me,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
          extra: {'withCredentials': true},
        ),
      );

      if (response.statusCode == 200) {
        return AuthUserModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          'Failed to fetch auth user: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<AuthTokensModel> refreshSession({
    required String refreshToken,
    int? expiresInMins,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.refresh,
        data: {
          'refreshToken': refreshToken,
          if (expiresInMins != null) 'expiresInMins': expiresInMins,
        },
        options: Options(extra: {'withCredentials': true}),
      );

      if (response.statusCode == 200) {
        return AuthTokensModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          'Failed to refresh token: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Bad response';
        return 'Bad response ($status): $message';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'Connection error';
      default:
        return e.message ?? 'Unknown network error';
    }
  }
}
