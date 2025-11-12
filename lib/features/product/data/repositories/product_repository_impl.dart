import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

/// ProductRepositoryImpl - Repository 인터페이스의 구체적인 구현
///
/// **Repository의 역할:**
/// 1. DataSource에서 데이터를 가져옵니다
/// 2. Model을 Entity로 변환합니다
/// 3. Exception을 Failure로 변환합니다
/// 4. Either 타입으로 결과를 반환합니다
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts({
    int? limit,
    int? skip,
  }) async {
    try {
      final productModels = await remoteDataSource.getAllProducts(
        limit: limit,
        skip: skip,
      );
      final productEntities = productModels
          .map((model) => model.toEntity())
          .toList();
      return Right(productEntities);
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    try {
      final productModel = await remoteDataSource.getProductById(id);
      return Right(productModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
    String query,
  ) async {
    try {
      final productModels = await remoteDataSource.searchProducts(query);
      final productEntities = productModels
          .map((model) => model.toEntity())
          .toList();
      return Right(productEntities);
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final productModels = await remoteDataSource.getProductsByCategory(
        category,
      );
      final productEntities = productModels
          .map((model) => model.toEntity())
          .toList();
      return Right(productEntities);
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> addProduct({
    required String title,
    required String description,
    required String category,
    required double price,
  }) async {
    try {
      final productModel = await remoteDataSource.addProduct(
        title: title,
        description: description,
        category: category,
        price: price,
      );
      return Right(productModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct({
    required int id,
    String? title,
    String? description,
    double? price,
  }) async {
    try {
      final productModel = await remoteDataSource.updateProduct(
        id: id,
        title: title,
        description: description,
        price: price,
      );
      return Right(productModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await remoteDataSource.deleteProduct(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.general(e.toString()));
    }
  }
}
