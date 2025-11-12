import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

/// GetTodosByUserId 유즈케이스
/// 특정 사용자의 모든 할일 목록을 가져옵니다
class GetTodosByUserId implements UseCase<List<TodoEntity>, int> {
  final TodoRepository repository;

  GetTodosByUserId(this.repository);

  @override
  Future<Either<Failure, List<TodoEntity>>> call(int userId) async {
    return await repository.getTodosByUserId(userId);
  }
}
