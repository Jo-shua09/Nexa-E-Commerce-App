import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/features/products/domain/models/products.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/features/saved/presentation/providers/saved_providers.dart';

class SavedGridWidget extends ConsumerWidget {
  const SavedGridWidget({super.key, required this.items});
  final List<Product> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final product = items[index];
        final hasImage = product.images.isNotEmpty;

        return GestureDetector(
          onTap: () => context.push('/home/product/${product.id}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Red Heart Badge
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: hasImage
                            ? Image.network(
                                product.images.first,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.gray400,
                                  size: 28,
                                ),
                              )
                            : const Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.gray400,
                                size: 28,
                              ),
                      ),
                    ),

                    // Red Favorite Badge Button
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        tooltip: 'Remove ${product.title} from favorites',
                        onPressed: () {
                          ref
                              .read(savedProductsProvider.notifier)
                              .remove(product.id);
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.white,
                          shape: const CircleBorder(),
                          shadowColor: Colors.black.withValues(alpha: 0.08),
                          elevation: 3,
                        ),
                        icon: const Icon(
                          Icons.favorite_rounded,
                          size: 18,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Product Title
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body3SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 3),

              // Price
              Text(
                '\$ ${product.price.toStringAsFixed(2)}',
                style: AppTextStyles.body3SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
