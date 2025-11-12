import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_controller.dart';
import '../providers/auth_state.dart';
import '../../domain/entities/auth_tokens_entity.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: 'emilys');
    _passwordController = TextEditingController(text: 'emilyspass');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final authNotifier = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Auth Demo'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DummyJSON Auth API',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),

              if (authState.errorMessage != null)
                _ErrorBanner(message: authState.errorMessage!),

              authState.isAuthenticated
                  ? _AuthenticatedView(
                      state: authState,
                      onRefresh: () => authNotifier.refreshTokens(),
                      onLoadProfile: () => authNotifier.loadCurrentUser(),
                      onLogout: authNotifier.logout,
                    )
                  : _LoginForm(
                      formKey: _formKey,
                      usernameController: _usernameController,
                      passwordController: _passwordController,
                      obscurePassword: _obscurePassword,
                      onTogglePassword: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      onSubmit: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          authNotifier.login(
                            username: _usernameController.text.trim(),
                            password: _passwordController.text.trim(),
                            expiresInMins: 30,
                          );
                        }
                      },
                      isLoading: authState.isLoading,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
    required this.isLoading,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Login', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: onTogglePassword,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onSubmit,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Login'),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tip: DummyJSON provides sample credentials.\nUsername: emilys  /  Password: emilyspass',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthenticatedView extends StatelessWidget {
  const _AuthenticatedView({
    required this.state,
    required this.onRefresh,
    required this.onLoadProfile,
    required this.onLogout,
  });

  final AuthState state;
  final VoidCallback onRefresh;
  final VoidCallback onLoadProfile;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final user = state.user;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: user != null
                      ? NetworkImage(user.image)
                      : null,
                  child: user == null
                      ? const Icon(Icons.person, size: 32)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.username ?? 'Unknown',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (user != null)
                        Text('${user.firstName} ${user.lastName}'),
                      if (user != null)
                        Text(user.email, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: state.isLoading ? null : onLoadProfile,
                  icon: const Icon(Icons.person_search),
                  label: const Text('Load Profile'),
                ),
                ElevatedButton.icon(
                  onPressed: state.isLoading ? null : onRefresh,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Tokens'),
                ),
                OutlinedButton.icon(
                  onPressed: state.isLoading ? null : onLogout,
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (state.tokens != null) _TokenSection(tokens: state.tokens!),
            if (state.isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

class _TokenSection extends StatelessWidget {
  const _TokenSection({required this.tokens});

  final AuthTokensEntity tokens;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tokens', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        _TokenTile(label: 'Access Token', value: tokens.accessToken),
        const SizedBox(height: 8),
        _TokenTile(label: 'Refresh Token', value: tokens.refreshToken),
      ],
    );
  }
}

class _TokenTile extends StatelessWidget {
  const _TokenTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.redAccent),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
