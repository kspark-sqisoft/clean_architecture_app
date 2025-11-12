import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/product_repository.dart';

/// GetCategories 유즈케이스
/// 모든 카테고리 목록을 가져옵니다
class GetCategories implements UseCase<List<String>, NoParams> {
  final ProductRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
