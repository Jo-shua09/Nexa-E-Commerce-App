import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/core/widgets/cart_icon_with_badge.dart';
import 'package:nexa/core/widgets/circular_icon_button.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';
import 'package:nexa/features/cart/presentation/providers/cart_provider.dart';
import 'package:nexa/features/saved/presentation/providers/saved_providers.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  String _selectedSize = 'S';
  final List<String> _sizes = ['S', 'M', 'L'];

  @override
  Widget build(BuildContext context) {
    // Find the product from dummyProducts or fallback to the first item
    final product = dummyProducts.firstWhere(
      (p) => p.id == widget.productId,
      orElse: () => dummyProducts.first,
    );

    final isSaved = ref
        .watch(savedProductsProvider)
        .any((item) => item.id == product.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.gray900,
            size: 24,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Details',
          style: AppTextStyles.header2SemiBold.copyWith(
            color: AppColors.gray900,
          ),
        ),
        centerTitle: true,
        actions: [
          const CartIconWithBadge(),
          CircularIconButton(
            icon: Icons.notifications_none_rounded,
            hasBadge: true,
            onTap: () {
              context.push('/notifications');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 380,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: product.images.isNotEmpty
                        ? Image.network(
                            product.images.first,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.gray400,
                              size: 40,
                            ),
                          )
                        : const Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.gray400,
                            size: 40,
                          ),
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(savedProductsProvider.notifier)
                          .toggleSave(product);
                    },
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        isSaved
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 24,
                        color: isSaved ? AppColors.error : AppColors.gray900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: AppTextStyles.header3SemiBold.copyWith(
                color: AppColors.gray900,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                context.push('/home/product/${widget.productId}/reviews');
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFB800),
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${product.rating.toStringAsFixed(1)}/5',
                    style: AppTextStyles.body2SemiBold.copyWith(
                      color: AppColors.gray900,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '(${product.reviewsCount} reviews)',
                    style: AppTextStyles.body2Regular.copyWith(
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              product.description,
              style: AppTextStyles.body2Regular.copyWith(
                color: AppColors.gray500,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Choose size',
              style: AppTextStyles.body1SemiBold.copyWith(
                color: AppColors.gray900,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: _sizes.map((size) {
                final isSelected = _selectedSize == size;
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedSize = size),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.gray900
                              : AppColors.gray200,
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        size,
                        style: AppTextStyles.body1SemiBold.copyWith(
                          color: isSelected
                              ? AppColors.gray900
                              : AppColors.gray600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.gray100, width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              // Price Display
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: AppTextStyles.body3Regular.copyWith(
                      color: AppColors.gray400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$ ${product.price.toStringAsFixed(0)}',
                    style: AppTextStyles.header3SemiBold.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 28),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .addToCart(product, _selectedSize);

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.gray900,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(16),
                          content: Text(
                            'Added ${product.title} (Size $_selectedSize) to cart',
                            style: AppTextStyles.body2Regular.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          action: SnackBarAction(
                            label: 'View Cart',
                            textColor: AppColors.white,
                            onPressed: () {
                              context.go('/cart');
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gray900,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          size: 20,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Add to Cart',
                          style: AppTextStyles.body1SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
