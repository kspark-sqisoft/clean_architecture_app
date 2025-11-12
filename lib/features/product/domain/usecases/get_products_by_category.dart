import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// GetProductsByCategory 유즈케이스
/// 특정 카테고리의 상품 목록을 가져옵니다
class GetProductsByCategory implements UseCase<List<ProductEntity>, String> {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(String category) async {
    return await repository.getProductsByCategory(category);
  }
}
