import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_session_entity.dart';
import '../../domain/entities/auth_tokens_entity.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/refresh_auth_session.dart';
import 'auth_providers.dart';
import 'auth_state.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() => const AuthState();

  Future<void> login({
    required String username,
    required String password,
    int? expiresInMins,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final login = ref.read(loginUserProvider);
    final result = await login(
      LoginParams(
        username: username,
        password: password,
        expiresInMins: expiresInMins,
      ),
    );

    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        errorMessage: _failureMessage(failure),
      ),
      (session) => AuthState.fromSession(session),
    );
  }

  Future<void> loadCurrentUser() async {
    final tokens = state.tokens;
    if (tokens == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    final getUser = ref.read(getAuthUserProvider);
    final result = await getUser(tokens.accessToken);

    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        errorMessage: _failureMessage(failure),
      ),
      (user) =>
          state.copyWith(isLoading: false, errorMessage: null, user: user),
    );
  }

  Future<void> refreshTokens({int? expiresInMins}) async {
    final tokens = state.tokens;
    if (tokens == null) return;

    final refresh = ref.read(refreshAuthSessionProvider);
    final result = await refresh(
      RefreshAuthSessionParams(
        refreshToken: tokens.refreshToken,
        expiresInMins: expiresInMins,
      ),
    );

    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: _failureMessage(failure));
      },
      (newTokens) {
        state = state.copyWith(tokens: newTokens, errorMessage: null);
      },
    );
  }

  void setSession(AuthSessionEntity session) {
    state = AuthState.fromSession(session);
  }

  void setTokens(AuthTokensEntity tokens) {
    state = state.copyWith(tokens: tokens, errorMessage: null);
  }

  void setUser(AuthUserEntity user) {
    state = state.copyWith(user: user, errorMessage: null);
  }

  void logout() {
    state = const AuthState();
  }

  String? _failureMessage(Failure failure) {
    return failure.when(
      server: (msg) => msg ?? 'Server error',
      cache: (msg) => msg ?? 'Cache error',
      general: (msg) => msg ?? 'Unknown error',
    );
  }
}
