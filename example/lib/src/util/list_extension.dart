import 'dart:math';

extension ListRandom<E> on List<E> {
  E? random([Random? random]) {
    if (isEmpty) return null;
    final idx = random?.nextInt(length) ?? Random().nextInt(length);
    return this[idx];
  }

  bool containsIndexes(Iterable<int> indexes) {
    var doesContain = true;
    for (final idx in indexes) {
      doesContain = doesContain && idx >= 0 && idx < length;
    }
    return doesContain;
  }

  void cycle() {
    if (length < 2) return;
    final firstItem = removeAt(0);
    add(firstItem);
  }
}
