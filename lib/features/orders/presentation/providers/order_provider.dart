import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexa/features/orders/data/repositories/order_repository.dart';
import 'package:nexa/features/orders/domain/models/order_model.dart';

// Get current user ID safely
final currentUserIdProvider = Provider<String?>((ref) {
  return FirebaseAuth.instance.currentUser?.uid;
});

// THIS IS THE MISSING PROVIDER - Streams ALL orders for the user
final userOrdersProvider = StreamProvider<List<OrderModel>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(const []);

  return ref.watch(orderRepositoryProvider).watchOrders(userId);
});

// Filter for ongoing orders
final ongoingOrdersProvider = Provider<AsyncValue<List<OrderModel>>>((ref) {
  return ref
      .watch(userOrdersProvider)
      .whenData(
        (orders) =>
            orders.where((order) => order.status != 'Delivered').toList(),
      );
});

// Stream specific order
final orderByIdProvider = StreamProvider.family<OrderModel?, String>((
  ref,
  orderId,
) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(null);

  return ref.watch(orderRepositoryProvider).watchOrder(userId, orderId);
});

// Helper for UI buttons
Future<bool> runOrderAction(
  BuildContext context,
  WidgetRef ref,
  Future<void> Function(OrderRepository repository, String userId) action,
) async {
  final userId = ref.read(currentUserIdProvider);
  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign in to manage your orders.')),
    );
    return false;
  }

  try {
    await action(ref.read(orderRepositoryProvider), userId);
    return true;
  } on FirebaseException catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Unable to update your order.'),
        ),
      );
    }
  } on StateError catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.message)));
    }
  }
  return false;
}
