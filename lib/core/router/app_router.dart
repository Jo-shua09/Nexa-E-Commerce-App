import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/presentation/scaffold_with_nav_bar.dart';
import 'package:nexa/features/address/presentation/address_list_screen.dart';
import 'package:nexa/features/address/presentation/new_address_screen.dart';
import 'package:nexa/features/account/presentation/account_screen.dart';
import 'package:nexa/features/orders/presentation/my_orders_screen.dart';
import 'package:nexa/features/orders/presentation/track_order_screen.dart';
import 'package:nexa/features/auth/presentation/screens/forgot_password.dart';
import 'package:nexa/features/auth/presentation/screens/reset_password.dart';
import 'package:nexa/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:nexa/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:nexa/features/auth/presentation/screens/verification_code.dart';
import 'package:nexa/features/cart/presentation/cart_screen.dart';
import 'package:nexa/features/cart/presentation/checkout_screen.dart';
import 'package:nexa/features/home/presentation/home_screen.dart';
import 'package:nexa/features/notifications/presentation/notification_screen.dart';
import 'package:nexa/features/payment/presentation/new_card_screen.dart';
import 'package:nexa/features/payment/presentation/payment_method_screen.dart';
import 'package:nexa/features/products/presentation/product_details_screen.dart';
import 'package:nexa/features/products/presentation/reviews_screen.dart';
import 'package:nexa/features/profile/presentation/customer_service_chat_screen.dart';
import 'package:nexa/features/profile/presentation/faq_screen.dart';
import 'package:nexa/features/profile/presentation/help_center_screen.dart';
import 'package:nexa/features/profile/presentation/my_details_screen.dart';
import 'package:nexa/features/profile/presentation/notification_settings_screen.dart';
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cart',
                builder: (context, state) => const CartScreen(),
                routes: [
                  GoRoute(
                    path: 'checkout',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const CheckoutScreen(),
                    routes: [
                      GoRoute(
                        path: 'address',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) => const AddressListScreen(),
                      ),
                      GoRoute(
                        path: 'new-address',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) => const NewAddressScreen(),
                      ),
                      GoRoute(
                        path: 'payment-method',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) =>
                            const PaymentMethodScreen(),
                        routes: [
                          GoRoute(
                            path: 'new-card',
                            parentNavigatorKey: rootNavigatorKey,
                            builder: (context, state) => const NewCardScreen(),
                          ),
                        ],
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
                path: '/account',
                builder: (context, state) => const AccountScreen(),
                routes: [
                  GoRoute(
                    path: 'details',
                    builder: (context, state) => const MyDetailsScreen(),
                  ),
                  GoRoute(
                    path: 'notification-settings',
                    builder: (context, state) =>
                        const NotificationSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'faqs',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const FAQScreen(),
                  ),
                  GoRoute(
                    path: 'help-center',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const HelpCenterScreen(),
                    routes: [
                      GoRoute(
                        path: 'chat',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) =>
                            const CustomerServiceChatScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'orders',
                    builder: (context, state) => const MyOrdersScreen(),
                    routes: [
                      GoRoute(
                        path: 'track/:orderId',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) {
                          final orderId = state.pathParameters['orderId']!;
                          return TrackOrderScreen(orderId: orderId);
                        },
                      ),
                    ],
                  ),
                ],
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
