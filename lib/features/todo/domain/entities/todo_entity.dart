import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_entity.freezed.dart';

/// Todo 엔티티 (Entity)
///
/// **엔티티란?**
/// - 비즈니스 로직의 핵심 데이터 객체입니다
/// - 외부 의존성(JSON, DB 등)이 없는 순수한 Dart 객체입니다
/// - 앱의 다른 레이어(Data, Presentation)와 독립적입니다
///
/// **freezed를 사용하는 이유:**
/// - 불변(immutable) 객체를 쉽게 만들 수 있습니다
/// - copyWith, toString, ==, hashCode가 자동 생성됩니다
/// - 패턴 매칭과 union types를 지원합니다
/// - null-safety를 완벽하게 지원합니다
///
/// **DummyJSON API 응답 형식:**
/// ```json
/// {
///   "id": 1,
///   "todo": "Do something nice for someone I care about",
///   "completed": true,
///   "userId": 26
/// }
/// ```
@freezed
class TodoEntity with _$TodoEntity {
  const factory TodoEntity({
    required int id,
    required String todo,
    required bool completed,
    required int userId,
  }) = _TodoEntity;
}
