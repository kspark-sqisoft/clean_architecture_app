import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

/// AddTodo 유즈케이스
/// 새로운 할일을 추가합니다
class AddTodo implements UseCase<TodoEntity, AddTodoParams> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, TodoEntity>> call(AddTodoParams params) async {
    return await repository.addTodo(
      todo: params.todo,
      completed: params.completed,
      userId: params.userId,
    );
  }
}

class AddTodoParams {
  final String todo;
  final bool completed;
  final int userId;

  const AddTodoParams({
    required this.todo,
    required this.completed,
    required this.userId,
  });
}
