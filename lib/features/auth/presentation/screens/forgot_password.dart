import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';

bool isButtonActive = true;

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Icon(Icons.arrow_back_rounded, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              "Forgot password",
              style: AppTextStyles.header2SemiBold.copyWith(
                color: AppColors.gray900,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Enter your email for the verification process, we will send a 4 digit code to your email.",
              style: AppTextStyles.body3Regular.copyWith(
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Email",
              style: AppTextStyles.body2SemiBold.copyWith(
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 4),
            TextField(keyboardType: TextInputType.emailAddress),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isButtonActive
                    ? () {
                        context.push('/verification-code');
                      }
                    : null,
                child: Text(
                  "Send Code",
                  style: AppTextStyles.body3SemiBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
