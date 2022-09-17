extension IterableEx<T> on Iterable<T> {
  List<T> get unmodifiable => List.unmodifiable(this);

  Iterable<T> separate(T separator) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield separator;
        yield iterator.current;
      }
    }
  }
}
