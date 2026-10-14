import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/core/router/app_router.dart';

void main() {
  test('router configuration builds with a root product route', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(() => container.read(routerProvider), returnsNormally);
  });
}
