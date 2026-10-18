import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/features/cart/presentation/providers/cart_provider.dart';

class CartIconWithBadge extends ConsumerWidget {
  const CartIconWithBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(cartItemCountProvider);

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        IconButton(
          tooltip: count == 0 ? 'Cart' : 'Cart, $count items',
          icon: const Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.gray900,
            size: 22,
          ),
          onPressed: () => context.go('/cart'),
        ),
        if (count > 0)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                count > 99 ? '99+' : '$count',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  height: 1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
