import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexa/features/cart/data/repositories/cart_repository.dart';
import 'package:nexa/features/orders/domain/models/order_model.dart';

abstract class OrderRepository {
  Stream<List<OrderModel>> watchOrders(String userId);
  Stream<OrderModel?> watchOrder(String userId, String orderId);
  Future<void> placeOrder(String userId, List<CartItem> cartItems);
  Future<void> submitReview(String userId, String orderId, double score);
}

class FirestoreOrderRepository implements OrderRepository {
  FirestoreOrderRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _orders(String userId) =>
      _firestore.collection('users').doc(userId).collection('orders');

  CollectionReference<Map<String, dynamic>> _cart(String userId) =>
      _firestore.collection('users').doc(userId).collection('cart');

  @override
  Stream<List<OrderModel>> watchOrders(String userId) => _orders(
    userId,
  ).orderBy('createdAt', descending: true).snapshots().map((snapshot) {
    return snapshot.docs
        .map((document) => OrderModel.fromMap(document.id, document.data()))
        .toList();
  });

  @override
  Stream<OrderModel?> watchOrder(String userId, String orderId) => _orders(
    userId,
  ).doc(orderId).snapshots().map(
    (document) => document.exists
        ? OrderModel.fromMap(document.id, document.data()!)
        : null,
  );

  @override
  Future<void> placeOrder(String userId, List<CartItem> cartItems) async {
    if (cartItems.isEmpty) {
      throw StateError('Cannot place an order with an empty cart.');
    }

    final cartRefs = cartItems
        .map(
          (item) => _cart(
            userId,
          ).doc(cartDocumentId(item.product.id, item.size)),
        )
        .toList();
    final orderRefs = List.generate(
      cartItems.length,
      (_) => _orders(userId).doc(),
    );

    await _firestore.runTransaction((transaction) async {
      final snapshots = <DocumentSnapshot<Map<String, dynamic>>>[];
      for (final cartRef in cartRefs) {
        snapshots.add(await transaction.get(cartRef));
      }
      if (snapshots.any((snapshot) => !snapshot.exists)) {
        throw StateError('The cart changed. Review it before placing the order.');
      }

      for (var index = 0; index < snapshots.length; index++) {
        final item = CartItem.fromMap(snapshots[index].data()!);
        transaction.set(orderRefs[index], {
          'productId': item.product.id,
          'product': item.product.toMap(),
          'size': item.size,
          'quantity': item.quantity,
          'status': 'Packing',
          'createdAt': FieldValue.serverTimestamp(),
        });
        transaction.delete(cartRefs[index]);
      }
    });
  }

  @override
  Future<void> submitReview(
    String userId,
    String orderId,
    double score,
  ) {
    return _orders(userId).doc(orderId).update({'reviewScore': score});
  }
}
