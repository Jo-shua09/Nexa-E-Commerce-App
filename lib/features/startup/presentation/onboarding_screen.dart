import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            final titleFontSize = (screenWidth * 0.15).clamp(42.0, 58.0);

            return Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.12,
                  left: 0,
                  right: 0,
                  height: screenHeight * 0.84,
                  child: Image.asset(
                    "assets/images/onboarding_splash.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 16,
                  left: 20,
                  width: screenWidth * 0.88,
                  child: Text(
                    'Define\nyourself in\nyour unique\nway.',
                    style: TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w700,
                      height: 0.80,
                      letterSpacing: -1.0,
                      color: AppColors.gray900,
                    ),
                  ),
                ),

                Positioned(
                  right: 0,
                  width: screenWidth * .95,
                  height: screenHeight * 0.68,
                  bottom: 90,
                  child: Image.asset(
                    "assets/images/onboarding.png",
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 12,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/sign-up');
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
                        Text(
                          'Get Started',
                          style: AppTextStyles.body3SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
