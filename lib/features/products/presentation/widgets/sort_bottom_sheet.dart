import 'package:flutter/material.dart';

class SortBottomSheet extends StatelessWidget {
  final String? activeSortBy;
  final String? activeOrder;
  final void Function(String? sortBy, String? order, String? label) onSortSelected;

  const SortBottomSheet({
    super.key,
    required this.activeSortBy,
    required this.activeOrder,
    required this.onSortSelected,
  });

  static const _sortOptions = [
    {'label': 'Price: Low to High', 'sortBy': 'price', 'order': 'asc'},
    {'label': 'Price: High to Low', 'sortBy': 'price', 'order': 'desc'},
    {'label': 'Rating: High to Low', 'sortBy': 'rating', 'order': 'desc'},
    {'label': 'Discount: Highest', 'sortBy': 'discountPercentage', 'order': 'desc'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Sort by',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ..._sortOptions.map((option) {
            final isActive = activeSortBy == option['sortBy'] && activeOrder == option['order'];
            return ListTile(
              title: Text(option['label']!),
              trailing: isActive
                  ? Icon(Icons.check_rounded, color: Theme.of(context).colorScheme.primary)
                  : null,
              onTap: () {
                Navigator.pop(context);
                if (isActive) {
                  onSortSelected(null, null, null);
                } else {
                  onSortSelected(option['sortBy'], option['order'], option['label']);
                }
              },
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
