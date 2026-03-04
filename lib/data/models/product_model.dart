import '../../domain/entities/product.dart';

/// Data model for Product with JSON serialization/deserialization.
/// Extends the domain [Product] entity with data layer capabilities.
class ProductModel extends Product {
  /// Creates a ProductModel with the given properties.
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
  });

  /// Creates a [ProductModel] from a JSON map.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
    );
  }

  /// Converts this [ProductModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'price': price, 'image': image};
  }

  /// Creates a [ProductModel] from a domain [Product] entity.
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      price: product.price,
      image: product.image,
    );
  }

  /// Converts this model to a domain [Product] entity.
  Product toEntity() {
    return Product(id: id, title: title, price: price, image: image);
  }
}
