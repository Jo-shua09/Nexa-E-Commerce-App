import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/features/products/domain/models/products.dart';

class SavedNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return const [];
  }

  void add(Product product) {
    if (isSaved(product.id)) return;

    state = [...state, product];
  }

  void remove(String productId) {
    state = state.where((item) => item.id != productId).toList();
  }

  void toggleSave(Product product) {
    if (isSaved(product.id)) {
      remove(product.id);
    } else {
      add(product);
    }
  }

  bool isSaved(String productId) {
    return state.any((item) => item.id == productId);
  }
}

final savedProductsProvider = NotifierProvider<SavedNotifier, List<Product>>(
  SavedNotifier.new,
);
