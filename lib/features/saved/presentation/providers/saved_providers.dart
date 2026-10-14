import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';
import 'package:nexa/features/products/domain/models/products.dart';

class SavedNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return dummyProducts.take(6).toList();
  }

  void toggleSave(Product product) {
    final current = state;

    if (current.any((item) => item.id == product.id)) {
      state = current.where((item) => item.id != product.id).toList();
    } else {
      state = [...current, product];
    }
  }

  bool isSaved(String productId) {
    return state.any((item) => item.id == productId);
  }
}

final savedProductsProvider = NotifierProvider<SavedNotifier, List<Product>>(
  SavedNotifier.new,
);
