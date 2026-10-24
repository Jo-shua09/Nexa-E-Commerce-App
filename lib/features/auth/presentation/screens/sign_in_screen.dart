import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';
import 'package:nexa/features/auth/presentation/providers/auth_provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

final TextStyle linkStyle = TextStyle(
  decoration: TextDecoration.underline,
  decorationColor: AppColors.gray900,
  decorationThickness: 1.0,
  color: AppColors.gray900,
  fontWeight: FontWeight.w600,
);

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(_emailController.text.trim(), _passwordController.text);
      if (mounted) context.go('/home');
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Unable to sign in.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Sign in to your account",
                style: AppTextStyles.header2SemiBold.copyWith(
                  color: AppColors.gray900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "It's great to see you again.",
                style: AppTextStyles.body2Regular.copyWith(
                  color: AppColors.gray400,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Email",
                style: AppTextStyles.body2SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              Text(
                "Password",
                style: AppTextStyles.body2SemiBold.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    child: Icon(
                      _isObscure
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
                  text: 'Forgot your password? ',
                  style: AppTextStyles.body3Regular.copyWith(
                    color: AppColors.gray500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Reset your password',
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push("/forgot-password");
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  child: Text(
                    _isLoading ? "Signing in..." : "Sign in",
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
                height: 54,
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
                      const Text(
                        'G',
                        style: TextStyle(
                          color: AppColors.gray900,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Sign In with Google",
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
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1877F2),
                    side: const BorderSide(color: Color(0xFF1877F2)),
                  ),
                  onPressed: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.facebook_rounded,
                        color: AppColors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Sign In with Facebook",
                        style: AppTextStyles.body3SemiBold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: AppTextStyles.body3Regular.copyWith(
                      color: AppColors.gray500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Join',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go("/sign-up");
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
