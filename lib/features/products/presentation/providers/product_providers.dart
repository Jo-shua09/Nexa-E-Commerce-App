import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/features/products/data/repositories/product_repository.dart';
import 'package:nexa/features/products/domain/models/products.dart';

//!! Provides the repository instance
final ProductRepositoryProvider = Provider<ProductRepository>((ref) {
  return MockProductRepository();
});

//!! Provides the asynchronous list of products for UI consumers
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(ProductRepositoryProvider);
  return repository.getProducts();
});

//!! Provides a single product by ID (family provider)
final productsByIdProvider = FutureProvider.family<Product?, String>((
  ref,
  id,
) async {
  final repository = ref.watch(ProductRepositoryProvider);
  return repository.getProductsById(id);
});
