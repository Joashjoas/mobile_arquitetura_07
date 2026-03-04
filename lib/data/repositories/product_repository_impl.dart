import '../../core/errors/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../datasources/product_cache_datasource.dart';

/// Implementation of [ProductRepository] that coordinates between
/// remote and cache data sources with fallback logic.
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource _remoteDatasource;
  final ProductCacheDatasource _cacheDatasource;

  /// Creates a ProductRepositoryImpl with the given datasources.
  ProductRepositoryImpl({
    required ProductRemoteDatasource remoteDatasource,
    required ProductCacheDatasource cacheDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _cacheDatasource = cacheDatasource;

  /// Fetches products from remote source, with cache fallback.
  /// If remote fails and cache exists, returns cached data.
  /// Throws [Failure] if both remote fails and cache is empty.
  @override
  Future<List<Product>> getProducts() async {
    try {
      // Try to fetch from remote
      final products = await _remoteDatasource.getProducts();

      // Save to cache for future use
      _cacheDatasource.save(products);

      return products.map((model) => model.toEntity()).toList();
    } on Failure {
      // If remote fails, try to get from cache
      final cachedProducts = _cacheDatasource.get();

      if (cachedProducts != null && cachedProducts.isNotEmpty) {
        // Return cached data if available
        return cachedProducts.map((model) => model.toEntity()).toList();
      }

      // Re-throw the original failure if no cache available
      rethrow;
    } catch (e) {
      // Try cache on any other exception
      final cachedProducts = _cacheDatasource.get();

      if (cachedProducts != null && cachedProducts.isNotEmpty) {
        return cachedProducts.map((model) => model.toEntity()).toList();
      }

      // Convert to Failure if not already
      throw Failure('Failed to load products: ${e.toString()}');
    }
  }
}
