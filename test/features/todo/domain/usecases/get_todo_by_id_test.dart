import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/error/failures.dart';
import 'package:clean_architectue_app/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architectue_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:clean_architectue_app/features/todo/domain/usecases/get_todo_by_id.dart';

class _MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late _MockTodoRepository repository;
  late GetTodoById usecase;

  const tTodoId = 1;

  const tTodo = TodoEntity(
    id: tTodoId,
    todo: 'Buy milk',
    completed: false,
    userId: 5,
  );

  setUp(() {
    repository = _MockTodoRepository();
    usecase = GetTodoById(repository);
  });

  test('ID로 레포지토리를 호출하면 TodoEntity를 반환한다', () async {
    when(
      () => repository.getTodoById(any()),
    ).thenAnswer((_) async => const Right(tTodo));

    final result = await usecase(tTodoId);

    expect(result, const Right(tTodo));
    verify(() => repository.getTodoById(tTodoId)).called(1);
  });

  test('레포지토리가 실패하면 Failure를 반환한다', () async {
    when(
      () => repository.getTodoById(any()),
    ).thenAnswer((_) async => const Left(Failure.server('error')));

    final result = await usecase(tTodoId);

    expect(result, const Left(Failure.server('error')));
  });
}
