import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:clean_architectue_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architectue_app/features/auth/domain/usecases/get_auth_user.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repository;
  late GetAuthUser usecase;

  const tAccessToken = 'access-token';
  const tUser = AuthUserEntity(
    id: 1,
    username: 'emilys',
    email: 'emily.johnson@x.dummyjson.com',
    firstName: 'Emily',
    lastName: 'Johnson',
    gender: 'female',
    image: 'https://dummyjson.com/icon/emilys/128',
  );

  setUp(() {
    repository = _MockAuthRepository();
    usecase = GetAuthUser(repository);
  });

  test('액세스 토큰으로 레포지토리를 호출하면 사용자 정보를 반환한다', () async {
    when(
      () => repository.getCurrentUser(accessToken: any(named: 'accessToken')),
    ).thenAnswer((_) async => const Right(tUser));

    final result = await usecase(tAccessToken);

    expect(result, const Right(tUser));
    verify(
      () => repository.getCurrentUser(accessToken: tAccessToken),
    ).called(1);
  });
}
