import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// GetAllProducts 유즈케이스
/// 모든 상품 목록을 가져옵니다
class GetAllProducts
    implements UseCase<List<ProductEntity>, GetAllProductsParams> {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
    GetAllProductsParams params,
  ) async {
    return await repository.getAllProducts(
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class GetAllProductsParams {
  final int? limit;
  final int? skip;

  const GetAllProductsParams({this.limit, this.skip});
}
