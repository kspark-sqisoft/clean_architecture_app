import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/error/failures.dart';
import 'package:clean_architectue_app/features/product/domain/entities/product_entity.dart';
import 'package:clean_architectue_app/features/product/domain/repositories/product_repository.dart';
import 'package:clean_architectue_app/features/product/domain/usecases/search_products.dart';

class _MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late _MockProductRepository repository;
  late SearchProducts usecase;

  const tQuery = 'laptop';

  final tProducts = [
    const ProductEntity(
      id: 1,
      title: 'MacBook Pro',
      description: 'MacBook Pro 13-inch',
      category: 'laptops',
      price: 1299,
      rating: 4.69,
      stock: 83,
      thumbnail: 'https://cdn.dummyjson.com/products/6/thumbnail.jpg',
    ),
  ];

  setUp(() {
    repository = _MockProductRepository();
    usecase = SearchProducts(repository);
  });

  test(
    'should call repository with query and return List<ProductEntity>',
    () async {
      when(
        () => repository.searchProducts(any()),
      ).thenAnswer((_) async => Right(tProducts));

      final result = await usecase(tQuery);

      expect(result, Right(tProducts));
      verify(() => repository.searchProducts(tQuery)).called(1);
    },
  );

  test('should return Failure when repository fails', () async {
    when(
      () => repository.searchProducts(any()),
    ).thenAnswer((_) async => const Left(Failure.server('error')));

    final result = await usecase(tQuery);

    expect(result, const Left(Failure.server('error')));
  });
}
