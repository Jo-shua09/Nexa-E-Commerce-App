import 'package:flutter_riverpod/legacy.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';
import 'package:nexa/features/products/domain/models/products.dart';

class CompletedOrderModel {
  final String id;
  final Product product;
  final String size;
  final double?
  reviewScore; // Null means "Leave Review", otherwise shows "4.5/5"

  const CompletedOrderModel({
    required this.id,
    required this.product,
    required this.size,
    this.reviewScore,
  });

  CompletedOrderModel copyWith({double? reviewScore}) {
    return CompletedOrderModel(
      id: id,
      product: product,
      size: size,
      reviewScore: reviewScore ?? this.reviewScore,
    );
  }
}

class CompletedOrdersNotifier extends StateNotifier<List<CompletedOrderModel>> {
  CompletedOrdersNotifier()
    : super([
        CompletedOrderModel(
          id: 'COMP-001',
          product: dummyProducts[0],
          size: 'M',
        ),
        CompletedOrderModel(
          id: 'COMP-002',
          product: dummyProducts[1],
          size: 'L',
          reviewScore: 4.5,
        ),
        CompletedOrderModel(
          id: 'COMP-003',
          product: dummyProducts[2],
          size: 'L',
        ),
        CompletedOrderModel(
          id: 'COMP-004',
          product: dummyProducts[3],
          size: 'S',
        ),
        CompletedOrderModel(
          id: 'COMP-005',
          product: dummyProducts[4],
          size: 'M',
          reviewScore: 3.5,
        ),
      ]);

  void submitReview(String orderId, double score) {
    state = [
      for (final order in state)
        if (order.id == orderId) order.copyWith(reviewScore: score) else order,
    ];
  }
}

final completedOrdersProvider =
    StateNotifierProvider<CompletedOrdersNotifier, List<CompletedOrderModel>>((
      ref,
    ) {
      return CompletedOrdersNotifier();
    });
