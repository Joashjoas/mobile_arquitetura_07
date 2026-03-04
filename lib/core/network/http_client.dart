import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/failure.dart';

/// HTTP client wrapper that encapsulates network calls.
/// Uses the http package for making requests.
/// Throws [Failure] on network errors.
class HttpClient {
  final http.Client _client;

  /// Creates an HttpClient with an optional http.Client.
  /// If no client is provided, a default one is created.
  HttpClient({http.Client? client}) : _client = client ?? http.Client();

  /// Performs a GET request to the given [url].
  /// Returns the response body as a dynamic (Map or List).
  /// Throws [Failure] if the request fails.
  Future<dynamic> get(String url) async {
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        throw Failure('Request failed with status: ${response.statusCode}');
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure('Network error: ${e.toString()}');
    }
  }

  /// Closes the HTTP client and releases resources.
  void dispose() {
    _client.close();
  }
}
