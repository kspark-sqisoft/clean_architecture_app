// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRemoteDataSourceHash() =>
    r'c43342f6fb5083cd4d762ba25bcbb8bd4b80bf43';

/// ============================================================================
/// 의존성 주입 (Dependency Injection) with Riverpod
/// ============================================================================
///
/// **의존성 주입이란?**
/// - 객체가 필요한 의존성을 외부에서 주입받는 패턴입니다
/// - 직접 생성하지 않고 외부에서 받아옵니다
///
/// **Riverpod의 장점:**
/// 1. **컴파일 타임 안정성**: Provider가 존재하지 않으면 컴파일 에러
/// 2. **테스트 용이성**: Provider를 쉽게 Mock으로 교체 가능
/// 3. **자동 dispose**: 위젯이 제거되면 자동으로 리소스 해제
/// 4. **코드 생성**: riverpod_generator로 보일러플레이트 감소
///
/// **의존성 흐름:**
/// ```
/// Dio (HTTP Client)
///   ↓ 주입
/// TodoRemoteDataSource
///   ↓ 주입
/// TodoRepository
///   ↓ 주입
/// UseCases
///   ↓ 사용
/// UI (Widget)
/// ```
/// TodoRemoteDataSource Provider
///
/// **의존성 주입 예시:**
/// - dio를 ref.watch로 가져와서 주입합니다
/// - dio가 변경되면 자동으로 재생성됩니다
///
/// Copied from [todoRemoteDataSource].
@ProviderFor(todoRemoteDataSource)
final todoRemoteDataSourceProvider =
    AutoDisposeProvider<TodoRemoteDataSource>.internal(
      todoRemoteDataSource,
      name: r'todoRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todoRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodoRemoteDataSourceRef = AutoDisposeProviderRef<TodoRemoteDataSource>;
String _$todoRepositoryHash() => r'106c134014080fc390f32f49f7a1e57e0b763a33';

/// TodoRepository Provider
///
/// **Repository 주입:**
/// - 인터페이스(TodoRepository)를 반환하지만
/// - 실제로는 구현체(TodoRepositoryImpl)를 생성합니다
/// - 이를 통해 Domain Layer는 Data Layer의 구현을 알 필요가 없습니다
///
/// Copied from [todoRepository].
@ProviderFor(todoRepository)
final todoRepositoryProvider = AutoDisposeProvider<TodoRepository>.internal(
  todoRepository,
  name: r'todoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodoRepositoryRef = AutoDisposeProviderRef<TodoRepository>;
String _$getAllTodosHash() => r'4b3133e3b5b2806fc8e265ef415a2dd221280c5e';

/// ============================================================================
/// UseCase Providers - 각 비즈니스 기능별 Provider
/// ============================================================================
///
/// Copied from [getAllTodos].
@ProviderFor(getAllTodos)
final getAllTodosProvider = AutoDisposeProvider<GetAllTodos>.internal(
  getAllTodos,
  name: r'getAllTodosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllTodosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAllTodosRef = AutoDisposeProviderRef<GetAllTodos>;
String _$getTodoByIdHash() => r'da7161d630ad8e7d167f0a6bced504def1cbbdaa';

/// See also [getTodoById].
@ProviderFor(getTodoById)
final getTodoByIdProvider = AutoDisposeProvider<GetTodoById>.internal(
  getTodoById,
  name: r'getTodoByIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTodoByIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetTodoByIdRef = AutoDisposeProviderRef<GetTodoById>;
String _$getTodosByUserIdHash() => r'82ddbc366cb35d64982202c22ddb04f5c1aca372';

/// See also [getTodosByUserId].
@ProviderFor(getTodosByUserId)
final getTodosByUserIdProvider = AutoDisposeProvider<GetTodosByUserId>.internal(
  getTodosByUserId,
  name: r'getTodosByUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTodosByUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetTodosByUserIdRef = AutoDisposeProviderRef<GetTodosByUserId>;
String _$getRandomTodoHash() => r'c934ffba954598db7072f70a888dede973e439c8';

/// See also [getRandomTodo].
@ProviderFor(getRandomTodo)
final getRandomTodoProvider = AutoDisposeProvider<GetRandomTodo>.internal(
  getRandomTodo,
  name: r'getRandomTodoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getRandomTodoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetRandomTodoRef = AutoDisposeProviderRef<GetRandomTodo>;
String _$addTodoHash() => r'618e87a218398d5234ab8378270e8ad6d66b8cc2';

/// See also [addTodo].
@ProviderFor(addTodo)
final addTodoProvider = AutoDisposeProvider<AddTodo>.internal(
  addTodo,
  name: r'addTodoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addTodoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AddTodoRef = AutoDisposeProviderRef<AddTodo>;
String _$updateTodoHash() => r'a16e7d82834e2a23300c01c4bf447a927b591693';

/// See also [updateTodo].
@ProviderFor(updateTodo)
final updateTodoProvider = AutoDisposeProvider<UpdateTodo>.internal(
  updateTodo,
  name: r'updateTodoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateTodoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpdateTodoRef = AutoDisposeProviderRef<UpdateTodo>;
String _$deleteTodoHash() => r'f88484e544b82c8e27d56b04d01a7d73606ee963';

/// See also [deleteTodo].
@ProviderFor(deleteTodo)
final deleteTodoProvider = AutoDisposeProvider<DeleteTodo>.internal(
  deleteTodo,
  name: r'deleteTodoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteTodoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeleteTodoRef = AutoDisposeProviderRef<DeleteTodo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
