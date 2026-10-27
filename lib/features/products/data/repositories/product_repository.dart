import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/products.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Listens to all products in real-time
  Stream<List<Product>> watchProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      // The <Product> typecast fixes the List<dynamic> error
      return snapshot.docs.map<Product>((doc) {
        // Passes the ID separately to match your model's fromMap requirements
        return Product.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  // Listens to a single product in real-time
  Stream<Product?> watchProductById(String id) {
    return _firestore.collection('products').doc(id).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return Product.fromMap(doc.id, doc.data()!);
      }
      return null;
    });
  }
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});
