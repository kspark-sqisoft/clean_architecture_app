import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/todo_remote_datasource.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_all_todos.dart';
import '../../domain/usecases/get_random_todo.dart';
import '../../domain/usecases/get_todo_by_id.dart';
import '../../domain/usecases/get_todos_by_user_id.dart';
import '../../domain/usecases/update_todo.dart';

part 'todo_providers.g.dart';

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
@riverpod
TodoRemoteDataSource todoRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return TodoRemoteDataSourceImpl(dio: dio);
}

/// TodoRepository Provider
///
/// **Repository 주입:**
/// - 인터페이스(TodoRepository)를 반환하지만
/// - 실제로는 구현체(TodoRepositoryImpl)를 생성합니다
/// - 이를 통해 Domain Layer는 Data Layer의 구현을 알 필요가 없습니다
@riverpod
TodoRepository todoRepository(Ref ref) {
  final remoteDataSource = ref.watch(todoRemoteDataSourceProvider);
  return TodoRepositoryImpl(remoteDataSource: remoteDataSource);
}

/// ============================================================================
/// UseCase Providers - 각 비즈니스 기능별 Provider
/// ============================================================================

@riverpod
GetAllTodos getAllTodos(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetAllTodos(repository);
}

@riverpod
GetTodoById getTodoById(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetTodoById(repository);
}

@riverpod
GetTodosByUserId getTodosByUserId(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetTodosByUserId(repository);
}

@riverpod
GetRandomTodo getRandomTodo(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetRandomTodo(repository);
}

@riverpod
AddTodo addTodo(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return AddTodo(repository);
}

@riverpod
UpdateTodo updateTodo(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return UpdateTodo(repository);
}

@riverpod
DeleteTodo deleteTodo(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return DeleteTodo(repository);
}
