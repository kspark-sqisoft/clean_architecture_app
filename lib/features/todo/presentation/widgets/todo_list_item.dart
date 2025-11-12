import 'package:flutter/material.dart';
import '../../domain/entities/todo_entity.dart';

/// TodoListItem - 할일 아이템 위젯
///
/// **역할:**
/// - 할일 정보를 표시합니다
/// - 완료 체크박스를 제공합니다
/// - 스와이프하여 삭제할 수 있습니다
class TodoListItem extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoListItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        // 스와이프 시 삭제 확인
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Todo'),
            content: const Text('Are you sure you want to delete this todo?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        onDelete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Todo "${todo.todo}" deleted'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // TODO: Implement undo functionality
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        elevation: 2,
        child: ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: (value) => onToggle(),
            activeColor: Colors.green,
          ),
          title: Text(
            todo.todo,
            style: TextStyle(
              decoration: todo.completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: todo.completed ? Colors.grey : Colors.black,
            ),
          ),
          subtitle: Text(
            'User ID: ${todo.userId}',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            onPressed: onDelete,
          ),
          onTap: onToggle,
        ),
      ),
    );
  }
}
