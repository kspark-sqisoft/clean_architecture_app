import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/todo/presentation/pages/todo_list_page.dart';
import '../../features/product/presentation/pages/product_list_page.dart';
import '../../features/product/presentation/pages/product_detail_page.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../theme/providers/theme_mode_provider.dart';

/// AppRouter - 앱 라우팅 설정
///
/// **라우트 구조:**
/// ```
/// / (home) → HomePage (Todo와 Product 선택)
/// /todos → TodoListPage
/// /products → ProductListPage
/// /products/:id → ProductDetailPage
/// ```
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Home Page
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // Todo Routes
      GoRoute(
        path: '/todos',
        name: 'todos',
        builder: (context, state) => const TodoListPage(),
      ),

      // Product Routes
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductListPage(),
      ),

      GoRoute(
        path: '/products/:id',
        name: 'productDetail',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ProductDetailPage(productId: id);
        },
      ),

      // Auth Routes
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthPage(),
      ),
    ],

    // 에러 처리
    errorBuilder: (context, state) => const HomePage(),

    // 디버그 로그 (개발 환경에서만)
    debugLogDiagnostics: true,
  );
}

/// HomePage - 홈 화면 (Feature 선택)
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
            icon: Icon(
              isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            ),
            tooltip: isDark ? '라이트 모드로 전환' : '다크 모드로 전환',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose a Feature',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 48),

              // Todo Feature Card
              _FeatureCard(
                icon: Icons.check_circle_outline,
                title: 'Todos',
                description: 'Manage your daily tasks',
                color: Theme.of(context).colorScheme.primary,
                onTap: () => context.push('/todos'),
              ),

              const SizedBox(height: 16),

              // Product Feature Card
              _FeatureCard(
                icon: Icons.shopping_bag_outlined,
                title: 'Products',
                description: 'Browse product catalog',
                color: Theme.of(context).colorScheme.secondary,
                onTap: () => context.push('/products'),
              ),

              const SizedBox(height: 16),

              // Auth Feature Card
              _FeatureCard(
                icon: Icons.lock_outline,
                title: 'Auth',
                description: 'Login & manage session',
                color: Theme.of(context).colorScheme.tertiary,
                onTap: () => context.push('/auth'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
