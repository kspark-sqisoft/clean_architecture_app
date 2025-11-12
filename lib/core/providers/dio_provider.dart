import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../network/api_client.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  return ApiClient().dio;
}
