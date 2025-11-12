import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product_entity.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

/// ProductModel - Data Transfer Object (DTO)
///
/// **Model vs Entity의 차이:**
///
/// **Entity (Domain Layer):**
/// - 순수한 비즈니스 객체
/// - JSON, DB 등 외부 의존성이 없음
///
/// **Model (Data Layer):**
/// - JSON 직렬화/역직렬화 가능
/// - API 응답 구조와 매칭
/// - Entity로 변환 가능
@freezed
class ProductModel with _$ProductModel {
  const ProductModel._(); // Private constructor for extension methods

  const factory ProductModel({
    required int id,
    required String title,
    required String description,
    required String category,
    required double price,
    required double rating,
    required int stock,
    required String thumbnail,
  }) = _ProductModel;

  /// JSON에서 ProductModel 생성 (역직렬화)
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// Model을 Entity로 변환
  ///
  /// **역할:**
  /// - Data Layer에서 받은 데이터를 Domain Layer로 전달
  /// - 외부 데이터 형식(JSON)을 내부 비즈니스 객체로 변환
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      rating: rating,
      stock: stock,
      thumbnail: thumbnail,
    );
  }
}

/// ProductEntity Extension - Entity를 Model로 변환
extension ProductEntityX on ProductEntity {
  ProductModel toModel() {
    return ProductModel(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      rating: rating,
      stock: stock,
      thumbnail: thumbnail,
    );
  }
}
