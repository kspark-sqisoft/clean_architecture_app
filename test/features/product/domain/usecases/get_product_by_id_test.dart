import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/error/failures.dart';
import 'package:clean_architectue_app/features/product/domain/entities/product_entity.dart';
import 'package:clean_architectue_app/features/product/domain/repositories/product_repository.dart';
import 'package:clean_architectue_app/features/product/domain/usecases/get_product_by_id.dart';

class _MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late _MockProductRepository repository;
  late GetProductById usecase;

  const tProductId = 1;

  const tProduct = ProductEntity(
    id: tProductId,
    title: 'iPhone 9',
    description: 'An apple mobile',
    category: 'smartphones',
    price: 549,
    rating: 4.69,
    stock: 94,
    thumbnail: 'https://cdn.dummyjson.com/products/1/thumbnail.jpg',
  );

  setUp(() {
    repository = _MockProductRepository();
    usecase = GetProductById(repository);
  });

  test('should call repository with id and return ProductEntity', () async {
    when(
      () => repository.getProductById(any()),
    ).thenAnswer((_) async => const Right(tProduct));

    final result = await usecase(tProductId);

    expect(result, const Right(tProduct));
    verify(() => repository.getProductById(tProductId)).called(1);
  });

  test('should return Failure when repository fails', () async {
    when(
      () => repository.getProductById(any()),
    ).thenAnswer((_) async => const Left(Failure.server('error')));

    final result = await usecase(tProductId);

    expect(result, const Left(Failure.server('error')));
  });
}
