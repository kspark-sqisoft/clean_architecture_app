import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_tokens_entity.dart';
import '../repositories/auth_repository.dart';

class RefreshAuthSession
    implements UseCase<AuthTokensEntity, RefreshAuthSessionParams> {
  final AuthRepository repository;

  RefreshAuthSession(this.repository);

  @override
  Future<Either<Failure, AuthTokensEntity>> call(
    RefreshAuthSessionParams params,
  ) {
    return repository.refreshSession(
      refreshToken: params.refreshToken,
      expiresInMins: params.expiresInMins,
    );
  }
}

class RefreshAuthSessionParams {
  final String refreshToken;
  final int? expiresInMins;

  const RefreshAuthSessionParams({
    required this.refreshToken,
    this.expiresInMins,
  });
}
