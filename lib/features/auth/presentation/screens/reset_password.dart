import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';

class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPasswordState();
}

bool isObscure = true;
bool isButtonActive = true;

class _ResetPasswordState extends ConsumerState<ResetPassword> {
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
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Icon(Icons.arrow_back_rounded, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              "Reset password",
              style: AppTextStyles.header2SemiBold.copyWith(
                color: AppColors.gray900,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Set the new password for your account so you can login and access all features.",
              style: AppTextStyles.body3Regular.copyWith(
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 16),
            Text(
              "Confirm password",
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
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isButtonActive
                    ? () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: AppColors.background,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: SvgPicture.asset(
                                          "assets/images/check.svg",
                                          width: 80,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "Password Changed",
                                        style: AppTextStyles.body1SemiBold
                                            .copyWith(color: AppColors.gray900),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "You can now use your new password to sign in to your account.",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.body3Regular
                                            .copyWith(color: AppColors.gray600),
                                      ),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: isButtonActive
                                              ? () {
                                                  context.push('/sign-in');
                                                }
                                              : null,
                                          child: Text(
                                            "Sign in",
                                            style: AppTextStyles.body3SemiBold
                                                .copyWith(
                                                  color: AppColors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        });
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
