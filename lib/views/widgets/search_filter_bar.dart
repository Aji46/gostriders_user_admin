import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../providers/product_provider.dart';
import '../../utils/responsive.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(padding, 24, padding, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search field
          TextField(
            onChanged: provider.setSearchQuery,
            style: const TextStyle(color: AppColors.textWhite),
            decoration: InputDecoration(
              hintText: 'Search helmets, gloves, accessories...',
              prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
              suffixIcon: provider.searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textGrey),
                      onPressed: () => provider.setSearchQuery(''),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 14),
          // Category chips
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: provider.categoryFilters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = provider.categoryFilters[index];
                final isSelected = provider.selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) => provider.setCategoryFilter(category),
                  selectedColor: AppColors.primaryYellow,
                  backgroundColor: AppColors.surfaceLight,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : AppColors.textWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primaryYellow
                          : AppColors.divider,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
