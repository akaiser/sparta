extension IterableEx<T> on Iterable<T> {
  List<T> get unmodifiable => List.unmodifiable(this);

  Iterable<T> separate(T by) => length < 2 ? this : _exp(by).take(length + 1);

  Iterable<T> append(T by) => isEmpty ? [by] : _exp(by);

  Iterable<T> _exp(T by) => expand((it) => [it, by]);

  Iterable<R> mapIndexed<R>(R Function(int index, T element) mapper) sync* {
    var i = 0;
    for (final value in this) {
      yield mapper(i++, value);
    }
  }

  Map<G, Iterable<T>> groupBy<G>(G Function(T) key) {
    final map = <G, List<T>>{};
    for (final it in this) {
      (map[key(it)] ??= []).add(it);
    }
    return map;
  }
}
