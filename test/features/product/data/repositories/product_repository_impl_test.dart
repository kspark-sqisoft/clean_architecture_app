import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/error/exceptions.dart';
import 'package:clean_architectue_app/core/error/failures.dart';
import 'package:clean_architectue_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:clean_architectue_app/features/product/data/models/product_model.dart';
import 'package:clean_architectue_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:clean_architectue_app/features/product/domain/entities/product_entity.dart';

class _MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {}

void main() {
  late _MockProductRemoteDataSource remoteDataSource;
  late ProductRepositoryImpl repository;

  const tProductId = 1;
  const tLimit = 10;
  const tSkip = 0;
  const tQuery = 'laptop';
  const tCategory = 'smartphones';

  final tProductModel = ProductModel(
    id: tProductId,
    title: 'iPhone 9',
    description: 'An apple mobile',
    category: 'smartphones',
    price: 549,
    rating: 4.69,
    stock: 94,
    thumbnail: 'https://cdn.dummyjson.com/products/1/thumbnail.jpg',
  );

  final tProductModels = [
    tProductModel,
    ProductModel(
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

  final tCategories = ['smartphones', 'laptops', 'fragrances'];

  setUp(() {
    remoteDataSource = _MockProductRemoteDataSource();
    repository = ProductRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  group('getAllProducts', () {
    test('원격 데이터 소스가 성공하면 ProductEntity 목록을 반환한다', () async {
      when(
        () => remoteDataSource.getAllProducts(
          limit: any(named: 'limit'),
          skip: any(named: 'skip'),
        ),
      ).thenAnswer((_) async => tProductModels);

      final result = await repository.getAllProducts(
        limit: tLimit,
        skip: tSkip,
      );

      expect(result, isA<Right<Failure, List<ProductEntity>>>());
      result.fold((failure) => fail('should not return failure'), (products) {
        expect(products.length, 2);
        expect(products.first.id, tProductId);
        expect(products.first.title, 'iPhone 9');
      });

      verify(
        () => remoteDataSource.getAllProducts(limit: tLimit, skip: tSkip),
      ).called(1);
    });

    test('원격 데이터 소스가 예외를 던지면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.getAllProducts(
          limit: any(named: 'limit'),
          skip: any(named: 'skip'),
        ),
      ).thenThrow(ServerException('error'));

      final result = await repository.getAllProducts();

      expect(
        result,
        const Left<Failure, List<ProductEntity>>(Failure.server('error')),
      );
    });
  });

  group('getProductById', () {
    test('성공하면 ProductEntity를 반환한다', () async {
      when(
        () => remoteDataSource.getProductById(any()),
      ).thenAnswer((_) async => tProductModel);

      final result = await repository.getProductById(tProductId);

      expect(result, isA<Right<Failure, ProductEntity>>());
      result.fold((failure) => fail('should not return failure'), (product) {
        expect(product.id, tProductId);
        expect(product.title, 'iPhone 9');
      });

      verify(() => remoteDataSource.getProductById(tProductId)).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.getProductById(any()),
      ).thenThrow(ServerException('error'));

      final result = await repository.getProductById(tProductId);

      expect(
        result,
        const Left<Failure, ProductEntity>(Failure.server('error')),
      );
    });
  });

  group('searchProducts', () {
    test('성공하면 ProductEntity 목록을 반환한다', () async {
      when(
        () => remoteDataSource.searchProducts(any()),
      ).thenAnswer((_) async => tProductModels);

      final result = await repository.searchProducts(tQuery);

      expect(result, isA<Right<Failure, List<ProductEntity>>>());
      result.fold(
        (failure) => fail('should not return failure'),
        (products) => expect(products.length, 2),
      );

      verify(() => remoteDataSource.searchProducts(tQuery)).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.searchProducts(any()),
      ).thenThrow(ServerException('error'));

      final result = await repository.searchProducts(tQuery);

      expect(
        result,
        const Left<Failure, List<ProductEntity>>(Failure.server('error')),
      );
    });
  });

  group('getCategories', () {
    test('성공하면 문자열 목록(List<String>)을 반환한다', () async {
      when(
        () => remoteDataSource.getCategories(),
      ).thenAnswer((_) async => tCategories);

      final result = await repository.getCategories();

      expect(result, isA<Right<Failure, List<String>>>());
      result.fold((failure) => fail('should not return failure'), (categories) {
        expect(categories.length, 3);
        expect(categories.first, 'smartphones');
      });

      verify(() => remoteDataSource.getCategories()).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.getCategories(),
      ).thenThrow(ServerException('error'));

      final result = await repository.getCategories();

      expect(
        result,
        const Left<Failure, List<String>>(Failure.server('error')),
      );
    });
  });

  group('getProductsByCategory', () {
    test('성공하면 ProductEntity 목록을 반환한다', () async {
      when(
        () => remoteDataSource.getProductsByCategory(any()),
      ).thenAnswer((_) async => tProductModels);

      final result = await repository.getProductsByCategory(tCategory);

      expect(result, isA<Right<Failure, List<ProductEntity>>>());
      result.fold(
        (failure) => fail('should not return failure'),
        (products) => expect(products.length, 2),
      );

      verify(() => remoteDataSource.getProductsByCategory(tCategory)).called(1);
    });

    test('원격 호출에서 ServerException이 발생하면 Failure를 반환한다', () async {
      when(
        () => remoteDataSource.getProductsByCategory(any()),
      ).thenThrow(ServerException('error'));

      final result = await repository.getProductsByCategory(tCategory);

      expect(
        result,
        const Left<Failure, List<ProductEntity>>(Failure.server('error')),
      );
    });
  });
}
