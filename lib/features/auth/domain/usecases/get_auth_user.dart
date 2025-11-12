import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

class GetAuthUser implements UseCase<AuthUserEntity, String> {
  final AuthRepository repository;

  GetAuthUser(this.repository);

  @override
  Future<Either<Failure, AuthUserEntity>> call(String accessToken) {
    return repository.getCurrentUser(accessToken: accessToken);
  }
}
