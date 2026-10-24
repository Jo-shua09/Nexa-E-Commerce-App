import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/features/cart/data/repositories/cart_repository.dart';
import 'package:nexa/features/cart/presentation/providers/cart_provider.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';

void main() {
  test(
    'badge counts distinct products while subtotal includes quantities',
    () async {
    final firstProduct = dummyProducts[0];
    final secondProduct = dummyProducts[1];
    final container = ProviderContainer(
      overrides: [
        cartProvider.overrideWith(
          (ref) => Stream.value([
            CartItem(product: firstProduct, size: 'S', quantity: 3),
            CartItem(product: secondProduct, size: 'M'),
          ]),
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(cartProvider, (_, _) {});
    addTearDown(subscription.close);

    await Future<void>.delayed(Duration.zero);

    expect(container.read(cartItemCountProvider), 2);
    expect(
      container.read(cartSubtotalProvider),
      firstProduct.price * 3 + secondProduct.price,
    );
    },
  );
}
