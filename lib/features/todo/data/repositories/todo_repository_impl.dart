import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_remote_datasource.dart';

/// TodoRepositoryImpl - Repository 인터페이스의 구체적인 구현
/// 
/// **Repository의 역할:**
/// 1. DataSource에서 데이터를 가져옵니다
/// 2. Model을 Entity로 변환합니다
/// 3. Exception을 Failure로 변환합니다
/// 4. Either 타입으로 결과를 반환합니다
/// 
/// **에러 처리 흐름:**
/// ```
/// DataSource (throw Exception)
///     ↓
/// Repository (catch Exception → return Left(Failure))
///     ↓
/// UseCase (Either<Failure, Data>)
///     ↓
/// Presentation (fold로 분기 처리)
/// ```
/// 
/// **왜 이렇게 복잡하게 할까?**
/// - Domain Layer는 Exception을 알 필요가 없습니다
/// - Either 타입으로 에러를 명시적으로 처리합니다
/// - 타입 안정성과 함수형 프로그래밍의 장점을 활용합니다
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  
  TodoRepositoryImpl({
    required this.remoteDataSource,
  });
  
  @override
  Future<Either<Failure, List<TodoEntity>>> getAllTodos({
    int? limit,
    int? skip,
  }) async {
    try {
      // 1. DataSource에서 Model 리스트를 가져옵니다
      final todoModels = await remoteDataSource.getAllTodos(
        limit: limit,
        skip: skip,
      );
      
      // 2. Model을 Entity로 변환합니다
      final todoEntities = todoModels.map((model) => model.toEntity()).toList();
      
      // 3. 성공 시 Right로 감싸서 반환합니다
      return Right(todoEntities);
    } on ServerException catch (e) {
      // 4. 서버 에러 발생 시 Left(Failure)로 반환합니다
      return Left(Failure.server(e.message));
    } catch (e) {
      // 5. 예상치 못한 에러는 일반 에러로 처리합니다
      return Left(Failure.general(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, TodoEntity>> getTodoById(int id) async {
    try {
      final todoModel = await remoteDataSource.getTodoById(id);
      return Right(todoModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<TodoEntity>>> getTodosByUserId(
    int userId,
  ) async {
    try {
      final todoModels = await remoteDataSource.getTodosByUserId(userId);
      final todoEntities = todoModels.map((model) => model.toEntity()).toList();
      return Right(todoEntities);
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, TodoEntity>> getRandomTodo() async {
    try {
      final todoModel = await remoteDataSource.getRandomTodo();
      return Right(todoModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, TodoEntity>> addTodo({
    required String todo,
    required bool completed,
    required int userId,
  }) async {
    try {
      final todoModel = await remoteDataSource.addTodo(
        todo: todo,
        completed: completed,
        userId: userId,
      );
      return Right(todoModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, TodoEntity>> updateTodo({
    required int id,
    String? todo,
    bool? completed,
  }) async {
    try {
      final todoModel = await remoteDataSource.updateTodo(
        id: id,
        todo: todo,
        completed: completed,
      );
      return Right(todoModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      await remoteDataSource.deleteTodo(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }
}

