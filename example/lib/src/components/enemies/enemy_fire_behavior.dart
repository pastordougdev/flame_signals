import 'dart:math';

import 'package:flame_behaviors/flame_behaviors.dart';

import '../../imports.dart';

class EnemyFireBehavior extends Behavior<EnemyEntity> {
  static const maxInterval = 5.0;
  static const minInterval = 2.25;
  static final random = Random();

  double _elapsed = 0.0;
  double _interval = 0.0;

  @override
  Future<void> onLoad() async {
    _interval =
        (random.nextDouble() * (maxInterval - minInterval)) + minInterval;
  }

  @override
  void update(double dt) {
    _elapsed += dt;
    if (_elapsed >= _interval) {
      parent.fireLaser();
      _interval =
          (random.nextDouble() * (maxInterval - minInterval)) + minInterval;
      _elapsed = 0.0;
    }
  }
}
