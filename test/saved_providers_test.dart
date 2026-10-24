import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';
import 'package:nexa/features/products/domain/models/products.dart';
import 'package:nexa/features/saved/data/repositories/wishlist_repository.dart';
import 'package:nexa/features/saved/presentation/providers/saved_providers.dart';

void main() {
  test('saved products stream is scoped to the authenticated user', () async {
    final repository = _FakeWishlistRepository([dummyProducts.first]);
    final container = ProviderContainer(
      overrides: [
        currentUserIdProvider.overrideWith((ref) => 'user-123'),
        wishlistRepositoryProvider.overrideWith((ref) => repository),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(savedProductsProvider, (_, _) {});
    addTearDown(subscription.close);

    await Future<void>.delayed(Duration.zero);

    expect(repository.requestedUserId, 'user-123');
    expect(container.read(savedProductsProvider).value, [dummyProducts.first]);
  });

  test('saved products are empty when no user is signed in', () async {
    final container = ProviderContainer(
      overrides: [currentUserIdProvider.overrideWith((ref) => null)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(savedProductsProvider, (_, _) {});
    addTearDown(subscription.close);

    await Future<void>.delayed(Duration.zero);

    expect(container.read(savedProductsProvider).value, isEmpty);
  });
}

class _FakeWishlistRepository implements WishlistRepository {
  _FakeWishlistRepository(this.products);

  final List<Product> products;
  String? requestedUserId;

  @override
  Stream<List<Product>> watchSavedProducts(String userId) {
    requestedUserId = userId;
    return Stream.value(products);
  }

  @override
  Future<void> removeProduct(String userId, String productId) async {}

  @override
  Future<void> toggleProduct(String userId, Product product) async {}
}
