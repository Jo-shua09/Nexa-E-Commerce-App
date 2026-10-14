import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';

class EmptySavedWidget extends StatelessWidget {
  const EmptySavedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_outline_rounded,
              size: 80,
              color: AppColors.gray300,
            ),
            const SizedBox(height: 24),
            Text(
              'No Saved Items!',
              style: AppTextStyles.header2SemiBold.copyWith(
                color: AppColors.gray900,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'You don’t have any saved items.\nGo to home and add some.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body2Regular.copyWith(
                color: AppColors.gray400,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
