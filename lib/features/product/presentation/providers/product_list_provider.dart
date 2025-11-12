import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_all_products.dart';
import 'product_filter_controller.dart';
import 'product_filter_state.dart';
import 'product_providers.dart';

part 'product_list_provider.g.dart';

/// ============================================================================
/// ProductList 상태 관리 Provider
/// ============================================================================

@riverpod
class ProductList extends _$ProductList {
  /// 초기 상태 빌드
  @override
  Future<List<ProductEntity>> build() async {
    //productFilterControllerProvider가 변경 되면 build를 다시 호출합니다
    final filter = ref.watch(productFilterControllerProvider);
    //filter가 변경 되면 _fetchProducts를 호출합니다
    return _fetchProducts(filter);
  }

  /// 상품 목록을 새로고침합니다
  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final filter = ref.read(productFilterControllerProvider);
      return _fetchProducts(filter);
    });
  }

  /// 페이지네이션으로 상품 목록을 가져옵니다
  Future<void> loadProducts({int? limit, int? skip}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final filter = ref.read(productFilterControllerProvider);
      return _fetchProducts(filter, limit: limit, skip: skip);
    });
  }

  /// 현재 필터 상태에 맞는 상품 목록을 가져옵니다
  Future<List<ProductEntity>> _fetchProducts(
    ProductFilterState filter, {
    int? limit,
    int? skip,
  }) async {
    // 검색어가 우선순위를 가집니다
    if (filter.hasQuery) {
      final searchProducts = ref.read(searchProductsProvider);
      final result = await searchProducts(filter.searchQuery.trim());

      return result.fold((failure) => throw failure, (products) {
        if (filter.hasCategory) {
          final selected = filter.selectedCategory.toLowerCase();
          return products
              .where((product) => product.category.toLowerCase() == selected)
              .toList();
        }
        return products;
      });
    }

    // 카테고리 필터가 있는 경우
    if (filter.hasCategory) {
      final getProductsByCategory = ref.read(getProductsByCategoryProvider);
      final result = await getProductsByCategory(filter.selectedCategory);

      return result.fold((failure) => throw failure, (products) => products);
    }

    // 기본: 전체 상품 조회
    final getAllProducts = ref.read(getAllProductsProvider);
    final result = await getAllProducts(
      GetAllProductsParams(limit: limit, skip: skip),
    );

    return result.fold((failure) => throw failure, (products) => products);
  }
}

/// Category List Provider
@riverpod
class CategoryList extends _$CategoryList {
  @override
  Future<List<String>> build() async {
    final getCategories = ref.watch(getCategoriesProvider);
    final result = await getCategories(const NoParams());

    return result.fold((failure) => throw failure, (categories) => categories);
  }
}
