import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/error/failures.dart';
import 'package:clean_architectue_app/features/product/domain/entities/product_entity.dart';
import 'package:clean_architectue_app/features/product/domain/repositories/product_repository.dart';
import 'package:clean_architectue_app/features/product/domain/usecases/get_all_products.dart';

class _MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late _MockProductRepository repository;
  late GetAllProducts usecase;

  const tLimit = 10;
  const tSkip = 0;

  final tProducts = [
    const ProductEntity(
      id: 1,
      title: 'iPhone 9',
      description: 'An apple mobile',
      category: 'smartphones',
      price: 549,
      rating: 4.69,
      stock: 94,
      thumbnail: 'https://cdn.dummyjson.com/products/1/thumbnail.jpg',
    ),
    const ProductEntity(
      id: 2,
      title: 'iPhone X',
      description: 'SIM-Free, Model A19211',
      category: 'smartphones',
      price: 899,
      rating: 4.44,
      stock: 34,
      thumbnail: 'https://cdn.dummyjson.com/products/2/thumbnail.jpg',
    ),
  ];

  setUp(() {
    repository = _MockProductRepository();
    usecase = GetAllProducts(repository);
  });

  test('should call repository and return List<ProductEntity>', () async {
    when(
      () => repository.getAllProducts(
        limit: any(named: 'limit'),
        skip: any(named: 'skip'),
      ),
    ).thenAnswer((_) async => Right(tProducts));

    const params = GetAllProductsParams(limit: tLimit, skip: tSkip);
    final result = await usecase(params);

    expect(result, Right(tProducts));
    verify(
      () => repository.getAllProducts(limit: tLimit, skip: tSkip),
    ).called(1);
  });

  test('should return Failure when repository fails', () async {
    when(
      () => repository.getAllProducts(
        limit: any(named: 'limit'),
        skip: any(named: 'skip'),
      ),
    ).thenAnswer((_) async => const Left(Failure.server('error')));

    const params = GetAllProductsParams();
    final result = await usecase(params);

    expect(result, const Left(Failure.server('error')));
  });
}
