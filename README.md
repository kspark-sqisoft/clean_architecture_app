# 🚀 Clean Architecture Todo App

Flutter 클린 아키텍처 샘플 프로젝트 - DummyJSON Todos / Products / Auth API 활용

## 📋 프로젝트 소개

이 프로젝트는 **클린 아키텍처(Clean Architecture)**와 **Feature-first** 구조를 결합하여 만든 데모 앱입니다. [DummyJSON Todos API](https://dummyjson.com/docs/todos), [DummyJSON Products API](https://dummyjson.com/docs/products), [DummyJSON Auth API](https://dummyjson.com/docs/auth)를 활용하여 RESTful API 통신을 구현했습니다.

## 🏗️ 아키텍처 구조

### 클린 아키텍처 레이어

```
┌─────────────────────────────────────┐
│     Presentation Layer (UI)         │  ← 사용자 인터페이스
│   (Widgets, Pages, Providers)       │
├─────────────────────────────────────┤
│      Domain Layer (Business)        │  ← 비즈니스 로직
│  (Entities, UseCases, Repository    │
│         Interfaces)                 │
├─────────────────────────────────────┤
│       Data Layer (Data)             │  ← 데이터 처리
│  (Models, DataSources, Repository   │
│      Implementations)               │
└─────────────────────────────────────┘
```

### 프로젝트 구조

```
lib/
├── core/                           # 공통 기능
│   ├── error/                     # 에러 처리
│   │   ├── failures.dart         # Failure 클래스 (freezed)
│   │   └── exceptions.dart       # Exception 클래스
│   ├── usecase/                  # UseCase 베이스
│   │   └── usecase.dart          # UseCase 추상 클래스
│   ├── network/                  # 네트워크
│   │   ├── api_client.dart       # Dio 클라이언트 설정
│   │   └── logger_interceptor.dart # Logger 인터셉터
│   ├── logger/                   # 로깅
│   │   └── app_logger.dart       # Logger 설정
│   ├── constants/                # 상수
│   │   └── api_constants.dart    # API 엔드포인트
│   ├── providers/                # 공통 프로바이더
│   │   └── dio_provider.dart     # Dio Provider (Riverpod)
│   ├── router/                   # 라우팅
│   │   └── app_router.dart       # GoRouter 설정
│   └── theme/                    # 테마
│       └── app_theme.dart        # Material 3 테마
│
└── features/                      # 기능별 모듈
    ├── todo/                      # Todo 기능
        ├── domain/                # 도메인 레이어
        │   ├── entities/
        │   │   └── todo_entity.dart       # Todo 엔티티
        │   ├── repositories/
        │   │   └── todo_repository.dart   # Repository 인터페이스
        │   └── usecases/                  # 비즈니스 로직
        │       ├── get_all_todos.dart
        │       ├── get_todo_by_id.dart
        │       ├── get_todos_by_user_id.dart
        │       ├── get_random_todo.dart
        │       ├── add_todo.dart
        │       ├── update_todo.dart
        │       └── delete_todo.dart
        │
        ├── data/                  # 데이터 레이어
        │   ├── models/
        │   │   └── todo_model.dart        # TodoModel (JSON)
        │   ├── datasources/
        │   │   └── todo_remote_datasource.dart  # API 호출
        │   └── repositories/
        │       └── todo_repository_impl.dart    # Repository 구현
        │
        └── presentation/          # 프레젠테이션 레이어
            ├── providers/
            │   ├── todo_providers.dart        # 의존성 주입
            │   └── todo_list_provider.dart    # 상태 관리
            ├── pages/
            │   └── todo_list_page.dart        # 할일 목록 화면
            └── widgets/
                ├── todo_list_item.dart        # 할일 아이템
                └── add_todo_dialog.dart       # 추가 다이얼로그
    |
    ├── product/                   # Product 기능
    │   ├── domain/
    │   ├── data/
    │   └── presentation/
    │       ├── providers/
    │       └── pages/             # 목록/상세 페이지
    |
    └── auth/                      # Auth 기능
        ├── domain/
        ├── data/
        └── presentation/
            ├── providers/
            └── pages/             # 로그인 & 프로필 화면
```

## 🎯 핵심 개념

### 1. 의존성 역전 원칙 (DIP)

```
Domain Layer (고수준)
    ↑ 의존
    Repository Interface
    ↑ 구현
Data Layer (저수준)
    Repository Implementation
```

- **Domain Layer**는 추상화(인터페이스)에 의존합니다
- **Data Layer**가 Domain을 구현합니다
- 비즈니스 로직이 외부 변경에 영향받지 않습니다

### 2. 의존성 주입 (DI with Riverpod)

```dart
// Provider를 통한 의존성 주입
@riverpod
Dio dio(DioRef ref) => ApiClient().dio;

@riverpod
TodoRemoteDataSource todoRemoteDataSource(TodoRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  return TodoRemoteDataSourceImpl(dio: dio);
}

@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref) {
  final remoteDataSource = ref.watch(todoRemoteDataSourceProvider);
  return TodoRepositoryImpl(remoteDataSource: remoteDataSource);
}
```

### 3. Either 타입으로 에러 처리 (dartz)

```dart
// Either<Failure, Success>
Future<Either<Failure, List<TodoEntity>>> getAllTodos();

// 사용 예시
final result = await useCase(params);
result.fold(
  (failure) => print('Error: $failure'),  // Left
  (data) => print('Success: $data'),      // Right
);
```

### 4. Entity vs Model

**Entity (Domain Layer)**

- 순수한 비즈니스 객체
- JSON, DB 등 외부 의존성 없음
- 불변 객체

**Model (Data Layer)**

- JSON 직렬화/역직렬화 가능
- API 응답 구조와 매칭
- Entity로 변환 가능

```dart
// Model을 Entity로 변환
TodoEntity toEntity() => TodoEntity(...);

// Entity를 Model로 변환
TodoModel toModel() => TodoModel(...);
```

## 📚 사용된 라이브러리

### Runtime Dependencies

| 라이브러리          | 버전    | 설명                               |
| ------------------- | ------- | ---------------------------------- |
| flutter_riverpod    | ^2.6.1  | 상태 관리 및 의존성 주입           |
| riverpod_annotation | ^2.6.1  | Riverpod 코드 생성 애노테이션      |
| freezed_annotation  | ^2.4.4  | 불변 객체 생성 애노테이션          |
| json_annotation     | ^4.9.0  | JSON 직렬화 애노테이션             |
| dartz               | ^0.10.1 | 함수형 프로그래밍 (Either, Option) |
| dio                 | ^5.7.0  | HTTP 클라이언트                    |
| go_router           | ^14.6.2 | 선언적 라우팅                      |
| logger              | ^2.4.0  | 로깅 유틸리티                      |

### Dev Dependencies

| 라이브러리         | 버전    | 설명                    |
| ------------------ | ------- | ----------------------- |
| build_runner       | ^2.4.13 | 코드 생성 실행          |
| riverpod_generator | ^2.6.2  | Riverpod 코드 생성기    |
| freezed            | ^2.5.7  | 불변 객체 코드 생성기   |
| json_serializable  | ^6.8.0  | JSON 직렬화 코드 생성기 |

## 🚀 시작하기

### 1. 의존성 설치

```bash
flutter pub get
```

### 2. 코드 생성

```bash
# freezed, json_serializable, riverpod_generator 실행
dart run build_runner build --delete-conflicting-outputs

# 또는 watch 모드 (파일 변경 시 자동 생성)
dart run build_runner watch --delete-conflicting-outputs
```

### ⚠️ 코드 생성 에러 발생 시

현재 `analyzer_plugin` 버전 충돌로 코드 생성이 실패할 수 있습니다.  
이는 일시적인 패키지 호환성 문제입니다.

**해결 방법은 `docs/CODE_GENERATION_GUIDE.md` 파일을 참고하세요.**

간단한 해결책:

```bash
# pub cache 정리 후 재시도
flutter pub cache clean
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

또는 1-2주 후 Flutter/Dart 패키지가 업데이트되면 자동으로 해결됩니다.

### 3. 앱 실행

```bash
flutter run
```

## 🔧 코드 생성이 필요한 파일

다음 파일들은 `build_runner`가 자동으로 생성합니다:

- `*.freezed.dart` - freezed 패키지
- `*.g.dart` - json_serializable, riverpod_generator
- `failures.freezed.dart`
- `todo_entity.freezed.dart`
- `todo_model.freezed.dart` & `todo_model.g.dart`
- `todo_providers.g.dart`
- `todo_list_provider.g.dart`
- `product_entity.freezed.dart`
- `product_model.freezed.dart` & `product_model.g.dart`
- `product_providers.g.dart`
- `product_list_provider.g.dart`
- `auth_user_entity.freezed.dart`
- `auth_tokens_entity.freezed.dart`
- `auth_session_entity.freezed.dart`
- `auth_user_model.freezed.dart` & `auth_user_model.g.dart`
- `auth_tokens_model.freezed.dart` & `auth_tokens_model.g.dart`
- `auth_session_model.freezed.dart` & `auth_session_model.g.dart`
- `auth_providers.g.dart`
- `auth_controller.g.dart`
- `auth_state.freezed.dart`

## 📱 주요 기능

✅ **할일 목록 조회** - DummyJSON API에서 할일 목록을 가져옵니다  
✅ **할일 추가** - 새로운 할일을 추가합니다 (서버 시뮬레이션)  
✅ **할일 수정** - 완료 상태를 토글합니다 (서버 시뮬레이션)  
✅ **할일 삭제** - 할일을 삭제합니다 (서버 시뮬레이션)  
✅ **Pull-to-Refresh** - 아래로 당겨서 새로고침  
✅ **에러 처리** - Either 타입으로 명시적 에러 처리  
✅ **로딩 상태** - AsyncValue로 로딩/데이터/에러 상태 관리  
✅ **Material 3** - 최신 Material Design 적용  
✅ **상품 카탈로그** - DummyJSON Products API 기반 목록 & 상세 화면  
✅ **인증 데모** - DummyJSON Auth API 로그인 / 토큰 갱신 / 프로필 조회 [[Docs]](https://dummyjson.com/docs/auth)

## 🎨 UI 스크린샷

- 할일 목록 화면
- 할일 추가 다이얼로그
- 완료 상태 토글
- 스와이프 삭제
- 에러 화면

## 📖 학습 포인트

### 클린 아키텍처

1. **관심사의 분리**: Domain, Data, Presentation 레이어 분리
2. **의존성 역전**: 고수준 모듈이 저수준 모듈에 의존하지 않음
3. **테스트 용이성**: 각 레이어를 독립적으로 테스트 가능

### 디자인 패턴

1. **Repository Pattern**: 데이터 소스 추상화
2. **UseCase Pattern**: 비즈니스 로직 캡슐화
3. **Dependency Injection**: Riverpod을 통한 DI

### Flutter 베스트 프랙티스

1. **Immutable Objects**: freezed로 불변 객체 생성
2. **Type Safety**: Either 타입으로 타입 안전한 에러 처리
3. **Code Generation**: 보일러플레이트 코드 자동 생성
4. **State Management**: Riverpod으로 선언적 상태 관리
5. **Logging**: logger 패키지로 구조화된 로그 출력

### 로깅 사용법

프로젝트에서는 `logger` 패키지를 사용하여 구조화된 로그를 출력합니다.

```dart
import 'package:clean_architectue_app/core/logger/app_logger.dart';

// 로그 레벨별 사용
appLogger.d('Debug 메시지');      // 개발 중 디버깅
appLogger.i('Info 메시지');       // 일반 정보
appLogger.w('Warning 메시지');    // 경고
appLogger.e('Error 메시지',       // 에러 (예외 포함 가능)
  error: exception,
  stackTrace: stackTrace,
);
```

HTTP 요청/응답은 자동으로 `LoggerInterceptor`를 통해 로깅됩니다.

## 🔗 참고 자료

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [DummyJSON Todos](https://dummyjson.com/docs/todos)
- [DummyJSON Products](https://dummyjson.com/docs/products)
- [DummyJSON Auth](https://dummyjson.com/docs/auth)
- [Riverpod Documentation](https://riverpod.dev/)
- [Freezed Package](https://pub.dev/packages/freezed)
- [Dartz Package](https://pub.dev/packages/dartz)
- [GoRouter Package](https://pub.dev/packages/go_router)
- [Logger Package](https://pub.dev/packages/logger)

## 📝 라이센스

이 프로젝트는 학습 목적으로 만들어졌습니다.

## 👨‍💻 작성자

Clean Architecture Todo App - Flutter 샘플 프로젝트

---

**Happy Coding! 🎉**
# clean_architecture_app
