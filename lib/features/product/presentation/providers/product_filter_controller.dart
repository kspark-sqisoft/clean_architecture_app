import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'product_filter_state.dart';

part 'product_filter_controller.g.dart';

/// 상품 목록 필터를 관리하는 컨트롤러
///
/// - 카테고리 선택
/// - 검색어 입력/초기화
@riverpod
class ProductFilterController extends _$ProductFilterController {
  @override
  ProductFilterState build() => const ProductFilterState();

  /// 카테고리를 변경합니다
  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  /// 검색어를 변경합니다
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// 필터를 모두 초기화합니다
  void clearFilters() {
    state = const ProductFilterState();
  }
}
