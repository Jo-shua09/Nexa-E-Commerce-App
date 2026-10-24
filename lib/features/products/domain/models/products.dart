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

  factory Product.fromMap(String id, Map<String, dynamic> data) {
    final price = data['price'];
    final rating = data['rating'];
    final reviewsCount = data['reviewsCount'];
    final images = data['images'];

    if (data['title'] is! String ||
        data['category'] is! String ||
        price is! num ||
        rating is! num ||
        reviewsCount is! int ||
        data['description'] is! String ||
        images is! List ||
        images.any((image) => image is! String) ||
        (data['isFavorite'] != null && data['isFavorite'] is! bool)) {
      throw FormatException('Product "$id" has invalid or missing fields.');
    }

    return Product(
      id: id,
      title: data['title'] as String,
      category: data['category'] as String,
      price: price.toDouble(),
      rating: rating.toDouble(),
      reviewsCount: reviewsCount.toInt(),
      description: data['description'] as String,
      images: List<String>.unmodifiable(images.cast<String>()),
      isFavorite: data['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'category': category,
    'price': price,
    'rating': rating,
    'reviewsCount': reviewsCount,
    'description': description,
    'images': images,
  };
}
