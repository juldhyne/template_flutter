class RestApiResponse {
  final dynamic data;
  final bool isSuccess;
  final String? message;

  const RestApiResponse(
    this.data, {
    this.message,
    this.isSuccess = true,
  });
}
