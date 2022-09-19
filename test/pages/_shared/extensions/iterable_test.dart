import 'package:flutter_test/flutter_test.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';

void main() {
  test('unmodifiable', () {
    expect(
      () => [0, 1, 2, 3].unmodifiable.removeLast(),
      throwsUnsupportedError,
    );
  });

  test('separate', () {
    expect([0, 0].separate(1), [0, 1, 0]);
  });

  test('append', () {
    expect([0, 0].append(1), [0, 1, 0, 1]);
  });
}
