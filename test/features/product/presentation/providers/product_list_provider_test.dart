import 'package:clean_architectue_app/features/product/domain/entities/product_entity.dart';
import 'package:clean_architectue_app/features/product/domain/usecases/get_all_products.dart';
import 'package:clean_architectue_app/features/product/domain/usecases/get_products_by_category.dart';
import 'package:clean_architectue_app/features/product/domain/usecases/search_products.dart';
import 'package:clean_architectue_app/features/product/presentation/providers/product_filter_controller.dart';
import 'package:clean_architectue_app/features/product/presentation/providers/product_list_provider.dart';
import 'package:clean_architectue_app/features/product/presentation/providers/product_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';

class MockGetAllProducts extends Mock implements GetAllProducts {}

class MockSearchProducts extends Mock implements SearchProducts {}

class MockGetProductsByCategory extends Mock implements GetProductsByCategory {}

void main() {
  late ProviderContainer container;
  late MockGetAllProducts mockGetAllProducts;
  late MockSearchProducts mockSearchProducts;
  late MockGetProductsByCategory mockGetProductsByCategory;

  const tProducts = [
    ProductEntity(
      id: 1,
      title: 'Phone',
      description: 'Smartphone',
      category: 'smartphones',
      price: 999.0,
      rating: 4.8,
      stock: 12,
      thumbnail: 'https://example.com/phone.png',
    ),
    ProductEntity(
      id: 2,
      title: 'Laptop',
      description: 'Gaming Laptop',
      category: 'laptops',
      price: 1999.0,
      rating: 4.6,
      stock: 5,
      thumbnail: 'https://example.com/laptop.png',
    ),
  ];

  setUpAll(() {
    registerFallbackValue(const GetAllProductsParams());
  });

  setUp(() {
    mockGetAllProducts = MockGetAllProducts();
    mockSearchProducts = MockSearchProducts();
    mockGetProductsByCategory = MockGetProductsByCategory();

    container = ProviderContainer(
      overrides: [
        getAllProductsProvider.overrideWithValue(mockGetAllProducts),
        searchProductsProvider.overrideWithValue(mockSearchProducts),
        getProductsByCategoryProvider.overrideWithValue(
          mockGetProductsByCategory,
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('기본 필터에서는 전체 상품을 반환한다', () async {
    when(
      () => mockGetAllProducts(any()),
    ).thenAnswer((_) async => const Right(tProducts));

    final result = await container.read(productListProvider.future);

    expect(result, tProducts);
    verify(() => mockGetAllProducts(any())).called(1);
    verifyNever(() => mockSearchProducts(any()));
    verifyNever(() => mockGetProductsByCategory(any()));
  });

  test('카테고리를 선택하면 해당 카테고리 상품만 요청한다', () async {
    when(
      () => mockGetProductsByCategory('smartphones'),
    ).thenAnswer((_) async => Right([tProducts.first]));

    container
        .read(productFilterControllerProvider.notifier)
        .setCategory('smartphones');

    final result = await container.read(productListProvider.future);

    expect(result, [tProducts.first]);
    verify(() => mockGetProductsByCategory('smartphones')).called(1);
    verifyNever(() => mockGetAllProducts(any()));
    verifyNever(() => mockSearchProducts(any()));
  });

  test('검색 후 카테고리를 선택하면 검색 결과에서 필터링한다', () async {
    when(
      () => mockSearchProducts('phone'),
    ).thenAnswer((_) async => const Right(tProducts));

    final notifier = container.read(productFilterControllerProvider.notifier);
    notifier.setSearchQuery('phone');
    notifier.setCategory('smartphones');

    final result = await container.read(productListProvider.future);

    expect(result, [tProducts.first]);
    verify(() => mockSearchProducts('phone')).called(1);
    verifyNever(() => mockGetProductsByCategory(any()));
    verifyNever(() => mockGetAllProducts(any()));
  });
}
