import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_filter_state.freezed.dart';

/// 상품 목록 필터 상태
///
/// - [selectedCategory]: 현재 선택된 카테고리 (`all` = 전체 보기)
/// - [searchQuery]: 상품 검색어
@freezed
class ProductFilterState with _$ProductFilterState {
  const factory ProductFilterState({
    @Default('all') String selectedCategory,
    @Default('') String searchQuery,
  }) = _ProductFilterState;

  const ProductFilterState._();

  /// 카테고리가 선택되었는지 여부 (`all`이 아닌 경우)
  bool get hasCategory => selectedCategory.toLowerCase() != 'all';

  /// 검색어가 입력되었는지 여부
  bool get hasQuery => searchQuery.trim().isNotEmpty;
}
