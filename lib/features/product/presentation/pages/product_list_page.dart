import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/product_filter_controller.dart';
import '../providers/product_filter_state.dart';
import '../providers/product_list_provider.dart';
import '../../domain/entities/product_entity.dart';

/// ProductListPage - 상품 목록 페이지
class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  late final TextEditingController _searchController;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    final filter = ref.read(productFilterControllerProvider);
    _searchController = TextEditingController(text: filter.searchQuery);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productListAsync = ref.watch(productListProvider);
    final categoryListAsync = ref.watch(categoryListProvider);
    final filterState = ref.watch(productFilterControllerProvider);

    ref.listen<ProductFilterState>(productFilterControllerProvider, (
      previous,
      next,
    ) {
      if (_searchController.text != next.searchQuery) {
        _searchController.value = _searchController.value.copyWith(
          text: next.searchQuery,
          selection: TextSelection.collapsed(offset: next.searchQuery.length),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          if (filterState.hasCategory || filterState.hasQuery)
            IconButton(
              icon: const Icon(Icons.filter_alt_off),
              tooltip: '필터 초기화',
              onPressed: _clearFilters,
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(productListProvider.notifier).refresh();
            },
            tooltip: '새로고침',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(productListProvider.notifier).refresh();
        },
        child: productListAsync.when(
          loading: () => _buildScrollView(
            context: context,
            categoryListAsync: categoryListAsync,
            filterState: filterState,
            slivers: const [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
          error: (error, stackTrace) => _buildScrollView(
            context: context,
            categoryListAsync: categoryListAsync,
            filterState: filterState,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Error: $error',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        ref.read(productListProvider.notifier).refresh();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('다시 시도'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          data: (products) {
            final slivers = <Widget>[];

            if (products.isEmpty) {
              slivers.add(
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyProductView(),
                ),
              );
            } else {
              slivers.add(
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = products[index];
                      return _ProductCard(product: product);
                    }, childCount: products.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                  ),
                ),
              );
            }

            return _buildScrollView(
              context: context,
              categoryListAsync: categoryListAsync,
              filterState: filterState,
              slivers: slivers,
            );
          },
        ),
      ),
    );
  }

  Widget _buildScrollView({
    required BuildContext context,
    required AsyncValue<List<String>> categoryListAsync,
    required ProductFilterState filterState,
    required List<Widget> slivers,
  }) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _FilterSection(
            searchController: _searchController,
            onSearchChanged: _onSearchChanged,
            onSearchSubmitted: _onSearchSubmitted,
            categoryListAsync: categoryListAsync,
            filterState: filterState,
            onCategoryChanged: _onCategoryChanged,
          ),
        ),
        ...slivers,
      ],
    );
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      ref
          .read(productFilterControllerProvider.notifier)
          .setSearchQuery(value.trim());
    });
  }

  void _onSearchSubmitted(String value) {
    _searchDebounce?.cancel();
    ref
        .read(productFilterControllerProvider.notifier)
        .setSearchQuery(value.trim());
  }

  void _onCategoryChanged(String? value) {
    if (value == null) {
      return;
    }
    final current = ref.read(productFilterControllerProvider).selectedCategory;
    if (value == current) {
      return;
    }
    ref.read(productFilterControllerProvider.notifier).setCategory(value);
  }

  void _clearFilters() {
    _searchController.clear();
    ref.read(productFilterControllerProvider.notifier).clearFilters();
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.searchController,
    required this.onSearchChanged,
    required this.onSearchSubmitted,
    required this.categoryListAsync,
    required this.filterState,
    required this.onCategoryChanged,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onSearchSubmitted;
  final AsyncValue<List<String>> categoryListAsync;
  final ProductFilterState filterState;
  final ValueChanged<String?> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: '상품 검색',
              hintText: '검색어를 입력하세요',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: filterState.hasQuery
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      tooltip: '검색어 지우기',
                      onPressed: () {
                        searchController.clear();
                        onSearchSubmitted('');
                      },
                    )
                  : null,
              border: const OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
            onChanged: onSearchChanged,
            onSubmitted: onSearchSubmitted,
          ),
          const SizedBox(height: 16),
          categoryListAsync.when(
            data: (categories) {
              final items = ['all', ...categories];
              return DropdownButtonFormField<String>(
                initialValue: filterState.selectedCategory,
                items: items
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(_formatCategoryLabel(category)),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                  labelText: '카테고리',
                  border: OutlineInputBorder(),
                ),
                onChanged: onCategoryChanged,
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, stackTrace) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '카테고리를 불러오지 못했습니다: $error',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCategoryLabel(String category) {
    if (category == 'all') {
      return '전체';
    }
    if (category.isEmpty) {
      return '기타';
    }
    final normalized = category.replaceAll('-', ' ');
    if (normalized.length == 1) {
      return normalized.toUpperCase();
    }
    return normalized[0].toUpperCase() + normalized.substring(1);
  }
}

class _EmptyProductView extends StatelessWidget {
  const _EmptyProductView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            '조건에 맞는 상품이 없습니다',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.push('/products/${product.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.thumbnail,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      Text(
                        'Stock: ${product.stock}',
                        style: TextStyle(
                          fontSize: 12,
                          color: product.stock > 10
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
