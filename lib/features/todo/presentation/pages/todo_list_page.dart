import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_list_provider.dart';
import '../widgets/todo_list_item.dart';
import '../widgets/add_todo_dialog.dart';

/// TodoListPage - 할일 목록 페이지
///
/// **ConsumerWidget:**
/// - Riverpod의 Provider를 읽을 수 있는 StatelessWidget입니다
/// - WidgetRef를 통해 Provider에 접근합니다
///
/// **기능:**
/// - 할일 목록 표시
/// - Pull-to-refresh로 새로고침
/// - FloatingActionButton으로 할일 추가
/// - 각 아이템 클릭으로 완료 상태 토글
/// - 스와이프하여 삭제
class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // todoListProvider를 watch하여 상태 변화를 감지합니다
    final todoListAsync = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // 새로고침 버튼
              ref.read(todoListProvider.notifier).refresh();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: RefreshIndicator(
        // Pull-to-refresh 기능
        onRefresh: () async {
          await ref.read(todoListProvider.notifier).refresh();
        },
        child: todoListAsync.when(
          /// Loading 상태: 로딩 인디케이터 표시
          loading: () => const Center(child: CircularProgressIndicator()),

          /// Error 상태: 에러 메시지 표시
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error: $error',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(todoListProvider.notifier).refresh();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),

          /// Data 상태: 할일 목록 표시
          data: (todos) {
            if (todos.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No todos yet!',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the + button to add a new todo',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoListItem(
                  key: ValueKey(todo.id),
                  todo: todo,
                  onToggle: () {
                    // 완료 상태 토글
                    ref
                        .read(todoListProvider.notifier)
                        .toggleTodoCompletion(todo);
                  },
                  onDelete: () {
                    // 할일 삭제
                    _showDeleteConfirmation(context, ref, todo.id);
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // 할일 추가 다이얼로그 표시
          _showAddTodoDialog(context, ref);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Todo'),
      ),
    );
  }

  /// 할일 추가 다이얼로그 표시
  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AddTodoDialog(
        onAdd: (todo, userId) {
          ref
              .read(todoListProvider.notifier)
              .addTodo(todo: todo, completed: false, userId: userId);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// 삭제 확인 다이얼로그 표시
  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    int todoId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Todo'),
        content: const Text('Are you sure you want to delete this todo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(todoListProvider.notifier).deleteTodo(todoId);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
