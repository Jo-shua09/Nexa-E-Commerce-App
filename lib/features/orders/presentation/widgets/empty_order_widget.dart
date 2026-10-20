import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';

class EmptyOrderWidget extends StatelessWidget {
  const EmptyOrderWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: AppColors.gray300,
          ),
          const SizedBox(height: 24),
          Text(
            'No Ongoing Orders!',
            style: AppTextStyles.header2SemiBold.copyWith(
              color: AppColors.gray900,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'You don’t have any ongoing orders\nat this time.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body2Regular.copyWith(
              color: AppColors.gray400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
