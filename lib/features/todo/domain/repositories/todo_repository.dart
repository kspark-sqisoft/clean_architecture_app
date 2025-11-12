import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/todo_entity.dart';

/// TodoRepository 인터페이스 (추상 클래스)
///
/// **리포지토리 패턴이란?**
/// - 데이터 소스를 추상화하는 디자인 패턴입니다
/// - Domain Layer는 "무엇을" 가져올지만 정의합니다
/// - Data Layer는 "어떻게" 가져올지 구현합니다
///
/// **의존성 역전 원칙 (DIP - Dependency Inversion Principle):**
/// ```
/// Domain Layer (고수준)
///     ↑ 의존
///     TodoRepository (인터페이스)
///     ↑ 구현
/// Data Layer (저수준)
///     TodoRepositoryImpl
/// ```
/// - Domain이 Data를 의존하지 않고, Data가 Domain을 의존합니다
/// - 이를 통해 Domain Layer는 외부 변경에 영향받지 않습니다
///
/// **dartz의 Either 타입:**
/// - `Either<Failure, Success>` = 성공 또는 실패
/// - Left: 실패 케이스 (Failure)
/// - Right: 성공 케이스 (데이터)
/// - try-catch보다 명시적이고 타입 안전합니다
/// - 함수형 프로그래밍 방식으로 에러를 처리합니다
abstract class TodoRepository {
  /// 모든 할일 목록을 가져옵니다
  ///
  /// **Parameters:**
  /// - [limit]: 가져올 아이템 개수 (기본: 30, 0 = 전체)
  /// - [skip]: 건너뛸 아이템 개수 (페이지네이션)
  ///
  /// **Returns:**
  /// - `Right<List<TodoEntity>>`: 성공 시 할일 목록
  /// - `Left<Failure>`: 실패 시 에러 정보
  ///
  /// **예시:**
  /// ```dart
  /// final result = await repository.getAllTodos(limit: 10, skip: 0);
  /// result.fold(
  ///   (failure) => appLogger.e('Error: $failure'),
  ///   (todos) => appLogger.i('Success: ${todos.length} todos'),
  /// );
  /// ```
  Future<Either<Failure, List<TodoEntity>>> getAllTodos({
    int? limit,
    int? skip,
  });

  /// 특정 ID의 할일을 가져옵니다
  Future<Either<Failure, TodoEntity>> getTodoById(int id);

  /// 특정 사용자의 모든 할일 목록을 가져옵니다
  Future<Either<Failure, List<TodoEntity>>> getTodosByUserId(int userId);

  /// 랜덤 할일을 가져옵니다 (DummyJSON 특별 기능)
  Future<Either<Failure, TodoEntity>> getRandomTodo();

  /// 새로운 할일을 추가합니다
  ///
  /// **주의:** DummyJSON은 실제로 서버에 데이터를 저장하지 않고
  /// POST 요청을 시뮬레이션만 합니다
  Future<Either<Failure, TodoEntity>> addTodo({
    required String todo,
    required bool completed,
    required int userId,
  });

  /// 할일을 수정합니다 (서버 시뮬레이션)
  Future<Either<Failure, TodoEntity>> updateTodo({
    required int id,
    String? todo,
    bool? completed,
  });

  /// 할일을 삭제합니다 (서버 시뮬레이션)
  Future<Either<Failure, void>> deleteTodo(int id);
}
