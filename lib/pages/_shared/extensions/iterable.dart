extension IterableEx<T> on Iterable<T> {
  List<T> get unmodifiable => List.unmodifiable(this);

  Iterable<T> separate(T by) => [...append(by)]..removeLast();

  Iterable<T> append(T by) => expand((it) => [it, by]);
}
