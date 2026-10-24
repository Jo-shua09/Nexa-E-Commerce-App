import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexa/features/products/domain/models/products.dart';
import 'package:nexa/features/saved/data/repositories/wishlist_repository.dart';

final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) {
  return FirestoreWishlistRepository(FirebaseFirestore.instance);
});

final savedProductsProvider = StreamProvider<List<Product>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(const []);
  return ref.watch(wishlistRepositoryProvider).watchSavedProducts(userId);
});

Future<void> runWishlistAction(
  BuildContext context,
  WidgetRef ref,
  Future<void> Function(WishlistRepository repository, String userId) action,
) async {
  final userId = ref.read(currentUserIdProvider);
  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign in to update your saved items.')),
    );
    return;
  }

  try {
    await action(ref.read(wishlistRepositoryProvider), userId);
  } on FirebaseException catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Unable to update saved items.'),
        ),
      );
    }
  }
}
