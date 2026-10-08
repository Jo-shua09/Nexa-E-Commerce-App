import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

bool isObscure = true;
bool isButtonActive = true;

final TextStyle LinkStyle = TextStyle(
  decoration: TextDecoration.underline,
  decorationColor: AppColors.gray900,
  decorationThickness: 1.0,
  color: AppColors.gray900,
  fontWeight: FontWeight.w600,
);

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Create an account",
              style: AppTextStyles.header2SemiBold.copyWith(
                color: AppColors.gray900,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Let\'s create your account",
              style: AppTextStyles.body2Regular.copyWith(
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Full Name",
              style: AppTextStyles.body2SemiBold.copyWith(
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 4),
            TextField(keyboardType: TextInputType.text),
            const SizedBox(height: 12),

            Text(
              "Email",
              style: AppTextStyles.body2SemiBold.copyWith(
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 4),
            TextField(keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 12),

            Text(
              "Password",
              style: AppTextStyles.body2SemiBold.copyWith(
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: isObscure,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  child: Icon(
                    isObscure
                        ? Icons.visibility_off
                        : Icons.visibility_outlined,
                    size: 22,
                    color: AppColors.gray400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text.rich(
              TextSpan(
                text: 'By signing up you agree to our ',
                style: AppTextStyles.body3Regular.copyWith(
                  color: AppColors.gray500,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Terms', style: LinkStyle),
                  TextSpan(text: ', '),
                  TextSpan(text: 'Privacy Policy', style: LinkStyle),
                  TextSpan(text: ', '),
                  TextSpan(text: 'and '),
                  TextSpan(text: 'Cookie Use', style: LinkStyle),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isButtonActive
                    ? () {
                        context.go('/home');
                      }
                    : null,
                child: Text(
                  "Create an Account",
                  style: AppTextStyles.body3SemiBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    height: 1,
                    color: AppColors.gray200,
                    thickness: .7,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Or',
                    style: AppTextStyles.body3Medium.copyWith(
                      color: AppColors.gray600,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 1,
                    color: AppColors.gray200,
                    thickness: .7,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  side: BorderSide(color: AppColors.gray200),
                ),
                onPressed: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //!! Google Logo here
                    const SizedBox(height: 12),
                    Text(
                      "Sign Up with Google",
                      style: AppTextStyles.body3SemiBold.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  side: BorderSide(color: Colors.blueAccent),
                ),
                onPressed: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //!! Facebook Logo here
                    const SizedBox(height: 12),
                    Text(
                      "Sign Up with Facebook",
                      style: AppTextStyles.body3SemiBold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: AppTextStyles.body3Regular.copyWith(
                    color: AppColors.gray500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Log in',
                      style: LinkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go("/sign-in");
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
