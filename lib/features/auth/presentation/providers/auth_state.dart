import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_session_entity.dart';
import '../../domain/entities/auth_tokens_entity.dart';
import '../../domain/entities/auth_user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    AuthUserEntity? user,
    AuthTokensEntity? tokens,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _AuthState;

  const AuthState._();

  bool get isAuthenticated => user != null && tokens != null;

  factory AuthState.fromSession(AuthSessionEntity session) {
    return AuthState(
      user: session.user,
      tokens: session.tokens,
      isLoading: false,
      errorMessage: null,
    );
  }
}
