import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// GetProductById 유즈케이스
/// 특정 ID의 상품을 가져옵니다
class GetProductById implements UseCase<ProductEntity, int> {
  final ProductRepository repository;

  GetProductById(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(int id) async {
    return await repository.getProductById(id);
  }
}
