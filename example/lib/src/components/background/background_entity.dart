import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../imports.dart';

class BackGroundEntity extends Entity with HasGameRef {
  static const starSpeeds = [40.0, 60.0, 80.0, 100.0, 120.0];
  static const starSizes = [1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0];

  @override
  Future<void> onLoad() async {
    _initStars();
  }

  void _initStars() {
    final random = Random();
    final List<double> xList = [];
    var nextX = random.nextDouble() * 4.0;
    while (nextX < gameRef.size.x) {
      xList.add(nextX);
      nextX += random.nextDouble() * 10.0;
    }
    final yList = List<double>.generate(xList.length, (idx) {
      return random.nextDouble() * gameRef.size.y;
    });

    xList.shuffle();
    yList.shuffle();

    final stars = List<BackgroundStarEntity>.generate(xList.length, (idx) {
      return BackgroundStarEntity(
          radius: starSizes.random()!,
          xPos: xList[idx],
          startY: yList[idx],
          speed: starSpeeds.random()!);
    });

    addAll(stars);
  }
}
