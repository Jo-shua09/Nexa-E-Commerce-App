import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/presentation/scaffold_with_nav_bar.dart';
import 'package:nexa/features/auth/presentation/screens/forgot_password.dart';
import 'package:nexa/features/auth/presentation/screens/reset_password.dart';
import 'package:nexa/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:nexa/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:nexa/features/auth/presentation/screens/verification_code.dart';
import 'package:nexa/features/home/presentation/home_screen.dart';
import 'package:nexa/features/notifications/presentation/notification_screen.dart';
import 'package:nexa/features/products/presentation/product_details_screen.dart';
import 'package:nexa/features/products/presentation/reviews_screen.dart';
import 'package:nexa/features/saved/presentation/saved_screen.dart';
import 'package:nexa/features/search/presentation/search_screen.dart';
import 'package:nexa/features/startup/presentation/onboarding_screen.dart';
import 'package:nexa/features/startup/presentation/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final authStateProvider = StateProvider<bool>((ref) => false);

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = ref.read(authStateProvider);
      final isGoingToPublicRoute = {
        '/onboarding',
        '/sign-in',
        '/sign-up',
        '/forgot-password',
        '/verification-code',
        '/reset-password',
      }.contains(state.matchedLocation);
      final isGoingToSplash = state.matchedLocation == '/splash';

      if (isGoingToSplash) return null;

      if (!isAuthenticated && !isGoingToPublicRoute) {
        return '/sign-in';
      }

      if (isAuthenticated &&
          {'/sign-in', '/sign-up'}.contains(state.matchedLocation)) {
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
        path: '/notifications',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const NotificationsScreen(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
                routes: [
                  GoRoute(
                    path: 'product/:id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return ProductDetailsScreen(productId: id);
                    },
                    routes: [
                      GoRoute(
                        path: 'reviews',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return ReviewsScreen(productId: id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/saved',
                builder: (context, state) => const SavedScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.listen(authStateProvider, (previous, next) {
    router.refresh();
  });
  ref.onDispose(router.dispose);

  return router;
});
