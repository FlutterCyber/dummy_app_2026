import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/entity/product.dart';
import '../bloc/all_products/all_products_bloc.dart';
import '../widgets/sort_bottom_sheet.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final TextEditingController _searchController = TextEditingController();

  String? _activeSortBy;
  String? _activeOrder;
  String? _activeSortLabel;

  @override
  void initState() {
    super.initState();
    context.read<AllProductsBloc>().add(const AllProductsRequested());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      context.read<AllProductsBloc>().add(
        AllProductsRequested(sortBy: _activeSortBy, order: _activeOrder),
      );
    } else {
      context.read<AllProductsBloc>().add(
        SearchProductsRequested(query.trim(), sortBy: _activeSortBy, order: _activeOrder),
      );
    }
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SortBottomSheet(
        activeSortBy: _activeSortBy,
        activeOrder: _activeOrder,
        onSortSelected: (sortBy, order, label) {
          setState(() {
            _activeSortBy = sortBy;
            _activeOrder = order;
            _activeSortLabel = label;
          });
          final query = _searchController.text.trim();
          context.read<AllProductsBloc>().add(
            query.isEmpty
                ? AllProductsRequested(sortBy: sortBy, order: order)
                : SearchProductsRequested(query, sortBy: sortBy, order: order),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: _activeSortBy != null,
              child: const Icon(Icons.sort_rounded),
            ),
            onPressed: _showSortSheet,
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              _searchController.clear();
              setState(() {
                _activeSortBy = null;
                _activeOrder = null;
                _activeSortLabel = null;
              });
              context.read<AllProductsBloc>().add(const AllProductsRequested());
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: ListenableBuilder(
                  listenable: _searchController,
                  builder: (context, _) => _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            context.read<AllProductsBloc>().add(
                              const AllProductsRequested(),
                            );
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, state) {
          if (state is AllProductsLoading || state is AllProductsInitial) {
            return _ShimmerList();
          }

          if (state is AllProductsError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.wifi_off_rounded,
                    size: 56,
                    color: colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ma\'lumot yuklanmadi',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () => context.read<AllProductsBloc>().add(
                      const AllProductsRequested(),
                    ),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Qayta urinish'),
                  ),
                ],
              ),
            );
          }

          if (state is AllProductsLoaded) {
            final products = state.allProductsResponse.products;

            if (products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 56,
                      color: colorScheme.outline,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Hech narsa topilmadi',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) =>
                  _ProductCard(product: products[index]),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);
    final isLowStock = product.stock <= 10;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => context.push('/products/${product.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.thumbnail,
                      width: 95,
                      height: 95,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                  if (product.discountPercentage > 0)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '-${product.discountPercentage.toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: colorScheme.onError,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                        if (isLowStock) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Low stock',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${discountedPrice.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (product.discountPercentage > 0)
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: colorScheme.outline,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: Colors.amber.shade600,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              product.rating.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHighest,
      highlightColor: colorScheme.surface,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, __) => Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 95,
                  height: 95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 70, height: 16, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Container(width: 140, height: 14, color: Colors.white),
                      const SizedBox(height: 12),
                      Container(width: 60, height: 18, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
