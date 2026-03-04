import '../../domain/entities/product.dart';

/// State class representing the current state of product loading.
class ProductState {
  /// Whether products are currently being loaded.
  final bool isLoading;

  /// List of loaded products.
  final List<Product> products;

  /// Error message if loading failed, null otherwise.
  final String? error;

  /// Creates a ProductState with the given properties.
  /// Default values are provided for all fields.
  const ProductState({
    this.isLoading = false,
    this.products = const [],
    this.error,
  });

  /// Creates a copy of this state with the given fields replaced.
  ProductState copyWith({
    bool? isLoading,
    List<Product>? products,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      error: error,
    );
  }
}
