import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';
import 'package:nexa/features/saved/presentation/providers/saved_providers.dart';

void main() {
  test('products can be added and removed from favorites', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final product = dummyProducts.first;
    final notifier = container.read(savedProductsProvider.notifier);

    expect(container.read(savedProductsProvider), isEmpty);

    notifier.add(product);
    expect(container.read(savedProductsProvider), [product]);

    notifier.remove(product.id);
    expect(container.read(savedProductsProvider), isEmpty);
  });

  test('adding duplicates is ignored and toggle adds then removes', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final product = dummyProducts.first;
    final notifier = container.read(savedProductsProvider.notifier);

    notifier.add(product);
    notifier.add(product);
    expect(container.read(savedProductsProvider), [product]);

    notifier.toggleSave(product);
    expect(container.read(savedProductsProvider), isEmpty);

    notifier.toggleSave(product);
    expect(container.read(savedProductsProvider), [product]);
  });
}
