import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';

class RecentSearchWidget extends StatelessWidget {
  final List<String> recentSearches;
  final ValueChanged<String> onSelect;
  final ValueChanged<String> onRemove;
  final VoidCallback onClearAll;

  const RecentSearchWidget({
    super.key,
    required this.recentSearches,
    required this.onSelect,
    required this.onRemove,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) {
      return Center(
        child: Text(
          'No recent searches',
          style: AppTextStyles.body2Regular.copyWith(color: AppColors.gray400),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Searches',
              style: AppTextStyles.body1SemiBold.copyWith(
                color: AppColors.gray900,
              ),
            ),
            GestureDetector(
              onTap: onClearAll,
              child: Text(
                'Clear all',
                style: AppTextStyles.body2Regular.copyWith(
                  color: AppColors.gray900,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ...recentSearches.map((term) {
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                onTap: () => onSelect(term),
                title: Text(
                  term,
                  style: AppTextStyles.body2Regular.copyWith(
                    color: AppColors.gray700,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () => onRemove(term),
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: AppColors.gray400,
                    size: 20,
                  ),
                ),
              ),
              const Divider(color: AppColors.gray100, thickness: 1, height: 1),
            ],
          );
        }),
      ],
    );
  }
}
