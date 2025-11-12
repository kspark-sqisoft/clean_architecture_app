import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/todo_repository.dart';

/// DeleteTodo 유즈케이스
/// 할일을 삭제합니다
class DeleteTodo implements UseCase<void, int> {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteTodo(id);
  }
}
