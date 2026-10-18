import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/features/cart/presentation/cart_screen.dart';
import 'package:nexa/features/cart/presentation/checkout_screen.dart';
import 'package:nexa/features/cart/presentation/providers/cart_provider.dart';

void main() {
  testWidgets('cart quantity controls update without recursive rendering', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: CartScreen())),
    );

    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.byTooltip('Increase quantity').first);
    await tester.pump();

    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('checkout keeps place order visible and hides card for cash', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: CheckoutScreen())),
    );

    expect(find.text('Place Order'), findsOneWidget);
    expect(find.text('VISA'), findsOneWidget);

    await tester.tap(find.text('Cash'));
    await tester.pump();

    expect(find.text('VISA'), findsNothing);
    expect(find.text('Place Order'), findsOneWidget);
  });
}
