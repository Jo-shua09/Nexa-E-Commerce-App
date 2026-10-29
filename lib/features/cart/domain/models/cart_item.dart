class CartItem {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String image;
  final String size;
  final int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.size,
    required this.quantity,
  });

  factory CartItem.fromMap(String id, Map<String, dynamic> map) {
    return CartItem(
      id: id,
      productId: map['productId'] ?? '',
      title: map['title'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      image: map['image'] ?? '',
      size: map['size'] ?? '',
      quantity: map['quantity']?.toInt() ?? 1,
    );
  }
}
