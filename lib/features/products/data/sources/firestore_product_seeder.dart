import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';

Future<bool> seedProductsToFirestore({FirebaseFirestore? firestore}) async {
  final collection = (firestore ?? FirebaseFirestore.instance).collection(
    'products',
  );
  final existingProducts = await collection.limit(1).get();
  if (existingProducts.docs.isNotEmpty) return false;

  final batch = collection.firestore.batch();
  for (final product in dummyProducts) {
    batch.set(collection.doc(product.id), product.toMap());
  }
  await batch.commit();
  return true;
}
