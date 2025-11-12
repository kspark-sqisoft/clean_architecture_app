import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/get_products_by_category.dart';
import '../../domain/usecases/search_products.dart';

part 'product_providers.g.dart';

/// ============================================================================
/// 의존성 주입 (Dependency Injection) - Product Feature
/// ============================================================================

/// ProductRemoteDataSource Provider
@riverpod
ProductRemoteDataSource productRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ProductRemoteDataSourceImpl(dio: dio);
}

/// ProductRepository Provider
@riverpod
ProductRepository productRepository(Ref ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource: remoteDataSource);
}

/// ============================================================================
/// UseCase Providers
/// ============================================================================

@riverpod
GetAllProducts getAllProducts(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetAllProducts(repository);
}

@riverpod
GetProductById getProductById(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductById(repository);
}

@riverpod
SearchProducts searchProducts(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);
  return SearchProducts(repository);
}

@riverpod
GetCategories getCategories(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetCategories(repository);
}

@riverpod
GetProductsByCategory getProductsByCategory(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductsByCategory(repository);
}
