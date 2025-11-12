import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

/// UpdateTodo 유즈케이스
/// 기존 할일을 수정합니다
class UpdateTodo implements UseCase<TodoEntity, UpdateTodoParams> {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<Either<Failure, TodoEntity>> call(UpdateTodoParams params) async {
    return await repository.updateTodo(
      id: params.id,
      todo: params.todo,
      completed: params.completed,
    );
  }
}

class UpdateTodoParams {
  final int id;
  final String? todo;
  final bool? completed;

  const UpdateTodoParams({required this.id, this.todo, this.completed});
}
