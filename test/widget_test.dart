import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/app.dart';
import 'package:nexa/core/router/app_router.dart';
import 'package:nexa/features/auth/presentation/screens/sign_up_screen.dart';

void main() {
  test('router instance remains stable when authentication changes', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final router = container.read(routerProvider);
    container.read(authStateProvider.notifier).state = true;

    expect(container.read(routerProvider), same(router));
  });

  testWidgets('splash navigates to sign-up', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: NexaApp()));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.byType(SignUpScreen), findsOneWidget);
  });
}
