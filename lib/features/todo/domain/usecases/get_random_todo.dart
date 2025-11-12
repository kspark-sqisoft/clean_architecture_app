import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

/// GetRandomTodo 유즈케이스
/// 랜덤 할일을 가져옵니다 (DummyJSON 특별 기능)
class GetRandomTodo implements UseCase<TodoEntity, NoParams> {
  final TodoRepository repository;

  GetRandomTodo(this.repository);

  @override
  Future<Either<Failure, TodoEntity>> call(NoParams params) async {
    return await repository.getRandomTodo();
  }
}
