import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_session_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUser implements UseCase<AuthSessionEntity, LoginParams> {
  final AuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, AuthSessionEntity>> call(LoginParams params) {
    return repository.login(
      username: params.username,
      password: params.password,
      expiresInMins: params.expiresInMins,
    );
  }
}

class LoginParams {
  final String username;
  final String password;
  final int? expiresInMins;

  const LoginParams({
    required this.username,
    required this.password,
    this.expiresInMins,
  });
}
