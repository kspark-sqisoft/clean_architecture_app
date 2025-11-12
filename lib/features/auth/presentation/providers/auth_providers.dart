import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_auth_user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/refresh_auth_session.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSourceImpl(dio: dio);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource: remoteDataSource);
}

@riverpod
LoginUser loginUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUser(repository);
}

@riverpod
GetAuthUser getAuthUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetAuthUser(repository);
}

@riverpod
RefreshAuthSession refreshAuthSession(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RefreshAuthSession(repository);
}
