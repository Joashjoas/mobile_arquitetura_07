import '../models/product_model.dart';

/// In-memory cache data source for products.
/// Provides simple caching functionality to reduce network calls.
class ProductCacheDatasource {
  /// Internal storage for cached products.
  List<ProductModel>? _cachedProducts;

  /// Saves the list of products to the cache.
  void save(List<ProductModel> products) {
    _cachedProducts = products;
  }

  /// Retrieves the cached products.
  /// Returns null if no products are cached.
  List<ProductModel>? get() {
    return _cachedProducts;
  }

  /// Clears the cache.
  void clear() {
    _cachedProducts = null;
  }
}
