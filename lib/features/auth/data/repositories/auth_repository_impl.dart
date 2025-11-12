import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_session_entity.dart';
import '../../domain/entities/auth_tokens_entity.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthSessionEntity>> login({
    required String username,
    required String password,
    int? expiresInMins,
  }) async {
    try {
      final session = await remoteDataSource.login(
        username: username,
        password: password,
        expiresInMins: expiresInMins,
      );
      return Right(session.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUserEntity>> getCurrentUser({
    required String accessToken,
  }) async {
    try {
      final user = await remoteDataSource.getCurrentUser(
        accessToken: accessToken,
      );
      return Right(user.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthTokensEntity>> refreshSession({
    required String refreshToken,
    int? expiresInMins,
  }) async {
    try {
      final tokens = await remoteDataSource.refreshSession(
        refreshToken: refreshToken,
        expiresInMins: expiresInMins,
      );
      return Right(tokens.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }
}
