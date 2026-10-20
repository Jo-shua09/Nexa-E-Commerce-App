import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/features/products/data/sources/dummy_products.dart';
import 'package:nexa/features/products/domain/models/products.dart';

class OrderModel {
  final String id;
  final Product product;
  final String size;
  final String status; // 'Packing', 'Picked', 'In Transit', 'Delivered'

  const OrderModel({
    required this.id,
    required this.product,
    required this.size,
    required this.status,
  });
}

class OrdersNotifier extends Notifier<List<OrderModel>> {
  @override
  List<OrderModel> build() => [
    OrderModel(
      id: 'ORD-001',
      product: dummyProducts[0], // Regular Fit Slogan
      size: 'M',
      status: 'In Transit',
    ),
    OrderModel(
      id: 'ORD-002',
      product: dummyProducts[1], // Regular Fit Polo
      size: 'L',
      status: 'Picked',
    ),
    OrderModel(
      id: 'ORD-003',
      product: dummyProducts[2], // Regular Fit Black
      size: 'L',
      status: 'In Transit',
    ),
    OrderModel(
      id: 'ORD-004',
      product: dummyProducts[3], // Regular Fit V-Neck
      size: 'S',
      status: 'Packing',
    ),
    OrderModel(
      id: 'ORD-005',
      product: dummyProducts[4], // Regular Fit Pink
      size: 'M',
      status: 'Picked',
    ),
  ];

  void clearOrders() {
    state = [];
  }
}

final ongoingOrdersProvider =
    NotifierProvider<OrdersNotifier, List<OrderModel>>(OrdersNotifier.new);
