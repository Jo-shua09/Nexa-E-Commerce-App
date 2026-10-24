import 'package:nexa/features/products/domain/models/products.dart';

class OrderModel {
  final String id;
  final Product product;
  final String size;
  final int quantity;
  final String status;
  final double? reviewScore;

  const OrderModel({
    required this.id,
    required this.product,
    required this.size,
    required this.quantity,
    required this.status,
    this.reviewScore,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> data) {
    final productId = data['productId'];
    final productData = data['product'];
    final size = data['size'];
    final quantity = data['quantity'];
    final status = data['status'];
    final reviewScore = data['reviewScore'];

    if (productId is! String ||
        productData is! Map<String, dynamic> ||
        size is! String ||
        quantity is! int ||
        quantity < 1 ||
        status is! String ||
        (reviewScore != null && reviewScore is! num)) {
      throw FormatException('Order "$id" has invalid or missing fields.');
    }

    return OrderModel(
      id: id,
      product: Product.fromMap(productId, productData),
      size: size,
      quantity: quantity,
      status: status,
      reviewScore: (reviewScore as num?)?.toDouble(),
    );
  }
}
