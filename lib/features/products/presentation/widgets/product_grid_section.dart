import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/features/products/presentation/providers/product_providers.dart';
import 'package:nexa/features/products/presentation/widgets/product_card.dart';
import 'package:nexa/features/products/presentation/widgets/product_card_skeleton.dart';

class ProductGridSection extends ConsumerWidget {
  const ProductGridSection({super.key, required this.selectedCategory});

  final String selectedCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return productsAsync.when(
      loading: () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => const ProductCardSkeleton(),
      ),
      error: (err, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'Failed to load items: $err',
            style: AppTextStyles.body2Regular.copyWith(color: AppColors.error),
          ),
        ),
      ),
      data: (products) {
        final filteredProducts = selectedCategory == 'All'
            ? products
            : products
                  .where(
                    (product) =>
                        product.category.toLowerCase() ==
                        selectedCategory.toLowerCase(),
                  )
                  .toList();

        if (filteredProducts.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Text(
                'No products found in this category.',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 14,
                  color: AppColors.gray500,
                ),
              ),
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return ProductCard(
              product: product,
              onTap: () {
                context.go('/home/product/${product.id}');
              },
            );
          },
        );
      },
    );
  }
}
