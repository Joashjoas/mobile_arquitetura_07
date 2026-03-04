/// Exception class that represents failures in the application.
/// Used to wrap errors from data layer and propagate them to presentation.
class Failure implements Exception {
  /// The error message describing what went wrong.
  final String message;

  /// Creates a Failure with the given message.
  const Failure(this.message);

  @override
  String toString() => 'Failure: $message';
}
