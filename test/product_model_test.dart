import 'package:flutter_test/flutter_test.dart';
import 'package:nexa/features/products/domain/models/products.dart';

void main() {
  test('Product maps Firestore fields and uses the document ID', () {
    final product = Product.fromMap('sku-1', {
      'title': 'Tee',
      'category': 'Tops',
      'price': 48,
      'rating': 4.8,
      'reviewsCount': 12,
      'description': 'Cotton tee',
      'images': ['https://example.com/tee.png'],
    });

    expect(product.id, 'sku-1');
    expect(product.price, 48.0);
    expect(product.rating, 4.8);
    expect(product.reviewsCount, 12);
    expect(product.images, ['https://example.com/tee.png']);
    expect(product.isFavorite, isFalse);
    expect(product.toMap()['title'], 'Tee');
  });

  test('Product rejects documents with invalid fields', () {
    expect(
      () => Product.fromMap('invalid', {
        'title': 'Tee',
        'category': 'Tops',
        'price': '48',
        'rating': 4.8,
        'reviewsCount': 12,
        'description': 'Cotton tee',
        'images': [],
      }),
      throwsFormatException,
    );
  });
}
