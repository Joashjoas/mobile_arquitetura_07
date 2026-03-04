import 'package:flutter/foundation.dart';
import '../../core/errors/failure.dart';
import '../../domain/repositories/product_repository.dart';
import 'product_state.dart';

/// ViewModel that manages product loading state and business logic.
/// Uses ValueNotifier to notify listeners of state changes.
class ProductViewModel {
  final ProductRepository _repository;

  /// StateNotifier that holds the current product state.
  final ValueNotifier<ProductState> _state = ValueNotifier(
    const ProductState(),
  );

  /// Public getter for the state to be used with ValueListenableBuilder.
  ValueNotifier<ProductState> get state => _state;

  /// Creates a ProductViewModel with the given repository.
  ProductViewModel({required ProductRepository repository})
    : _repository = repository;

  /// Loads products from the repository.
  /// Updates state to loading, then success or error accordingly.
  Future<void> loadProducts() async {
    // Set loading state
    _state.value = _state.value.copyWith(isLoading: true, error: null);

    try {
      final products = await _repository.getProducts();

      // Set success state with products
      _state.value = _state.value.copyWith(
        isLoading: false,
        products: products,
        error: null,
      );
    } on Failure catch (e) {
      // Set error state with failure message
      _state.value = _state.value.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      // Set error state with generic message
      _state.value = _state.value.copyWith(
        isLoading: false,
        error: 'Não foi possível carregar os produtos',
      );
    }
  }

  /// Disposes of the ViewModel and releases resources.
  void dispose() {
    _state.dispose();
  }
}
