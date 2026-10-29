import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/features/cart/domain/models/cart_item.dart';
import 'package:nexa/features/orders/domain/models/order_model.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. Place a new order
  Future<bool> placeOrder({
    required String userId,
    required List<CartItem> cartItems,
    required double totalAmount,
    required String address,
  }) async {
    try {
      final orderRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc();

      await orderRef.set({
        'id': orderRef.id,
        'totalAmount': totalAmount,
        'status': 'ongoing',
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
        'items': cartItems
            .map(
              (item) => {
                'productId': item.productId,
                'title': item.title,
                'price': item.price,
                'image': item.image,
                'size': item.size,
                'quantity': item.quantity,
              },
            )
            .toList(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // 2. Stream all orders
  Stream<List<OrderModel>> watchOrders(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return OrderModel.fromMap(doc.id, doc.data());
          }).toList();
        });
  }

  // 3. Stream a single order
  Stream<OrderModel?> watchOrder(String userId, String orderId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map((doc) {
          if (doc.exists && doc.data() != null) {
            return OrderModel.fromMap(doc.id, doc.data()!);
          }
          return null;
        });
  }

  // 4. Submit a review for a completed order
  Future<void> submitReview(
    String userId,
    String orderId,
    double rating,
  ) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .update({'rating': rating, 'isReviewed': true});
  }
}

// Provide the repository globally
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository();
});
