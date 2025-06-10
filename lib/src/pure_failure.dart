final class PureFailure implements Exception {
  const PureFailure(
    this.message,
  );

  final String message;

  @override
  String toString() => message;
}
