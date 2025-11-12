import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:clean_architectue_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architectue_app/features/auth/domain/usecases/refresh_auth_session.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repository;
  late RefreshAuthSession usecase;

  const tRefreshToken = 'refresh-token';
  const tTokens = AuthTokensEntity(
    accessToken: 'access-token',
    refreshToken: 'refresh-token-new',
  );

  setUp(() {
    repository = _MockAuthRepository();
    usecase = RefreshAuthSession(repository);
  });

  test('should call repository with refresh token', () async {
    when(
      () => repository.refreshSession(
        refreshToken: any(named: 'refreshToken'),
        expiresInMins: any(named: 'expiresInMins'),
      ),
    ).thenAnswer((_) async => const Right(tTokens));

    final params = RefreshAuthSessionParams(refreshToken: tRefreshToken);
    final result = await usecase(params);

    expect(result, const Right(tTokens));
    verify(
      () => repository.refreshSession(
        refreshToken: tRefreshToken,
        expiresInMins: null,
      ),
    ).called(1);
  });
}
