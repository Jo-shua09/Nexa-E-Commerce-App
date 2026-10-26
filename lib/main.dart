import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexa/app.dart';
import 'firebase_options.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';

// 1. SEED FUNCTION (Outside of main)
Future<void> seedProductsToFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('products');

  final snapshot = await collection.limit(1).get();
  if (snapshot.docs.isNotEmpty) {
    print("Products already seeded!");
    return;
  }

  print("Seeding products to Firestore...");
  for (final product in dummyProducts) {
    await collection.doc(product.id).set({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'category': product.category,
      'images': product.images,
      'rating': product.rating,
      'reviewsCount': product.reviewsCount,
    });
  }
  print("Successfully seeded products!");
}

// 2. MAIN FUNCTION
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: NexaApp()));
}
