import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/todo_model.dart';

/// TodoRemoteDataSource 추상 클래스
///
/// **DataSource란?**
/// - 실제 데이터를 가져오는 구체적인 방법을 정의합니다
/// - Remote: API 호출
/// - Local: 로컬 DB, SharedPreferences 등
///
/// **왜 추상 클래스를 사용할까?**
/// - 테스트 시 Mock 객체로 쉽게 교체 가능
/// - 다른 API로 교체할 때 유연하게 대응
abstract class TodoRemoteDataSource {
  /// 모든 할일 목록을 가져옵니다
  Future<List<TodoModel>> getAllTodos({int? limit, int? skip});

  /// 특정 ID의 할일을 가져옵니다
  Future<TodoModel> getTodoById(int id);

  /// 특정 사용자의 할일 목록을 가져옵니다
  Future<List<TodoModel>> getTodosByUserId(int userId);

  /// 랜덤 할일을 가져옵니다
  Future<TodoModel> getRandomTodo();

  /// 새로운 할일을 추가합니다
  Future<TodoModel> addTodo({
    required String todo,
    required bool completed,
    required int userId,
  });

  /// 할일을 수정합니다
  Future<TodoModel> updateTodo({
    required int id,
    String? todo,
    bool? completed,
  });

  /// 할일을 삭제합니다
  Future<void> deleteTodo(int id);
}

/// TodoRemoteDataSourceImpl - 실제 API 호출 구현
///
/// **구현 원칙:**
/// - 성공 시: 데이터 반환
/// - 실패 시: Exception throw
/// - Repository에서 Exception을 catch하여 Failure로 변환
class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final Dio dio;

  TodoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TodoModel>> getAllTodos({int? limit, int? skip}) async {
    try {
      final response = await dio.get(
        ApiConstants.todos,
        queryParameters: {
          if (limit != null) 'limit': limit,
          if (skip != null) 'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        // DummyJSON 응답 형식: { "todos": [...], "total": 150, ... }
        final List<dynamic> todosJson = response.data['todos'];
        return todosJson
            .map((json) => TodoModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Failed to load todos: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<TodoModel> getTodoById(int id) async {
    try {
      final response = await dio.get(ApiConstants.todoById(id));

      if (response.statusCode == 200) {
        return TodoModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to load todo: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<List<TodoModel>> getTodosByUserId(int userId) async {
    try {
      final response = await dio.get(ApiConstants.todosByUser(userId));

      if (response.statusCode == 200) {
        final List<dynamic> todosJson = response.data['todos'];
        return todosJson
            .map((json) => TodoModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to load user todos: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<TodoModel> getRandomTodo() async {
    try {
      final response = await dio.get(ApiConstants.randomTodo);

      if (response.statusCode == 200) {
        return TodoModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          'Failed to load random todo: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<TodoModel> addTodo({
    required String todo,
    required bool completed,
    required int userId,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.addTodo,
        data: {'todo': todo, 'completed': completed, 'userId': userId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TodoModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to add todo: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<TodoModel> updateTodo({
    required int id,
    String? todo,
    bool? completed,
  }) async {
    try {
      final response = await dio.put(
        ApiConstants.todoById(id),
        data: {
          if (todo != null) 'todo': todo,
          if (completed != null) 'completed': completed,
        },
      );

      if (response.statusCode == 200) {
        return TodoModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to update todo: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try {
      final response = await dio.delete(ApiConstants.todoById(id));

      if (response.statusCode != 200) {
        throw ServerException('Failed to delete todo: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  /// Dio 에러를 의미있는 메시지로 변환
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return 'Bad response: ${e.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'Connection error';
      default:
        return 'Network error: ${e.message}';
    }
  }
}
