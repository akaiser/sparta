List<T> safeMap<T>(
  Iterable<dynamic>? items,
  T Function(Map<String, dynamic>) itemMapper,
) {
  return (items ?? <T>[])
      .map<T>((item) => itemMapper(item as Map<String, dynamic>))
      .where((item) => item != null)
      .toList(growable: false);
}
