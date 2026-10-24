import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:nexa/features/products/presentation/providers/product_providers.dart';
import 'package:nexa/features/products/domain/models/products.dart';

// 1. Current Search Query
final searchQueryProvider = StateProvider<String>((ref) => '');

// 2. Recent Searches State Notifier
class RecentSearchesNotifier extends StateNotifier<List<String>> {
  RecentSearchesNotifier()
    : super([
        'Jeans',
        'Casual clothes',
        'Hoodie',
        'Nike shoes black',
        'V-neck tshirt',
        'Winter clothes',
      ]);

  void addSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    final normalized = trimmed.toLowerCase();
    state = [
      trimmed,
      ...state.where((item) => item.toLowerCase() != normalized),
    ];
  }

  void removeSearch(String query) {
    final normalized = query.trim().toLowerCase();
    state = state.where((item) => item.toLowerCase() != normalized).toList();
  }

  void clearAll() {
    state = [];
  }
}

final recentSearchesProvider =
    StateNotifierProvider<RecentSearchesNotifier, List<String>>((ref) {
      return RecentSearchesNotifier();
    });

// 3. Search Results Filtered Provider
final searchResultsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  if (query.isEmpty) return const AsyncData<List<Product>>([]);

  return ref
      .watch(productsStreamProvider)
      .whenData(
        (products) => products.where((product) {
          final title = product.title.toLowerCase();
          final category = product.category.toLowerCase();
          return title.contains(query) || category.contains(query);
        }).toList(),
      );
});
