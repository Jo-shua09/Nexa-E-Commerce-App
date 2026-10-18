import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:nexa/features/products/domain/models/products.dart';

class CartItem {
  final Product product;
  final String size;
  final int quantity;

  const CartItem({
    required this.product,
    required this.size,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      size: size,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product, String size, {int quantity = 1}) {
    // Check if the exact product with the selected size already exists
    final existingIndex = state.indexWhere(
      (item) => item.product.id == product.id && item.size == size,
    );

    if (existingIndex != -1) {
      // If it exists, increment quantity
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            state[i].copyWith(quantity: state[i].quantity + quantity)
          else
            state[i],
      ];
    } else {
      // Otherwise, add as a new entry
      state = [
        ...state,
        CartItem(product: product, size: size, quantity: quantity),
      ];
    }
  }

  void incrementQuantity(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(quantity: state[i].quantity + 1)
        else
          state[i],
    ];
  }

  void decrementQuantity(int index) {
    if (state[index].quantity > 1) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            state[i].copyWith(quantity: state[i].quantity - 1)
          else
            state[i],
      ];
    } else {
      removeItem(index);
    }
  }

  void removeItem(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// Computed pricing providers
final cartSubtotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0.0, (sum, item) => sum + item.totalPrice);
});

const double shippingFee = 80.00;
const double vatPercentage = 0.00;

final cartTotalProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  if (subtotal == 0) return 0.0;
  return subtotal + shippingFee + (subtotal * vatPercentage);
});

// Computes total items in the cart (sum of all quantities)
final cartItemCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (total, item) => total + item.quantity);
});
