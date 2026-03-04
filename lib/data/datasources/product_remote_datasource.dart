import '../../core/network/http_client.dart';
import '../models/product_model.dart';

/// Remote data source for fetching products from the FakeStore API.
class ProductRemoteDatasource {
  final HttpClient _httpClient;

  /// Base URL for the FakeStore API.
  static const String _baseUrl = 'https://fakestoreapi.com';

  /// Creates a ProductRemoteDatasource with the given HttpClient.
  ProductRemoteDatasource({required HttpClient httpClient})
    : _httpClient = httpClient;

  /// Fetches all products from the remote API.
  /// Returns a list of [ProductModel].
  Future<List<ProductModel>> getProducts() async {
    final response = await _httpClient.get('$_baseUrl/products');

    if (response is List) {
      return response
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Invalid response format');
    }
  }
}
