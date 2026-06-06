class ApiError implements Exception {
  final String message;

  ApiError({
    required this.message,
  });
  @override

  String toString()
  {
    return message;
  }

}