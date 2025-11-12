import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

/// ProductRemoteDataSource 추상 클래스
abstract class ProductRemoteDataSource {
  /// 모든 상품 목록을 가져옵니다
  Future<List<ProductModel>> getAllProducts({int? limit, int? skip});

  /// 특정 ID의 상품을 가져옵니다
  Future<ProductModel> getProductById(int id);

  /// 상품을 검색합니다
  Future<List<ProductModel>> searchProducts(String query);

  /// 모든 카테고리 목록을 가져옵니다
  Future<List<String>> getCategories();

  /// 특정 카테고리의 상품 목록을 가져옵니다
  Future<List<ProductModel>> getProductsByCategory(String category);

  /// 새로운 상품을 추가합니다
  Future<ProductModel> addProduct({
    required String title,
    required String description,
    required String category,
    required double price,
  });

  /// 상품을 수정합니다
  Future<ProductModel> updateProduct({
    required int id,
    String? title,
    String? description,
    double? price,
  });

  /// 상품을 삭제합니다
  Future<void> deleteProduct(int id);
}

/// ProductRemoteDataSourceImpl - 실제 API 호출 구현
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getAllProducts({int? limit, int? skip}) async {
    try {
      final response = await dio.get(
        ApiConstants.products,
        queryParameters: {
          if (limit != null) 'limit': limit,
          if (skip != null) 'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['products'];
        return productsJson
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to load products: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dio.get(ApiConstants.productById(id));

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to load product: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await dio.get(ApiConstants.searchProducts(query));

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['products'];
        return productsJson
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to search products: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await dio.get(ApiConstants.productCategoryList);

      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = response.data;
        return categoriesJson.map((e) => e.toString()).toList();
      } else {
        throw ServerException(
          'Failed to load categories: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await dio.get(ApiConstants.productsByCategory(category));

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['products'];
        return productsJson
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to load products by category: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<ProductModel> addProduct({
    required String title,
    required String description,
    required String category,
    required double price,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.addProduct,
        data: {
          'title': title,
          'description': description,
          'category': category,
          'price': price,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to add product: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<ProductModel> updateProduct({
    required int id,
    String? title,
    String? description,
    double? price,
  }) async {
    try {
      final response = await dio.put(
        ApiConstants.productById(id),
        data: {
          if (title != null) 'title': title,
          if (description != null) 'description': description,
          if (price != null) 'price': price,
        },
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          'Failed to update product: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      final response = await dio.delete(ApiConstants.productById(id));

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to delete product: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  /// Dio 에러를 의미있는 메시지로 변환
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return 'Bad response: ${e.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'Connection error';
      default:
        return 'Network error: ${e.message}';
    }
  }
}
