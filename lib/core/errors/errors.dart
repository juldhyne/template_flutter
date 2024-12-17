abstract class AppError implements Exception {
  final String message;

  const AppError([String? message]) : message = message ?? "An error happened. Contact support.";

  @override
  String toString() => message;
}

// ServerError are generated when the response from a server call has success set to false
class ServerError extends AppError {
  const ServerError(super.message);
}
