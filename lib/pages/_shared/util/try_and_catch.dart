import 'dart:developer' show log;

Future<T> tryAndCatch<T>(
  Future<T> Function() body,
  T Function(Exception) onError,
) async {
  try {
    return await body();
  } catch (error) {
    log('Error on tryAndCatch...', error: error);
    return onError(Exception(error.toString()));
  }
}
