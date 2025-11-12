import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/todo_entity.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

/// TodoModel - Data Transfer Object (DTO)
///
/// **Model vs Entity의 차이:**
///
/// **Entity (Domain Layer):**
/// - 순수한 비즈니스 객체
/// - JSON, DB 등 외부 의존성이 없음
/// - 비즈니스 로직에만 집중
///
/// **Model (Data Layer):**
/// - JSON 직렬화/역직렬화 가능
/// - API 응답 구조와 매칭
/// - Entity로 변환 가능
/// - 외부 데이터 형식과 앱 내부 형식을 분리
///
/// **왜 Model과 Entity를 분리할까?**
/// 1. **관심사의 분리**: API 변경이 비즈니스 로직에 영향을 주지 않음
/// 2. **유연성**: API 응답 구조가 복잡해도 Entity는 단순하게 유지
/// 3. **테스트 용이성**: Mock 데이터를 쉽게 만들 수 있음
///
/// **freezed + json_serializable:**
/// - `freezed`는 불변 객체와 copyWith를 생성
/// - `json_serializable`은 fromJson/toJson을 자동 생성
/// - 함께 사용하면 강력한 데이터 클래스가 완성
@freezed
class TodoModel with _$TodoModel {
  const TodoModel._(); // Private constructor for extension methods

  const factory TodoModel({
    required int id,
    required String todo,
    required bool completed,
    required int userId,
  }) = _TodoModel;

  /// JSON에서 TodoModel 생성 (역직렬화)
  ///
  /// **예시:**
  /// ```dart
  /// final json = {
  ///   "id": 1,
  ///   "todo": "Buy milk",
  ///   "completed": false,
  ///   "userId": 5
  /// };
  /// final model = TodoModel.fromJson(json);
  /// ```
  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  /// Model을 Entity로 변환
  ///
  /// **역할:**
  /// - Data Layer에서 받은 데이터를 Domain Layer로 전달
  /// - 외부 데이터 형식(JSON)을 내부 비즈니스 객체로 변환
  TodoEntity toEntity() {
    return TodoEntity(id: id, todo: todo, completed: completed, userId: userId);
  }
}

/// TodoEntity Extension - Entity를 Model로 변환
///
/// **사용 시나리오:**
/// - POST/PUT 요청 시 Entity를 JSON으로 변환해야 할 때
/// - 캐시에 데이터를 저장할 때
extension TodoEntityX on TodoEntity {
  TodoModel toModel() {
    return TodoModel(id: id, todo: todo, completed: completed, userId: userId);
  }
}
