import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architectue_app/core/constants/api_constants.dart';
import 'package:clean_architectue_app/core/error/exceptions.dart';
import 'package:clean_architectue_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:clean_architectue_app/features/product/data/models/product_model.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  late _MockDio dio;
  late ProductRemoteDataSource dataSource;

  const tProductId = 1;
  const tLimit = 10;
  const tSkip = 0;
  const tQuery = 'laptop';
  const tCategory = 'smartphones';

  final tProductJson = {
    'id': tProductId,
    'title': 'iPhone 9',
    'description': 'An apple mobile',
    'category': 'smartphones',
    'price': 549,
    'rating': 4.69,
    'stock': 94,
    'thumbnail': 'https://cdn.dummyjson.com/products/1/thumbnail.jpg',
  };

  final tProductsResponse = {
    'products': [
      tProductJson,
      {
        'id': 2,
        'title': 'iPhone X',
        'description': 'SIM-Free, Model A19211',
        'category': 'smartphones',
        'price': 899,
        'rating': 4.44,
        'stock': 34,
        'thumbnail': 'https://cdn.dummyjson.com/products/2/thumbnail.jpg',
      },
    ],
    'total': 100,
    'skip': 0,
    'limit': 10,
  };

  final tCategoriesResponse = ['smartphones', 'laptops', 'fragrances'];

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
    registerFallbackValue(Options());
  });

  setUp(() {
    dio = _MockDio();
    dataSource = ProductRemoteDataSourceImpl(dio: dio);
  });

  group('getAllProducts', () {
    test('should return List<ProductModel> when status code is 200', () async {
      final response = Response<dynamic>(
        data: tProductsResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.products),
      );

      when(
        () => dio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => response);

      final result = await dataSource.getAllProducts(
        limit: tLimit,
        skip: tSkip,
      );

      expect(result, isA<List<ProductModel>>());
      expect(result.length, 2);
      expect(result.first.id, tProductId);
      expect(result.first.title, 'iPhone 9');

      verify(
        () => dio.get(
          ApiConstants.products,
          queryParameters: {'limit': tLimit, 'skip': tSkip},
        ),
      ).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tProductsResponse,
        statusCode: 400,
        requestOptions: RequestOptions(path: ApiConstants.products),
      );

      when(
        () => dio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => response);

      expect(
        () => dataSource.getAllProducts(limit: tLimit),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException on DioException', () async {
      when(
        () => dio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ApiConstants.products),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(
        () => dataSource.getAllProducts(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getProductById', () {
    test('should return ProductModel when status code is 200', () async {
      final response = Response<dynamic>(
        data: tProductJson,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: ApiConstants.productById(tProductId),
        ),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      final result = await dataSource.getProductById(tProductId);

      expect(result, isA<ProductModel>());
      expect(result.id, tProductId);
      expect(result.title, 'iPhone 9');

      verify(() => dio.get(ApiConstants.productById(tProductId))).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tProductJson,
        statusCode: 404,
        requestOptions: RequestOptions(
          path: ApiConstants.productById(tProductId),
        ),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      expect(
        () => dataSource.getProductById(tProductId),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('searchProducts', () {
    test('should return List<ProductModel> when status code is 200', () async {
      final response = Response<dynamic>(
        data: tProductsResponse,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: ApiConstants.searchProducts(tQuery),
        ),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      final result = await dataSource.searchProducts(tQuery);

      expect(result, isA<List<ProductModel>>());
      expect(result.length, 2);

      verify(() => dio.get(ApiConstants.searchProducts(tQuery))).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tProductsResponse,
        statusCode: 400,
        requestOptions: RequestOptions(
          path: ApiConstants.searchProducts(tQuery),
        ),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      expect(
        () => dataSource.searchProducts(tQuery),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getCategories', () {
    test('should return List<String> when status code is 200', () async {
      final response = Response<dynamic>(
        data: tCategoriesResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.productCategoryList),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      final result = await dataSource.getCategories();

      expect(result, isA<List<String>>());
      expect(result.length, 3);
      expect(result.first, 'smartphones');

      verify(() => dio.get(ApiConstants.productCategoryList)).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tCategoriesResponse,
        statusCode: 400,
        requestOptions: RequestOptions(path: ApiConstants.productCategoryList),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      expect(() => dataSource.getCategories(), throwsA(isA<ServerException>()));
    });
  });

  group('getProductsByCategory', () {
    test('should return List<ProductModel> when status code is 200', () async {
      final response = Response<dynamic>(
        data: tProductsResponse,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: ApiConstants.productsByCategory(tCategory),
        ),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      final result = await dataSource.getProductsByCategory(tCategory);

      expect(result, isA<List<ProductModel>>());
      expect(result.length, 2);

      verify(
        () => dio.get(ApiConstants.productsByCategory(tCategory)),
      ).called(1);
    });

    test('should throw ServerException when status code is not 200', () async {
      final response = Response<dynamic>(
        data: tProductsResponse,
        statusCode: 400,
        requestOptions: RequestOptions(
          path: ApiConstants.productsByCategory(tCategory),
        ),
      );

      when(() => dio.get(any())).thenAnswer((_) async => response);

      expect(
        () => dataSource.getProductsByCategory(tCategory),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
