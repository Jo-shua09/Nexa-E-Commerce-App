import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexa/features/orders/data/repositories/order_repository.dart';
import 'package:nexa/features/orders/domain/models/order_model.dart';

export 'package:nexa/features/orders/domain/models/order_model.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return FirestoreOrderRepository(FirebaseFirestore.instance);
});

final userOrdersProvider = StreamProvider<List<OrderModel>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(const []);
  return ref.watch(orderRepositoryProvider).watchOrders(userId);
});

final ongoingOrdersProvider = Provider<AsyncValue<List<OrderModel>>>((ref) {
  return ref
      .watch(userOrdersProvider)
      .whenData(
        (orders) =>
            orders.where((order) => order.status != 'Delivered').toList(),
      );
});

final orderByIdProvider = StreamProvider.family<OrderModel?, String>((
  ref,
  orderId,
) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(null);
  return ref.watch(orderRepositoryProvider).watchOrder(userId, orderId);
});

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
