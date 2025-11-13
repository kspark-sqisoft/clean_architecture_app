import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/error/exceptions.dart';
import 'package:clean_architectue_app/core/error/failures.dart';
import 'package:clean_architectue_app/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:clean_architectue_app/features/todo/data/models/todo_model.dart';
import 'package:clean_architectue_app/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:clean_architectue_app/features/todo/domain/entities/todo_entity.dart';

class _MockTodoRemoteDataSource extends Mock implements TodoRemoteDataSource {}

void main() {
  late _MockTodoRemoteDataSource remoteDataSource;
  late TodoRepositoryImpl repository;

  const tTodoId = 1;
  const tUserId = 5;
  const tLimit = 10;
  const tSkip = 0;

  final tTodoModel = TodoModel(
    id: tTodoId,
    todo: 'Buy milk',
    completed: false,
    userId: tUserId,
  );

  final tTodoModels = [
    tTodoModel,
    TodoModel(id: 2, todo: 'Walk the dog', completed: true, userId: tUserId),
  ];

  setUp(() {
    remoteDataSource = _MockTodoRemoteDataSource();
    repository = TodoRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  group('getAllTodos', () {
    test('원격 데이터 소스가 성공하면 TodoEntity 목록을 반환한다', () async {
      when(
        () => remoteDataSource.getAllTodos(
          limit: any(named: 'limit'),
          skip: any(named: 'skip'),
        ),
      ).thenAnswer((_) async => tTodoModels);

      final result = await repository.getAllTodos(limit: tLimit, skip: tSkip);

      expect(result, isA<Right<Failure, List<TodoEntity>>>());
      result.fold((failure) => fail('should not return failure'), (todos) {
        expect(todos.length, 2);
        expect(todos.first.id, tTodoId);
        expect(todos.first.todo, 'Buy milk');
      });

      verify(
        () => remoteDataSource.getAllTodos(limit: tLimit, skip: tSkip),
      ).called(1);
    });

    test('원격 데이터 소스가 예외를 던지면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.getAllTodos(
          limit: any(named: 'limit'),
          skip: any(named: 'skip'),
        ),
      ).thenThrow(ServerException('error'));

      final result = await repository.getAllTodos();

      expect(
        result,
        const Left<Failure, List<TodoEntity>>(Failure.server('error')),
      );
    });
  });

  group('getTodoById', () {
    test('성공하면 TodoEntity를 반환한다', () async {
      when(
        () => remoteDataSource.getTodoById(any()),
      ).thenAnswer((_) async => tTodoModel);

      final result = await repository.getTodoById(tTodoId);

      expect(result, isA<Right<Failure, TodoEntity>>());
      result.fold((failure) => fail('should not return failure'), (todo) {
        expect(todo.id, tTodoId);
        expect(todo.todo, 'Buy milk');
      });

      verify(() => remoteDataSource.getTodoById(tTodoId)).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.getTodoById(any()),
      ).thenThrow(ServerException('error'));

      final result = await repository.getTodoById(tTodoId);

      expect(result, const Left<Failure, TodoEntity>(Failure.server('error')));
    });
  });

  group('getTodosByUserId', () {
    test('성공하면 TodoEntity 목록을 반환한다', () async {
      when(
        () => remoteDataSource.getTodosByUserId(any()),
      ).thenAnswer((_) async => tTodoModels);

      final result = await repository.getTodosByUserId(tUserId);

      expect(result, isA<Right<Failure, List<TodoEntity>>>());
      result.fold((failure) => fail('should not return failure'), (todos) {
        expect(todos.length, 2);
        expect(todos.first.userId, tUserId);
      });

      verify(() => remoteDataSource.getTodosByUserId(tUserId)).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.getTodosByUserId(any()),
      ).thenThrow(ServerException('error'));

      final result = await repository.getTodosByUserId(tUserId);

      expect(
        result,
        const Left<Failure, List<TodoEntity>>(Failure.server('error')),
      );
    });
  });

  group('getRandomTodo', () {
    test('성공하면 TodoEntity를 반환한다', () async {
      when(
        () => remoteDataSource.getRandomTodo(),
      ).thenAnswer((_) async => tTodoModel);

      final result = await repository.getRandomTodo();

      expect(result, isA<Right<Failure, TodoEntity>>());
      result.fold(
        (failure) => fail('should not return failure'),
        (todo) => expect(todo.id, tTodoId),
      );

      verify(() => remoteDataSource.getRandomTodo()).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.getRandomTodo(),
      ).thenThrow(ServerException('error'));

      final result = await repository.getRandomTodo();

      expect(result, const Left<Failure, TodoEntity>(Failure.server('error')));
    });
  });

  group('addTodo', () {
    test('성공하면 TodoEntity를 반환한다', () async {
      when(
        () => remoteDataSource.addTodo(
          todo: any(named: 'todo'),
          completed: any(named: 'completed'),
          userId: any(named: 'userId'),
        ),
      ).thenAnswer((_) async => tTodoModel);

      final result = await repository.addTodo(
        todo: 'Buy milk',
        completed: false,
        userId: tUserId,
      );

      expect(result, isA<Right<Failure, TodoEntity>>());
      result.fold(
        (failure) => fail('should not return failure'),
        (todo) => expect(todo.todo, 'Buy milk'),
      );

      verify(
        () => remoteDataSource.addTodo(
          todo: 'Buy milk',
          completed: false,
          userId: tUserId,
        ),
      ).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.addTodo(
          todo: any(named: 'todo'),
          completed: any(named: 'completed'),
          userId: any(named: 'userId'),
        ),
      ).thenThrow(ServerException('error'));

      final result = await repository.addTodo(
        todo: 'Buy milk',
        completed: false,
        userId: tUserId,
      );

      expect(result, const Left<Failure, TodoEntity>(Failure.server('error')));
    });
  });

  group('updateTodo', () {
    test('성공하면 TodoEntity를 반환한다', () async {
      final updatedTodoModel = TodoModel(
        id: tTodoId,
        todo: 'Buy milk and eggs',
        completed: true,
        userId: tUserId,
      );

      when(
        () => remoteDataSource.updateTodo(
          id: any(named: 'id'),
          todo: any(named: 'todo'),
          completed: any(named: 'completed'),
        ),
      ).thenAnswer((_) async => updatedTodoModel);

      final result = await repository.updateTodo(
        id: tTodoId,
        todo: 'Buy milk and eggs',
        completed: true,
      );

      expect(result, isA<Right<Failure, TodoEntity>>());
      result.fold((failure) => fail('should not return failure'), (todo) {
        expect(todo.todo, 'Buy milk and eggs');
        expect(todo.completed, true);
      });

      verify(
        () => remoteDataSource.updateTodo(
          id: tTodoId,
          todo: 'Buy milk and eggs',
          completed: true,
        ),
      ).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.updateTodo(
          id: any(named: 'id'),
          todo: any(named: 'todo'),
          completed: any(named: 'completed'),
        ),
      ).thenThrow(ServerException('error'));

      final result = await repository.updateTodo(id: tTodoId, completed: true);

      expect(result, const Left<Failure, TodoEntity>(Failure.server('error')));
    });
  });

  group('deleteTodo', () {
    test('성공하면 void를 반환한다', () async {
      when(
        () => remoteDataSource.deleteTodo(any()),
      ).thenAnswer((_) async => Future.value());

      final result = await repository.deleteTodo(tTodoId);

      expect(result, isA<Right<Failure, void>>());
      verify(() => remoteDataSource.deleteTodo(tTodoId)).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.deleteTodo(any()),
      ).thenThrow(ServerException('error'));

      final result = await repository.deleteTodo(tTodoId);

      expect(result, const Left<Failure, void>(Failure.server('error')));
    });
  });
}
