import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:nexa/features/products/data/repositories/product_repository.dart';
import 'package:nexa/features/products/domain/models/products.dart';

//!! Provides the repository instance
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return MockProductRepository();
});

//!! Provides the asynchronous list of products for UI consumers
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});

//!! Provides a single product by ID (family provider)
final productsByIdProvider = FutureProvider.family<Product?, String>((
  ref,
  id,
) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductsById(id);
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

final dummyProductsProvider = Provider<List<Product>>((ref) => <Product>[]);

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final allProducts = ref.watch(dummyProductsProvider);

  if (selectedCategory == 'All') {
    return allProducts;
  }

  return allProducts
      .where((p) => p.category.toLowerCase() == selectedCategory.toLowerCase())
      .toList();
});
