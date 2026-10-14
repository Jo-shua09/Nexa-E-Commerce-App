import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/features/products/domain/models/products.dart';

class SearchResultWidget extends StatelessWidget {
  final List<Product> results;
  final ValueChanged<Product> onSelectProduct;

  const SearchResultWidget({
    super.key,
    required this.results,
    required this.onSelectProduct,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      separatorBuilder: (_, __) =>
          const Divider(color: AppColors.gray100, thickness: 1, height: 1),
      itemBuilder: (context, index) {
        final product = results[index];
        final hasImage = product.images.isNotEmpty;

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          onTap: () => onSelectProduct(product),
          leading: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: hasImage
                  ? Image.network(
                      product.images.first,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.gray400,
                        size: 24,
                      ),
                    )
                  : const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.gray400,
                      size: 24,
                    ),
            ),
          ),
          title: Text(
            product.title,
            style: AppTextStyles.body3SemiBold.copyWith(
              color: AppColors.gray900,
              fontWeight: FontWeight.w900,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                Text(
                  '\$ ${product.price.toStringAsFixed(0)}',
                  style: AppTextStyles.body3Medium.copyWith(
                    color: AppColors.gray500,
                  ),
                ),
                // Example discount badge displayed in screenshot
                if (product.id == "2") ...[
                  const SizedBox(width: 6),
                  Text(
                    '-52%',
                    style: AppTextStyles.body3SemiBold.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
          trailing: const Icon(
            Icons.north_east_rounded,
            color: AppColors.gray900,
            size: 20,
          ),
        );
      },
    );
  }
}
