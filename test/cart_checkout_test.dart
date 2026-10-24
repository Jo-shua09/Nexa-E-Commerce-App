import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexa/features/cart/data/repositories/cart_repository.dart';
import 'package:nexa/features/cart/presentation/cart_screen.dart';
import 'package:nexa/features/cart/presentation/checkout_screen.dart';
import 'package:nexa/features/cart/presentation/providers/cart_provider.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';
import 'package:nexa/features/products/domain/models/products.dart';

void main() {
  testWidgets('cart quantity controls update the streamed cart', (
    tester,
  ) async {
    final repository = _FakeCartRepository([
      CartItem(product: dummyProducts.first, size: 'S', quantity: 2),
    ]);
    addTearDown(repository.dispose);

    await tester.pumpWidget(
      _testScope(repository, const MaterialApp(home: CartScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.byTooltip('Increase quantity').first);
    await tester.pumpAndSettle();

    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('checkout keeps place order visible and hides card for cash', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repository = _FakeCartRepository([
      CartItem(product: dummyProducts.first, size: 'S'),
    ]);
    addTearDown(repository.dispose);

    await tester.pumpWidget(
      _testScope(repository, const MaterialApp(home: CheckoutScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Place Order'), findsOneWidget);
    expect(find.text('VISA'), findsOneWidget);

    await tester.tap(find.text('Cash'));
    await tester.pump();

    expect(find.text('VISA'), findsNothing);
    expect(find.text('Place Order'), findsOneWidget);
  });
}

Widget _testScope(_FakeCartRepository repository, Widget child) {
  return ProviderScope(
    overrides: [
      currentUserIdProvider.overrideWith((ref) => 'test-user'),
      cartRepositoryProvider.overrideWith((ref) => repository),
    ],
    child: child,
  );
}

class _FakeCartRepository implements CartRepository {
  _FakeCartRepository(this._items);

  final StreamController<List<CartItem>> _changes =
      StreamController<List<CartItem>>.broadcast();
  List<CartItem> _items;

  void dispose() => _changes.close();

  @override
  Stream<List<CartItem>> watchCart(String userId) async* {
    yield List.unmodifiable(_items);
    yield* _changes.stream;
  }

  @override
  Future<void> addItem(String userId, Product product, String size) async {
    final index = _items.indexWhere(
      (item) => item.product.id == product.id && item.size == size,
    );
    if (index == -1) {
      _items = [..._items, CartItem(product: product, size: size)];
    } else {
      final item = _items[index];
      _items = [
        for (var i = 0; i < _items.length; i++)
          if (i == index)
            CartItem(
              product: item.product,
              size: item.size,
              quantity: item.quantity + 1,
            )
          else
            _items[i],
      ];
    }
    _emit();
  }

  @override
  Future<void> removeItem(String userId, CartItem item) async {
    _items = _items
        .where(
          (candidate) =>
              candidate.product.id != item.product.id ||
              candidate.size != item.size,
        )
        .toList();
    _emit();
  }

  @override
  Future<void> setQuantity(String userId, CartItem item, int quantity) async {
    if (quantity < 1) {
      await removeItem(userId, item);
      return;
    }
    _items = [
      for (final candidate in _items)
        if (candidate.product.id == item.product.id &&
            candidate.size == item.size)
          CartItem(
            product: candidate.product,
            size: candidate.size,
            quantity: quantity,
          )
        else
          candidate,
    ];
    _emit();
  }

  void _emit() => _changes.add(List.unmodifiable(_items));
}
