import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexa/features/cart/data/repositories/cart_repository.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return FirestoreCartRepository(FirebaseFirestore.instance);
});

final cartProvider = StreamProvider<List<CartItem>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(const []);
  return ref.watch(cartRepositoryProvider).watchCart(userId);
});

Future<bool> runCartAction(
  BuildContext context,
  WidgetRef ref,
  Future<void> Function(CartRepository repository, String userId) action,
) async {
  final userId = ref.read(currentUserIdProvider);
  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign in to update your cart.')),
    );
    return false;
  }

  try {
    await action(ref.read(cartRepositoryProvider), userId);
    return true;
  } on FirebaseException catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Unable to update your cart.')),
      );
    }
    return false;
  }
}

final cartSubtotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider).asData?.value ?? const <CartItem>[];
  return items.fold(0.0, (subtotal, item) => subtotal + item.totalPrice);
});

const double shippingFee = 80.00;
const double vatPercentage = 0.00;

final cartTotalProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  if (subtotal == 0) return 0.0;
  return subtotal + shippingFee + (subtotal * vatPercentage);
});

final cartItemCountProvider = Provider<int>((ref) {
  final items = ref.watch(cartProvider).asData?.value ?? const <CartItem>[];
  return items.map((item) => item.product.id).toSet().length;
});
