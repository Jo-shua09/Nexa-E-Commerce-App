import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/app.dart';
import 'package:nexa/core/router/app_router.dart';

void main() {
  test('router instance remains stable when authentication changes', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final router = container.read(routerProvider);
    container.read(authStateProvider.notifier).state = true;

    expect(container.read(routerProvider), same(router));
  });

  testWidgets('splash navigates to sign-in', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: NexaApp()));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.text('Sign in to your account'), findsOneWidget);
  });
}
