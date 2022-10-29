import 'dart:math';

extension RandomMapEntry<K, V> on Map<K, V> {
  K randomKey([Random? random]) {
    final idx = random?.nextInt(keys.length) ?? Random().nextInt(keys.length);
    return keys.elementAt(idx);
  }

  V randomValue([Random? random]) {
    final idx =
        random?.nextInt(values.length) ?? Random().nextInt(values.length);
    return values.elementAt(idx);
  }

  MapEntry<K, V> randomMapEntry([Random? random]) {
    final idx =
        random?.nextInt(entries.length) ?? Random().nextInt(entries.length);
    return entries.elementAt(idx);
  }
}
