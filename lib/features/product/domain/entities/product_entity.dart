import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';

/// Product 엔티티 (Entity)
///
/// **엔티티란?**
/// - 비즈니스 로직의 핵심 데이터 객체입니다
/// - 외부 의존성(JSON, DB 등)이 없는 순수한 Dart 객체입니다
/// - 앱의 다른 레이어(Data, Presentation)와 독립적입니다
///
/// **DummyJSON Products API 응답 형식:**
/// ```json
/// {
///   "id": 1,
///   "title": "Essence Mascara Lash Princess",
///   "description": "The Essence Mascara...",
///   "category": "beauty",
///   "price": 9.99,
///   "rating": 4.94,
///   "stock": 5,
///   "thumbnail": "..."
/// }
/// ```
@freezed
class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required int id,
    required String title,
    required String description,
    required String category,
    required double price,
    required double rating,
    required int stock,
    required String thumbnail,
  }) = _ProductEntity;
}
