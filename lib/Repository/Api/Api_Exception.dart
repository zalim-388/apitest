class ApiException {
  final statusCode;
  final message;

  ApiException(this.message, this.statusCode);

  @override
  String toString() {
    return message;
  }
}
