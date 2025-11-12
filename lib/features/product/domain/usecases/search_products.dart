import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// SearchProducts 유즈케이스
/// 상품을 검색합니다
class SearchProducts implements UseCase<List<ProductEntity>, String> {
  final ProductRepository repository;

  SearchProducts(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(String query) async {
    return await repository.searchProducts(query);
  }
}
