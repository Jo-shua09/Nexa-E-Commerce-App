import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexa/features/products/data/repositories/product_repository.dart';
import 'package:nexa/features/products/domain/models/products.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return FirestoreProductRepository(FirebaseFirestore.instance);
});

final productsStreamProvider = StreamProvider<List<Product>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return repository.watchProducts();
});

final productsByIdStreamProvider = StreamProvider.family<Product?, String>((
  ref,
  id,
) {
  final repository = ref.watch(productRepositoryProvider);
  return repository.watchProductById(id);
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'All');
