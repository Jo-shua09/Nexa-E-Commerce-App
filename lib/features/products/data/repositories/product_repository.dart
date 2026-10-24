import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexa/features/products/domain/models/products.dart';

abstract class ProductRepository {
  Stream<List<Product>> watchProducts();
  Stream<Product?> watchProductById(String id);
}

class FirestoreProductRepository implements ProductRepository {
  FirestoreProductRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection('products');

  @override
  Stream<List<Product>> watchProducts() {
    return _products.snapshots().map((snapshot) {
      final products = snapshot.docs
          .map((document) => _productFromDocument(document))
          .toList();
      products.sort((a, b) {
        final order = _sortOrder(a.id).compareTo(_sortOrder(b.id));
        if (order != 0) return order;
        return (int.tryParse(a.id) ?? 0).compareTo(int.tryParse(b.id) ?? 0);
      });
      return products;
    });
  }

  @override
  Stream<Product?> watchProductById(String id) => _products
      .doc(id)
      .snapshots()
      .map(
        (document) => document.exists ? _productFromDocument(document) : null,
      );

  Product _productFromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data == null) {
      throw FormatException('Product "${document.id}" has no data.');
    }
    return Product.fromMap(document.id, data);
  }

  int _sortOrder(String id) {
    final numericId = int.tryParse(id);
    return numericId == null ? 1 << 31 : numericId % 5;
  }
}
