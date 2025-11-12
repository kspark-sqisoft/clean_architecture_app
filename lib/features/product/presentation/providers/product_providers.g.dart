// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productRemoteDataSourceHash() =>
    r'80e796eec710cd1e81d589e214be6bf85dbf80f2';

/// ============================================================================
/// 의존성 주입 (Dependency Injection) - Product Feature
/// ============================================================================
/// ProductRemoteDataSource Provider
///
/// Copied from [productRemoteDataSource].
@ProviderFor(productRemoteDataSource)
final productRemoteDataSourceProvider =
    AutoDisposeProvider<ProductRemoteDataSource>.internal(
      productRemoteDataSource,
      name: r'productRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductRemoteDataSourceRef =
    AutoDisposeProviderRef<ProductRemoteDataSource>;
String _$productRepositoryHash() => r'b275a3e885f5bc51ccacdcb614c340c4887cc287';

/// ProductRepository Provider
///
/// Copied from [productRepository].
@ProviderFor(productRepository)
final productRepositoryProvider =
    AutoDisposeProvider<ProductRepository>.internal(
      productRepository,
      name: r'productRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductRepositoryRef = AutoDisposeProviderRef<ProductRepository>;
String _$getAllProductsHash() => r'982454fda4755f9850e5e7c9aec98ec8236e67b5';

/// ============================================================================
/// UseCase Providers
/// ============================================================================
///
/// Copied from [getAllProducts].
@ProviderFor(getAllProducts)
final getAllProductsProvider = AutoDisposeProvider<GetAllProducts>.internal(
  getAllProducts,
  name: r'getAllProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAllProductsRef = AutoDisposeProviderRef<GetAllProducts>;
String _$getProductByIdHash() => r'b6e99bbda4e1f8082dba795a49dac6b6f0d69388';

/// See also [getProductById].
@ProviderFor(getProductById)
final getProductByIdProvider = AutoDisposeProvider<GetProductById>.internal(
  getProductById,
  name: r'getProductByIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getProductByIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetProductByIdRef = AutoDisposeProviderRef<GetProductById>;
String _$searchProductsHash() => r'5b1c4e63f9bd5e3a6a0ad7d3d8eeae4c794d8896';

/// See also [searchProducts].
@ProviderFor(searchProducts)
final searchProductsProvider = AutoDisposeProvider<SearchProducts>.internal(
  searchProducts,
  name: r'searchProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchProductsRef = AutoDisposeProviderRef<SearchProducts>;
String _$getCategoriesHash() => r'd38d85b548ad9fdb5479428e4b87ea2ae1fc3f4a';

/// See also [getCategories].
@ProviderFor(getCategories)
final getCategoriesProvider = AutoDisposeProvider<GetCategories>.internal(
  getCategories,
  name: r'getCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetCategoriesRef = AutoDisposeProviderRef<GetCategories>;
String _$getProductsByCategoryHash() =>
    r'8ca9a59bf367498f04d9d68812d95e4b1b6071e9';

/// See also [getProductsByCategory].
@ProviderFor(getProductsByCategory)
final getProductsByCategoryProvider =
    AutoDisposeProvider<GetProductsByCategory>.internal(
      getProductsByCategory,
      name: r'getProductsByCategoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getProductsByCategoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetProductsByCategoryRef =
    AutoDisposeProviderRef<GetProductsByCategory>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
