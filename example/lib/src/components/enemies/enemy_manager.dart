import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame/components.dart';

import '../../imports.dart';

class EnemyManager extends Entity with HasGameRef<ExampleGame> {
  int _spriteIdx = 0;
  int _laneIdx = 0;
  double _elapsed = 4.0;

  static const spriteNames = ['enemyGreen', 'enemyBlue', 'enemyRed'];
  static const laserNames = [
    'enemyLaserGreen',
    'enemyLaserBlue',
    'enemyLaserRed'
  ];
  static const checkEnemiesInterval = 5.0;
  static const addInterval = 0.75;
  static const numberOfEnemies = 12;
  final lanes = <double>[];

  @override
  Future<void> onLoad() async {
    _buildLanes();
    _elapsed = checkEnemiesInterval;
  }

  @override
  void update(double dt) {
    _elapsed += dt;
    if (_elapsed >= checkEnemiesInterval) {
      _checkEnemies();
      _elapsed = 0.0;
    }
  }

  void _checkEnemies() {
    final currentEnemies = gameRef.children.whereType<EnemyEntity>().toList();
    if (currentEnemies.length >= numberOfEnemies) return;
    final neededEnemies = numberOfEnemies - currentEnemies.length;
    for (int i = 1; i <= neededEnemies; ++i) {
      final pos = Vector2(gameRef.size.x + 100, lanes[_laneIdx]);
      final enemy = EnemyEntity(
        spriteName: spriteNames[_spriteIdx],
        laserSpriteName: laserNames[_spriteIdx],
        position: pos,
        delay: addInterval * i,
      );
      gameRef.add(enemy);
      _spriteIdx += 1;
      if (_spriteIdx >= spriteNames.length) _spriteIdx = 0;
      _laneIdx += 1;
      if (_laneIdx >= lanes.length) _laneIdx = 0;
    }
  }

  void _buildLanes() {
    final images = spriteNames.map((s) => Flame.images.fromCache(s)).toList();
    final tallestSprite = images.reduce((currImg, nextImg) =>
        nextImg.height > currImg.height ? nextImg : currImg);
    final tallestEnemyHeight = tallestSprite.height;

    var lane = 110.0;
    while (lane + tallestEnemyHeight + 20.0 < gameRef.size.y - 20.0) {
      lanes.add(lane);
      lane += tallestEnemyHeight + 20.0;
    }

    lanes.shuffle();
  }
}
