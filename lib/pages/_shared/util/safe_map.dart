List<T> safeMap<T>(
  Iterable<dynamic>? items,
  T Function(Map<String, dynamic>) itemMapper, {
  bool Function(Map<String, dynamic>)? itemFilter,
}) {
  return (items ?? <T>[])
      .where((item) => itemFilter == null || itemFilter(item))
      .map<T>((item) => itemMapper(item))
      .where((item) => item != null)
      .toList(growable: false);
}
