import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa/features/orders/domain/models/order_model.dart';
import 'package:nexa/features/orders/presentation/providers/order_provider.dart';

typedef CompletedOrderModel = OrderModel;

final completedOrdersProvider = Provider<AsyncValue<List<CompletedOrderModel>>>(
  (ref) {
    return ref
        .watch(userOrdersProvider)
        .whenData(
          (orders) =>
              orders.where((order) => order.status == 'Delivered').toList(),
        );
  },
);
