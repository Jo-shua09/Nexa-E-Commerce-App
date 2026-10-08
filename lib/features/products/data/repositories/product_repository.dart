import 'package:nexa/features/products/data/sources/dummy_products.dart';
import 'package:nexa/features/products/domain/models/products.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product?> getProductsById(String id);
}

class MockProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    //Simulate network latency so UI loading/shimmer states can be tested
    await Future.delayed(const Duration(milliseconds: 600));
    return dummyProducts;
  }

  @override
  Future<Product?> getProductsById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return dummyProducts.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }
}
