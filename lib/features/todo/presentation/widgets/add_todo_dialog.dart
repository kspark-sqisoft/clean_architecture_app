import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// AddTodoDialog - 할일 추가 다이얼로그
///
/// **역할:**
/// - 새로운 할일을 추가하는 폼을 제공합니다
/// - 할일 내용과 사용자 ID를 입력받습니다
/// - 입력 유효성 검사를 수행합니다
class AddTodoDialog extends StatefulWidget {
  final Function(String todo, int userId) onAdd;

  const AddTodoDialog({super.key, required this.onAdd});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _todoController = TextEditingController();
  final _userIdController = TextEditingController(text: '1');

  @override
  void dispose() {
    _todoController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final todo = _todoController.text.trim();
      final userId = int.parse(_userIdController.text);
      widget.onAdd(todo, userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Todo'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _todoController,
              decoration: const InputDecoration(
                labelText: 'Todo',
                hintText: 'Enter your todo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a todo';
                }
                if (value.trim().length < 3) {
                  return 'Todo must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'User ID',
                hintText: 'Enter user ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a user ID';
                }
                final userId = int.tryParse(value);
                if (userId == null || userId < 1) {
                  return 'Please enter a valid user ID';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}
