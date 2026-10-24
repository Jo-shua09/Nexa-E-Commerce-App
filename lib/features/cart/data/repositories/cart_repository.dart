import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexa/features/products/domain/models/products.dart';

class CartItem {
  final Product product;
  final String size;
  final int quantity;

  const CartItem({
    required this.product,
    required this.size,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;

  factory CartItem.fromMap(Map<String, dynamic> data) {
    final productId = data['productId'];
    final productData = data['product'];
    final size = data['size'];
    final quantity = data['quantity'];

    if (productId is! String ||
        productData is! Map<String, dynamic> ||
        size is! String ||
        quantity is! int ||
        quantity < 1) {
      throw const FormatException('Cart item has invalid or missing fields.');
    }

    return CartItem(
      product: Product.fromMap(productId, productData),
      size: size,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toMap() => {
    'productId': product.id,
    'product': product.toMap(),
    'size': size,
    'quantity': quantity,
  };
}

abstract class CartRepository {
  Stream<List<CartItem>> watchCart(String userId);
  Future<void> addItem(String userId, Product product, String size);
  Future<void> setQuantity(
    String userId,
    CartItem item,
    int quantity,
  );
  Future<void> removeItem(String userId, CartItem item);
}

class FirestoreCartRepository implements CartRepository {
  FirestoreCartRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _items(String userId) =>
      _firestore.collection('users').doc(userId).collection('cart');

  @override
  Stream<List<CartItem>> watchCart(String userId) => _items(
    userId,
  ).snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList();
  });

  @override
  Future<void> addItem(String userId, Product product, String size) async {
    final itemRef = _items(userId).doc(cartDocumentId(product.id, size));
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(itemRef);
      final quantity = snapshot.exists
          ? CartItem.fromMap(snapshot.data()!).quantity + 1
          : 1;
      transaction.set(
        itemRef,
        CartItem(product: product, size: size, quantity: quantity).toMap(),
      );
    });
  }

  @override
  Future<void> setQuantity(
    String userId,
    CartItem item,
    int quantity,
  ) async {
    final itemRef = _items(
      userId,
    ).doc(cartDocumentId(item.product.id, item.size));
    if (quantity < 1) {
      await itemRef.delete();
    } else {
      await itemRef.update({'quantity': quantity});
    }
  }

  @override
  Future<void> removeItem(String userId, CartItem item) => _items(
    userId,
  ).doc(cartDocumentId(item.product.id, item.size)).delete();
}

String cartDocumentId(String productId, String size) =>
    base64Url.encode(utf8.encode('$productId::$size')).replaceAll('=', '');
