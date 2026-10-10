import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/features/auth/presentation/screens/forgot_password.dart';
import 'package:nexa/features/auth/presentation/screens/reset_password.dart';
import 'package:nexa/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:nexa/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:nexa/features/auth/presentation/screens/verification_code.dart';
import 'package:nexa/features/home/presentation/screens/home_screen.dart';
import 'package:nexa/features/startup/presentation/onboarding_screen.dart';
import 'package:nexa/features/startup/presentation/splash_screen.dart';

final authStateProvider = StateProvider<bool>((ref) => false);

final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isGoingToAuth = state.matchedLocation == '/login';
      final isGoingToSplash = state.matchedLocation == '/splash';

      if (isGoingToSplash) return null;

      if (!isAuthenticated && !isGoingToAuth) {
        return '/login';
      }

      if (isAuthenticated && isGoingToAuth) {
        return '/home';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        name: 'sign in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        name: 'sign up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot password',
        builder: (context, state) => const ForgotPassword(),
      ),
      GoRoute(
        path: '/verification-code',
        name: 'verification code',
        builder: (context, state) => const VerificationCode(),
      ),
      GoRoute(
        path: '/reset-password',
        name: 'reset password',
        builder: (context, state) => const ResetPassword(),
      ),

      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'product/:id',
            name: 'product-details',
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return Scaffold(
                appBar: AppBar(),
                body: Center(child: Text("Product Details: $productId")),
              );
            },
          ),
        ],
      ),
    ],
  );
});
