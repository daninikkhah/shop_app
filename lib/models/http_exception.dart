class HttpException implements Exception {
  HttpException(this.error);
  final String error;
  @override
  String toString() {
    return error;
  }
}
