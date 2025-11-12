import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

/// GetTodoById 유즈케이스
/// 특정 ID의 할일을 가져옵니다
class GetTodoById implements UseCase<TodoEntity, int> {
  final TodoRepository repository;

  GetTodoById(this.repository);

  @override
  Future<Either<Failure, TodoEntity>> call(int id) async {
    return await repository.getTodoById(id);
  }
}
