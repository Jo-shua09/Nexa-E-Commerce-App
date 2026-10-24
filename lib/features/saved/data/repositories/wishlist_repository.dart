import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexa/features/products/domain/models/products.dart';

abstract class WishlistRepository {
  Stream<List<Product>> watchSavedProducts(String userId);
  Future<void> toggleProduct(String userId, Product product);
  Future<void> removeProduct(String userId, String productId);
}

class FirestoreWishlistRepository implements WishlistRepository {
  FirestoreWishlistRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _products(String userId) =>
      _firestore.collection('users').doc(userId).collection('wishlist');

  @override
  Stream<List<Product>> watchSavedProducts(String userId) => _products(
    userId,
  ).snapshots().map((snapshot) {
    return snapshot.docs
        .map((document) => Product.fromMap(document.id, document.data()))
        .toList();
  });

  @override
  Future<void> toggleProduct(String userId, Product product) async {
    final productRef = _products(userId).doc(product.id);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(productRef);
      if (snapshot.exists) {
        transaction.delete(productRef);
      } else {
        transaction.set(productRef, product.toMap());
      }
    });
  }

  @override
  Future<void> removeProduct(String userId, String productId) =>
      _products(userId).doc(productId).delete();
}
