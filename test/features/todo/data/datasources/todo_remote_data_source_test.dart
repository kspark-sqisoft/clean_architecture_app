import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/constants/api_constants.dart';
import 'package:clean_architectue_app/core/error/exceptions.dart';
import 'package:clean_architectue_app/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:clean_architectue_app/features/todo/data/models/todo_model.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  late _MockDio dio;
  late TodoRemoteDataSource dataSource;

  const tTodoId = 1;
  const tUserId = 5;
  const tLimit = 10;
  const tSkip = 0;

  final tTodoJson = {
    'id': tTodoId,
    'todo': 'Buy milk',
    'completed': false,
    'userId': tUserId,
  };

  final tTodosResponse = {
    'todos': [
      tTodoJson,
      {'id': 2, 'todo': 'Walk the dog', 'completed': true, 'userId': tUserId},
    ],
    'total': 150,
    'skip': 0,
    'limit': 10,
  };

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
    registerFallbackValue(Options());
  });

  setUp(() {
    dio = _MockDio();
    dataSource = TodoRemoteDataSourceImpl(dio: dio);
  });

  group('getAllTodos', () {
    test('should return List<TodoModel> when status code is 200', () async {
      final response = Response<dynamic>(
        data: tTodosResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.todos),
      );

      when(
        () => dio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => response);

      final result = await dataSource.getAllTodos(limit: tLimit, skip: tSkip);

      expect(result, isA<List<TodoModel>>());
      expect(result.length, 2);
      expect(result.first.id, tTodoId);
      expect(result.first.todo, 'Buy milk');

      verify(
        () => dio.get(
          ApiConstants.todos,
          queryParameters: {'limit': tLimit, 'skip': tSkip},
        ),
      ).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tTodosResponse,
        statusCode: 400,
        requestOptions: RequestOptions(path: ApiConstants.todos),
      );

      when(
        () => dio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => response);

      expect(
        () => dataSource.getAllTodos(limit: tLimit),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException on DioException', () async {
      when(
        () => dio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiConstants.todos),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(() => dataSource.getAllTodos(), throwsA(isA<ServerException>()));
    });
  });

  group('getTodoById', () {
    test('should return TodoModel when status code is 200', () async {
      final response = Response<dynamic>(
        data: tTodoJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.todoById(tTodoId)),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      final result = await dataSource.getTodoById(tTodoId);

      expect(result, isA<TodoModel>());
      expect(result.id, tTodoId);
      expect(result.todo, 'Buy milk');
      expect(result.completed, false);

      verify(() => dio.get(ApiConstants.todoById(tTodoId))).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tTodoJson,
        statusCode: 404,
        requestOptions: RequestOptions(path: ApiConstants.todoById(tTodoId)),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      expect(
        () => dataSource.getTodoById(tTodoId),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getTodosByUserId', () {
    test('should return List<TodoModel> when status code is 200', () async {
      final response = Response<dynamic>(
        data: tTodosResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.todosByUser(tUserId)),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      final result = await dataSource.getTodosByUserId(tUserId);

      expect(result, isA<List<TodoModel>>());
      expect(result.length, 2);
      expect(result.first.userId, tUserId);

      verify(() => dio.get(ApiConstants.todosByUser(tUserId))).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tTodosResponse,
        statusCode: 400,
        requestOptions: RequestOptions(path: ApiConstants.todosByUser(tUserId)),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      expect(
        () => dataSource.getTodosByUserId(tUserId),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getRandomTodo', () {
    test('should return TodoModel when status code is 200', () async {
      final response = Response<dynamic>(
        data: tTodoJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.randomTodo),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      final result = await dataSource.getRandomTodo();

      expect(result, isA<TodoModel>());
      expect(result.id, tTodoId);

      verify(() => dio.get(ApiConstants.randomTodo)).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tTodoJson,
        statusCode: 400,
        requestOptions: RequestOptions(path: ApiConstants.randomTodo),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      expect(() => dataSource.getRandomTodo(), throwsA(isA<ServerException>()));
    });
  });

  group('addTodo', () {
    test('should return TodoModel when status code is 200 or 201', () async {
      final response = Response<dynamic>(
        data: tTodoJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.addTodo),
      );

      when(
        () => dio.post(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => response);

      final result = await dataSource.addTodo(
        todo: 'Buy milk',
        completed: false,
        userId: tUserId,
      );

      expect(result, isA<TodoModel>());
      expect(result.todo, 'Buy milk');

      verify(
        () => dio.post(
          ApiConstants.addTodo,
          data: {'todo': 'Buy milk', 'completed': false, 'userId': tUserId},
        ),
      ).called(1);
    });

    test(
      'should throw ServerException when status code is not 200 or 201',
      () async {
        final response = Response<dynamic>(
          data: tTodoJson,
          statusCode: 400,
          requestOptions: RequestOptions(path: ApiConstants.addTodo),
        );

        when(
          () => dio.post(any(), data: any(named: 'data')),
        ).thenAnswer((_) async => response);

        expect(
          () => dataSource.addTodo(
            todo: 'Buy milk',
            completed: false,
            userId: tUserId,
          ),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });

  group('updateTodo', () {
    test('should return TodoModel when status code is 200', () async {
      final updatedTodoJson = {
        'id': tTodoId,
        'todo': 'Buy milk and eggs',
        'completed': true,
        'userId': tUserId,
      };

      final response = Response<dynamic>(
        data: updatedTodoJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.todoById(tTodoId)),
      );

      when(
        () => dio.put(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => response);

      final result = await dataSource.updateTodo(
        id: tTodoId,
        todo: 'Buy milk and eggs',
        completed: true,
      );

      expect(result, isA<TodoModel>());
      expect(result.todo, 'Buy milk and eggs');
      expect(result.completed, true);

      verify(
        () => dio.put(
          ApiConstants.todoById(tTodoId),
          data: {'todo': 'Buy milk and eggs', 'completed': true},
        ),
      ).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tTodoJson,
        statusCode: 400,
        requestOptions: RequestOptions(path: ApiConstants.todoById(tTodoId)),
      );

      when(
        () => dio.put(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => response);

      expect(
        () => dataSource.updateTodo(id: tTodoId, completed: true),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('deleteTodo', () {
    test('should return void when status code is 200', () async {
      final response = Response<dynamic>(
        data: {},
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.todoById(tTodoId)),
      );

      when(() => dio.delete(any())).thenAnswer((_) async => response);

      await dataSource.deleteTodo(tTodoId);

      verify(() => dio.delete(ApiConstants.todoById(tTodoId))).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: {},
        statusCode: 400,
        requestOptions: RequestOptions(path: ApiConstants.todoById(tTodoId)),
      );

      when(() => dio.delete(any())).thenAnswer((_) async => response);

      expect(
        () => dataSource.deleteTodo(tTodoId),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
