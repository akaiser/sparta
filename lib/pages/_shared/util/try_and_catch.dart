Future<T> tryAndCatch<T>(
  Future<T> Function() body,
  T Function(Exception) onError,
) async {
  try {
    return await body();
  } catch (error) {
    return onError(Exception(error.toString()));
  }
}
