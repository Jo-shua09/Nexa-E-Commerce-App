import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/models/products.dart';

// Provides the full list of products
final productsStreamProvider = StreamProvider<List<Product>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return repository.watchProducts();
});

// Provides a single product by its ID
final productsByIdStreamProvider = StreamProvider.family<Product?, String>((
  ref,
  id,
) {
  final repository = ref.watch(productRepositoryProvider);
  return repository.watchProductById(id);
});
