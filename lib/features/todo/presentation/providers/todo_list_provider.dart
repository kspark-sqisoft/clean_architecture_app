import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_all_todos.dart';
import '../../domain/usecases/update_todo.dart';
import 'todo_providers.dart';

part 'todo_list_provider.g.dart';

/// ============================================================================
/// TodoList 상태 관리 Provider
/// ============================================================================
///
/// **AsyncNotifier란?**
/// - 비동기 상태를 관리하는 Riverpod의 클래스입니다
/// - AsyncValue<T> 타입으로 로딩/데이터/에러 상태를 관리합니다
/// - StateNotifier의 비동기 버전입니다
///
/// **AsyncValue의 3가지 상태:**
/// 1. **Loading**: 데이터를 불러오는 중
/// 2. **Data**: 데이터 로드 성공
/// 3. **Error**: 데이터 로드 실패
///
/// **사용 예시 (UI):**
/// ```dart
/// final todoList = ref.watch(todoListProvider);
/// todoList.when(
///   loading: () => CircularProgressIndicator(),
///   data: (todos) => ListView(...),
///   error: (err, stack) => Text('Error: $err'),
/// );
/// ```

@riverpod
class TodoList extends _$TodoList {
  /// 초기 상태 빌드
  ///
  /// **build 메서드:**
  /// - Provider가 처음 생성될 때 호출됩니다
  /// - 초기 데이터를 로드하여 반환합니다
  @override
  Future<List<TodoEntity>> build() async {
    // GetAllTodos 유즈케이스를 가져옵니다
    final getAllTodos = ref.watch(getAllTodosProvider);

    // 유즈케이스를 실행합니다
    final result = await getAllTodos(const GetAllTodosParams());

    // Either<Failure, List<TodoEntity>>를 처리합니다
    return result.fold(
      (failure) {
        // 실패 시 에러를 throw하여 AsyncValue.error 상태로 전환
        throw failure;
      },
      (todos) {
        // 성공 시 데이터를 반환하여 AsyncValue.data 상태로 전환
        return todos;
      },
    );
  }

  /// 할일 목록을 새로고침합니다
  ///
  /// **사용 시나리오:**
  /// - Pull-to-refresh 기능
  /// - 데이터 변경 후 목록 갱신
  Future<void> refresh() async {
    // state를 AsyncLoading으로 변경
    state = const AsyncLoading();

    // 데이터를 다시 로드
    state = await AsyncValue.guard(() async {
      final getAllTodos = ref.read(getAllTodosProvider);
      final result = await getAllTodos(const GetAllTodosParams());

      return result.fold((failure) => throw failure, (todos) => todos);
    });
  }

  /// 페이지네이션으로 할일 목록을 가져옵니다
  Future<void> loadTodos({int? limit, int? skip}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final getAllTodos = ref.read(getAllTodosProvider);
      final result = await getAllTodos(
        GetAllTodosParams(limit: limit, skip: skip),
      );

      return result.fold((failure) => throw failure, (todos) => todos);
    });
  }

  /// 새로운 할일을 추가합니다
  ///
  /// **Optimistic Update:**
  /// - 서버 응답을 기다리지 않고 즉시 UI를 업데이트합니다
  /// - 실패하면 이전 상태로 롤백합니다
  /// - 사용자 경험(UX)을 향상시킵니다
  Future<void> addTodo({
    required String todo,
    required bool completed,
    required int userId,
  }) async {
    final addTodoUseCase = ref.read(addTodoProvider);

    final result = await addTodoUseCase(
      AddTodoParams(todo: todo, completed: completed, userId: userId),
    );

    result.fold(
      (failure) {
        // 실패 시 에러 상태로 전환
        state = AsyncError(failure, StackTrace.current);
      },
      (newTodo) {
        // 성공 시 목록에 추가
        state.whenData((todos) {
          state = AsyncData([...todos, newTodo]);
        });
      },
    );
  }

  /// 할일을 수정합니다
  Future<void> updateTodo({
    required int id,
    String? todo,
    bool? completed,
  }) async {
    final updateTodoUseCase = ref.read(updateTodoProvider);

    final result = await updateTodoUseCase(
      UpdateTodoParams(id: id, todo: todo, completed: completed),
    );

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (updatedTodo) {
        // 기존 목록에서 해당 아이템을 찾아 업데이트
        state.whenData((todos) {
          final updatedList = todos.map((t) {
            return t.id == id ? updatedTodo : t;
          }).toList();
          state = AsyncData(updatedList);
        });
      },
    );
  }

  /// 할일을 삭제합니다
  Future<void> deleteTodo(int id) async {
    final deleteTodoUseCase = ref.read(deleteTodoProvider);

    final result = await deleteTodoUseCase(id);

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (_) {
        // 성공 시 목록에서 제거
        state.whenData((todos) {
          final updatedList = todos.where((t) => t.id != id).toList();
          state = AsyncData(updatedList);
        });
      },
    );
  }

  /// 완료 상태를 토글합니다
  ///
  /// **편의 메서드:**
  /// - updateTodo를 호출하여 completed 상태만 변경합니다
  Future<void> toggleTodoCompletion(TodoEntity todo) async {
    await updateTodo(id: todo.id, completed: !todo.completed);
  }
}
