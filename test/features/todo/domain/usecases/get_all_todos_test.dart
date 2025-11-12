import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/error/failures.dart';
import 'package:clean_architectue_app/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architectue_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:clean_architectue_app/features/todo/domain/usecases/get_all_todos.dart';

class _MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late _MockTodoRepository repository;
  late GetAllTodos usecase;

  const tLimit = 10;
  const tSkip = 0;

  final tTodos = [
    const TodoEntity(id: 1, todo: 'Buy milk', completed: false, userId: 5),
    const TodoEntity(id: 2, todo: 'Walk the dog', completed: true, userId: 5),
  ];

  setUp(() {
    repository = _MockTodoRepository();
    usecase = GetAllTodos(repository);
  });

  test('should call repository and return List<TodoEntity>', () async {
    when(
      () => repository.getAllTodos(
        limit: any(named: 'limit'),
        skip: any(named: 'skip'),
      ),
    ).thenAnswer((_) async => Right(tTodos));

    const params = GetAllTodosParams(limit: tLimit, skip: tSkip);
    final result = await usecase(params);

    expect(result, Right(tTodos));
    verify(() => repository.getAllTodos(limit: tLimit, skip: tSkip)).called(1);
  });

  test('should return Failure when repository fails', () async {
    when(
      () => repository.getAllTodos(
        limit: any(named: 'limit'),
        skip: any(named: 'skip'),
      ),
    ).thenAnswer((_) async => const Left(Failure.server('error')));

    const params = GetAllTodosParams();
    final result = await usecase(params);

    expect(result, const Left(Failure.server('error')));
  });
}
