/// Immutable entity representing a product.
/// This is the core domain object used throughout the application.
class Product {
  /// Unique identifier for the product.
  final int id;

  /// Title or name of the product.
  final String title;

  /// Price of the product.
  final double price;

  /// URL string for the product image.
  final String image;

  /// Creates an immutable Product with the given properties.
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          price == other.price &&
          image == other.image;

  @override
  int get hashCode => Object.hash(id, title, price, image);

  @override
  String toString() =>
      'Product(id: $id, title: $title, price: $price, image: $image)';
}
