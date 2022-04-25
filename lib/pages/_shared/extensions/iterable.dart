extension IterableEx<T> on Iterable<T> {
  List<T> get toUnmodifiableList => List.unmodifiable(this);
}
