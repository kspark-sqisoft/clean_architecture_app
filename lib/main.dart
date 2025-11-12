import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/providers/theme_mode_provider.dart';

/// ============================================================================
/// 메인 진입점
/// ============================================================================
///
/// **클린 아키텍처 + Features 구조:**
///
/// ```
/// lib/
/// ├── core/                      # 공통 기능
/// │   ├── error/                # 에러 처리 (Failures, Exceptions)
/// │   ├── usecase/              # UseCase 베이스 클래스
/// │   ├── network/              # API 클라이언트 (Dio)
/// │   ├── constants/            # 상수 (API 엔드포인트)
/// │   ├── router/               # 라우팅 (GoRouter)
/// │   └── theme/                # 앱 테마
/// │
/// └── features/                 # 기능별 모듈
///     └── todo/                 # Todo 기능
///         ├── domain/           # 도메인 레이어
///         │   ├── entities/    # TodoEntity (비즈니스 객체)
///         │   ├── repositories/ # TodoRepository (인터페이스)
///         │   └── usecases/    # 비즈니스 로직
///         │
///         ├── data/            # 데이터 레이어
///         │   ├── models/      # TodoModel (JSON 직렬화)
///         │   ├── datasources/ # API 호출
///         │   └── repositories/ # Repository 구현
///         │
///         └── presentation/     # 프레젠테이션 레이어
///             ├── providers/   # Riverpod Providers (상태 관리)
///             ├── pages/       # 화면 (TodoListPage)
///             └── widgets/     # 위젯 (TodoListItem, AddTodoDialog)
/// ```
///
/// **의존성 흐름 (Dependency Flow):**
/// ```
/// Presentation Layer
///     ↓ 의존
/// Domain Layer (Entities, UseCases, Repository Interface)
///     ↑ 구현
/// Data Layer (Models, DataSources, Repository Implementation)
/// ```
///
/// **핵심 개념:**
///
/// 1. **의존성 역전 원칙 (DIP):**
///    - Domain Layer는 최상위 레이어입니다
///    - Data Layer가 Domain을 의존합니다 (반대가 아님)
///    - 이를 통해 비즈니스 로직은 외부 변경에 영향받지 않습니다
///
/// 2. **의존성 주입 (DI with Riverpod):**
///    - Provider를 통해 필요한 의존성을 주입받습니다
///    - 테스트 시 Mock 객체로 쉽게 교체 가능합니다
///    - 컴파일 타임에 타입 안정성을 보장합니다
///
/// 3. **관심사의 분리 (Separation of Concerns):**
///    - Domain: "무엇을" (비즈니스 로직)
///    - Data: "어떻게" (데이터 가져오기)
///    - Presentation: "어떻게 보여줄지" (UI)
///
/// 4. **단일 책임 원칙 (SRP):**
///    - 각 클래스는 하나의 책임만 가집니다
///    - UseCase는 하나의 기능만 수행합니다
///    - 변경 이유가 하나만 있어야 합니다
///
/// **사용된 라이브러리:**
/// - flutter_riverpod: 상태 관리 및 의존성 주입
/// - riverpod_annotation & riverpod_generator: 코드 생성
/// - freezed: 불변 객체 생성
/// - json_serializable: JSON 직렬화
/// - dartz: 함수형 프로그래밍 (Either)
/// - dio: HTTP 클라이언트
/// - go_router: 선언적 라우팅

void main() {
  runApp(
    // ProviderScope: Riverpod의 루트 위젯
    // - 모든 Provider를 관리합니다
    // - 의존성 주입의 시작점입니다
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Clean Architecture Todo App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: AppRouter.router,
    );
  }
}
