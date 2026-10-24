import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/features/orders/domain/models/order_model.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';

void main() {
  test('order maps preserve cart quantity', () {
    final product = dummyProducts.first;

    final order = OrderModel.fromMap('order-1', {
      'productId': product.id,
      'product': product.toMap(),
      'size': 'M',
      'quantity': 3,
      'status': 'Packing',
    });

    expect(order.quantity, 3);
    expect(order.product.id, product.id);
  });

  test('order map rejects invalid quantity', () {
    final product = dummyProducts.first;

    expect(
      () => OrderModel.fromMap('order-1', {
        'productId': product.id,
        'product': product.toMap(),
        'size': 'M',
        'quantity': 0,
        'status': 'Packing',
      }),
      throwsFormatException,
    );
  });
}
