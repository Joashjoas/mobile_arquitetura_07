import '../entities/product.dart';

/// Abstract repository interface for product data operations.
/// Defines the contract for fetching products from data sources.
abstract class ProductRepository {
  /// Fetches the list of all products.
  /// Returns a list of [Product] entities.
  /// Throws [Failure] if the operation fails.
  Future<List<Product>> getProducts();
}
