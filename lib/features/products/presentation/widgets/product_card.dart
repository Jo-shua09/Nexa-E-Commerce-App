import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/features/products/domain/models/products.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = product.images.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: hasImage
                        ? Image.asset(
                            product.images.first,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.gray400,
                                  size: 28,
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.gray400,
                              size: 28,
                            ),
                          ),
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        size: 18,
                        color: product.isFavorite
                            ? AppColors.error
                            : AppColors.gray900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.category.toUpperCase(),
                style: AppTextStyles.body3Regular.copyWith(
                  color: AppColors.gray500,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 15,
                    color: Color(0xFFFFB800),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: AppTextStyles.body3SemiBold.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body3SemiBold.copyWith(
              color: AppColors.gray900,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: AppTextStyles.body3SemiBold.copyWith(
              color: AppColors.gray900,
            ),
          ),
        ],
      ),
    );
  }
}
