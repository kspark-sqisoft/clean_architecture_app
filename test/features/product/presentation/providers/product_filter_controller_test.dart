import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import 'package:clean_architectue_app/features/product/presentation/providers/product_filter_controller.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  test('초기 상태는 전체 카테고리와 빈 검색어이다', () {
    final state = container.read(productFilterControllerProvider);

    expect(state.selectedCategory, 'all');
    expect(state.searchQuery, '');
    expect(state.hasCategory, isFalse);
    expect(state.hasQuery, isFalse);
  });

  test('카테고리를 변경하면 hasCategory가 true가 된다', () {
    container
        .read(productFilterControllerProvider.notifier)
        .setCategory('beauty');

    final state = container.read(productFilterControllerProvider);

    expect(state.selectedCategory, 'beauty');
    expect(state.hasCategory, isTrue);
    expect(state.hasQuery, isFalse);
  });

  test('검색어를 변경하면 hasQuery가 true가 된다', () {
    container
        .read(productFilterControllerProvider.notifier)
        .setSearchQuery('phone');

    final state = container.read(productFilterControllerProvider);

    expect(state.searchQuery, 'phone');
    expect(state.hasQuery, isTrue);
    expect(state.hasCategory, isFalse);
  });

  test('clearFilters를 호출하면 상태가 초기화된다', () {
    final notifier = container.read(productFilterControllerProvider.notifier);
    notifier.setCategory('beauty');
    notifier.setSearchQuery('phone');

    notifier.clearFilters();

    final state = container.read(productFilterControllerProvider);

    expect(state.selectedCategory, 'all');
    expect(state.searchQuery, '');
    expect(state.hasCategory, isFalse);
    expect(state.hasQuery, isFalse);
  });
}
