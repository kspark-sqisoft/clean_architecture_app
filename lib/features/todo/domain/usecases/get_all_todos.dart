import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

/// GetAllTodos 유즈케이스
///
/// **유즈케이스란?**
/// - Single Responsibility Principle (단일 책임 원칙)을 따르는 비즈니스 로직 단위입니다
/// - 하나의 유즈케이스는 하나의 기능만 수행합니다
/// - "할일 목록 가져오기"라는 명확한 하나의 목적을 가집니다
///
/// **왜 유즈케이스를 사용할까?**
/// 1. **재사용성**: 같은 비즈니스 로직을 여러 곳에서 재사용
/// 2. **테스트 용이성**: 각 기능을 독립적으로 테스트 가능
/// 3. **유지보수성**: 비즈니스 로직이 한 곳에 집중
/// 4. **명확성**: 앱이 수행하는 기능들을 명확히 파악 가능
///
/// **사용 예시:**
/// ```dart
/// final usecase = GetAllTodos(repository);
/// final result = await usecase(GetAllTodosParams(limit: 10));
/// ```
class GetAllTodos implements UseCase<List<TodoEntity>, GetAllTodosParams> {
  final TodoRepository repository;

  GetAllTodos(this.repository);

  @override
  Future<Either<Failure, List<TodoEntity>>> call(
    GetAllTodosParams params,
  ) async {
    return await repository.getAllTodos(limit: params.limit, skip: params.skip);
  }
}

/// GetAllTodos 유즈케이스의 파라미터
///
/// **왜 별도의 Params 클래스를 만들까?**
/// - 파라미터가 여러 개일 때 순서를 걱정할 필요가 없습니다
/// - 파라미터가 추가되어도 기존 코드를 수정할 필요가 없습니다
/// - 타입 안정성이 높아집니다
class GetAllTodosParams {
  final int? limit;
  final int? skip;

  const GetAllTodosParams({this.limit, this.skip});
}
