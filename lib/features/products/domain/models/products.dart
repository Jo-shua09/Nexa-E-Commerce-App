class Product {
  final String id;
  final String title;
  final String category;
  final double price;
  final double rating;
  final int reviewsCount;
  final String description;
  final List<String> images;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.images,
    this.isFavorite = false,
  });
}
