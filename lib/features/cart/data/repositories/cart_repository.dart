import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/cart_item.dart';
import '../../../products/domain/models/products.dart';

class CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream the user's active cart
  Stream<List<CartItem>> watchCart(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return CartItem.fromMap(doc.id, doc.data());
          }).toList();
        });
  }

  // Add an item or increment quantity if it already exists (same product + size)
  Future<bool> addItem(String userId, Product product, String size) async {
    try {
      final cartRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('cart');

      final query = await cartRef
          .where('productId', isEqualTo: product.id)
          .where('size', isEqualTo: size)
          .get();

      if (query.docs.isNotEmpty) {
        final docId = query.docs.first.id;
        final currentQuantity = query.docs.first.data()['quantity'] ?? 1;
        await cartRef.doc(docId).update({'quantity': currentQuantity + 1});
      } else {
        await cartRef.add({
          'productId': product.id,
          'title': product.title,
          'price': product.price,
          'image': product.images.isNotEmpty ? product.images.first : '',
          'size': size,
          'quantity': 1,
          'addedAt': FieldValue.serverTimestamp(),
        });
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Update quantity (delete if 0)
  Future<void> updateQuantity(
    String userId,
    String cartItemId,
    int newQuantity,
  ) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartItemId);

    if (newQuantity <= 0) {
      await docRef.delete();
    } else {
      await docRef.update({'quantity': newQuantity});
    }
  }

  // Remove a single item
  Future<void> removeItem(String userId, String cartItemId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartItemId)
        .delete();
  }

  // Clear entire cart (used after checkout)
  Future<void> clearCart(String userId) async {
    final cartRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('cart');
    final snapshots = await cartRef.get();

    final batch = _firestore.batch();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});
