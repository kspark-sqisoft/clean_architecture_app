import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';

/// ProductRepository 인터페이스 (추상 클래스)
///
/// **리포지토리 패턴:**
/// - 데이터 소스를 추상화하는 디자인 패턴입니다
/// - Domain Layer는 "무엇을" 가져올지만 정의합니다
/// - Data Layer는 "어떻게" 가져올지 구현합니다
abstract class ProductRepository {
  /// 모든 상품 목록을 가져옵니다
  ///
  /// **Parameters:**
  /// - [limit]: 가져올 아이템 개수 (기본: 30, 0 = 전체)
  /// - [skip]: 건너뛸 아이템 개수 (페이지네이션)
  ///
  /// **Returns:**
  /// - `Right<List<ProductEntity>>`: 성공 시 상품 목록
  /// - `Left<Failure>`: 실패 시 에러 정보
  Future<Either<Failure, List<ProductEntity>>> getAllProducts({
    int? limit,
    int? skip,
  });

  /// 특정 ID의 상품을 가져옵니다
  Future<Either<Failure, ProductEntity>> getProductById(int id);

  /// 상품을 검색합니다
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);

  /// 모든 카테고리 목록을 가져옵니다
  Future<Either<Failure, List<String>>> getCategories();

  /// 특정 카테고리의 상품 목록을 가져옵니다
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  );

  /// 새로운 상품을 추가합니다 (서버 시뮬레이션)
  Future<Either<Failure, ProductEntity>> addProduct({
    required String title,
    required String description,
    required String category,
    required double price,
  });

  /// 상품을 수정합니다 (서버 시뮬레이션)
  Future<Either<Failure, ProductEntity>> updateProduct({
    required int id,
    String? title,
    String? description,
    double? price,
  });

  /// 상품을 삭제합니다 (서버 시뮬레이션)
  Future<Either<Failure, void>> deleteProduct(int id);
}
