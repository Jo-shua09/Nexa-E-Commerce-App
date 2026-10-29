import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/cart_repository.dart';
import '../../domain/models/cart_item.dart';

// 1. Auth State
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// 2. Live Cart Stream
final cartStreamProvider = StreamProvider<List<CartItem>>((ref) {
  final user = ref.watch(authStateProvider).value;
  
  if (user == null) {
    return Stream.value([]); // Return empty cart if logged out
  }
  
  final repository = ref.watch(cartRepositoryProvider);
  return repository.watchCart(user.uid);
});

// 3. Subtotal Calculation (Sum of all item prices * quantity)
final cartSubtotalProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartStreamProvider).value ?? [];
  return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
});

// 4. Total Calculation (Subtotal + 5% VAT + Shipping)
final cartTotalProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  
  if (subtotal == 0) return 0.0; // Don't add fees if cart is empty
  
  final vat = subtotal * 0.05; 
  const shippingCost = 15.0;
  
  return subtotal + vat + shippingCost;
});

// 5. Item Count Calculation (Fixes your badge error)
final cartItemCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartStreamProvider).value ?? [];
  return cartItems.fold(0, (sum, item) => sum + item.quantity);
});

// 6. Secure Firebase Action Helper
Future<bool> runCartAction(
  BuildContext context,
  WidgetRef ref,
  Future<dynamic> Function(CartRepository repository, String userId) action,
) async {
  final user = FirebaseAuth.instance.currentUser;
  
  if (user == null) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to update your cart')),
      );
    }
    return false;
  }

  final repository = ref.read(cartRepositoryProvider);
  await action(repository, user.uid);
  return true;
}