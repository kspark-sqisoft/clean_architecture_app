// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productListHash() => r'8f0e7b53781dd47dd52c1a05640e609f7c650da6';

/// ============================================================================
/// ProductList 상태 관리 Provider
/// ============================================================================
///
/// Copied from [ProductList].
@ProviderFor(ProductList)
final productListProvider =
    AutoDisposeAsyncNotifierProvider<ProductList, List<ProductEntity>>.internal(
      ProductList.new,
      name: r'productListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProductList = AutoDisposeAsyncNotifier<List<ProductEntity>>;
String _$categoryListHash() => r'b511a6acda0557d981be76620283c51f5abbaf66';

/// Category List Provider
///
/// Copied from [CategoryList].
@ProviderFor(CategoryList)
final categoryListProvider =
    AutoDisposeAsyncNotifierProvider<CategoryList, List<String>>.internal(
      CategoryList.new,
      name: r'categoryListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$categoryListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CategoryList = AutoDisposeAsyncNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
