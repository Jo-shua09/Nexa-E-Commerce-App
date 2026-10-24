import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/features/search/presentation/providers/search_providers.dart';

void main() {
  test('recent searches can be added, removed, and cleared', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(recentSearchesProvider.notifier);
    notifier.addSearch('  New item  ');
    notifier.addSearch('new ITEM');

    expect(container.read(recentSearchesProvider).first, 'new ITEM');
    expect(
      container
          .read(recentSearchesProvider)
          .where((search) => search.toLowerCase() == 'new item'),
      hasLength(1),
    );

    notifier.removeSearch(' NEW ITEM ');
    expect(container.read(recentSearchesProvider), isNot(contains('new ITEM')));

    notifier.clearAll();
    expect(container.read(recentSearchesProvider), isEmpty);
  });
}
