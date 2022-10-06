import 'package:flutter_test/flutter_test.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';

void main() {
  test('unmodifiable', () {
    expect(
      () => const [0, 1, 2, 3].unmodifiable.removeLast(),
      throwsUnsupportedError,
    );
  });

  group('separate', () {
    test('adds separator between items', () {
      expect(const [0, 0].separate(1), const [0, 1, 0]);
    });

    test('adds nothing if the list is empty', () {
      expect(const <int>[].separate(1), const <int>[]);
    });

    test('adds nothing if the list has only one element', () {
      expect(const [0].separate(1), const [0]);
    });
  });

  group('append', () {
    test('appends appender to each element', () {
      expect(const [0, 0].append(1), const [0, 1, 0, 1]);
    });

    test('appends appender even to an empty list', () {
      expect(const <int>[].append(1), const [1]);
    });
  });

  group('mapIndexed', () {
    // TODO(albert): finish this
  });

  group('groupBy', () {
    // TODO(albert): finish this
  });
}
