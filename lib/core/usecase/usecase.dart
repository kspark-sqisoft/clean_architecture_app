import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// UseCase 추상 클래스
///
/// **UseCase란?**
/// - Single Responsibility Principle을 따르는 비즈니스 로직 단위입니다
/// - 하나의 UseCase는 하나의 명확한 목적을 가집니다
/// - Presentation Layer에서 비즈니스 로직을 분리합니다
///
/// **타입 파라미터:**
/// - `TResult`: UseCase가 반환할 데이터 타입 (Entity, List<Entity>, void 등)
/// - `Params`: UseCase에 전달할 파라미터 타입
///   - 단일 값: `int`, `String` 등
///   - 여러 값: `GetAllTodosParams` 같은 클래스
///   - 파라미터 없음: `NoParams`
///
/// **사용 예시:**
/// ```dart
/// // 단일 파라미터
/// class GetProductById implements UseCase<ProductEntity, int> {
///   @override
///   Future<Either<Failure, ProductEntity>> call(int id) async {
///     return await repository.getProductById(id);
///   }
/// }
///
/// // 복수 파라미터 (Params 클래스 사용)
/// class GetAllTodos implements UseCase<List<TodoEntity>, GetAllTodosParams> {
///   @override
///   Future<Either<Failure, List<TodoEntity>>> call(GetAllTodosParams params) async {
///     return await repository.getAllTodos(limit: params.limit, skip: params.skip);
///   }
/// }
///
/// // 파라미터 없음
/// class GetCategories implements UseCase<List<String>, NoParams> {
///   @override
///   Future<Either<Failure, List<String>>> call(NoParams params) async {
///     return await repository.getCategories();
///   }
/// }
/// ```
abstract class UseCase<TResult, Params> {
  /// UseCase 실행 메서드
  ///
  /// **파라미터:**
  /// - `params`: UseCase에 전달할 파라미터
  ///   - 단일 값: `int`, `String` 등 직접 전달
  ///   - 복수 값: `Params` 클래스 인스턴스
  ///   - 파라미터 없음: `const NoParams()`
  ///
  /// **반환값:**
  /// - `Right<TResult>`: 성공 시 데이터 반환
  /// - `Left<Failure>`: 실패 시 에러 정보 반환
  Future<Either<Failure, TResult>> call(Params params);
}

/// 파라미터가 없는 유즈케이스를 위한 클래스
///
/// **사용 예시:**
/// ```dart
/// class GetCategories implements UseCase<List<String>, NoParams> {
///   @override
///   Future<Either<Failure, List<String>>> call(NoParams params) async {
///     return await repository.getCategories();
///   }
/// }
///
/// // 사용
/// final usecase = GetCategories(repository);
/// final result = await usecase(const NoParams());
/// ```
class NoParams {
  /// 파라미터가 없는 UseCase를 위한 상수 인스턴스
  const NoParams();

  /// 전역 상수 인스턴스 (편의를 위해 제공)
  static const NoParams instance = NoParams();
}
