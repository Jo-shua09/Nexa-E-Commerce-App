import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/features/auth/presentation/screens/sign_in_screen.dart';

bool isButtonActive = true;

class VerificationCode extends ConsumerWidget {
  const VerificationCode({super.key});

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
              "Enter 4 Digit Code",
              style: AppTextStyles.header2SemiBold.copyWith(
                color: AppColors.gray900,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Enter 4 digit code that you received on your email (email). ",
              style: AppTextStyles.body3Regular.copyWith(
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: 60,
                  height: 60,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Email not received? ",
                  style: AppTextStyles.body3Regular.copyWith(
                    color: AppColors.gray500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Resend code",
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isButtonActive
                    ? () {
                        context.push('/reset-password');
                      }
                    : null,
                child: Text(
                  "Continue",
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
