import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/features/cart/presentation/providers/cart_provider.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';

void main() {
  test('badge counts distinct products while subtotal includes quantities', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final firstProduct = dummyProducts[0];
    final secondProduct = dummyProducts[1];
    final cart = container.read(cartProvider.notifier);

    cart.addToCart(firstProduct, 'S', quantity: 3);
    cart.addToCart(secondProduct, 'M');

    expect(container.read(cartItemCountProvider), 2);
    expect(
      container.read(cartSubtotalProvider),
      firstProduct.price * 3 + secondProduct.price,
    );
  });
}
