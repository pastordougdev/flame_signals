import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame/components.dart';
import 'package:flame_signals/flame_signals.dart';

import '../../imports.dart';

class PlayerEntity extends Entity
    with FlameSignalListenable, ParentIsA<ExampleGame> {
  final sprite = Sprite(Flame.images.fromCache('player'));

  double yMin = 100.0;
  double yMax = 100.0;

  PlayerEntity({super.position})
      : super(
          priority: 2,
          anchor: Anchor.center,
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            PlayerMovementBehavior(),
            PlayerFireLaserBehavior(),
            PlayerHitByEnemyLaserBehavior(),
            PlayerHitEnemyBehavior(),
          ],
        );

  @override
  Future<void> onLoad() async {
    size = sprite.originalSize;
    yMin += size.y / 2.0;
    yMax = parent.size.y - (size.y / 2.0);
  }

  @override
  void render(Canvas canvas) {
    sprite.render(canvas);
  }

  void hitByLaser() {
    addSignal(const EnemyScoreSignal(score: 1));
  }

  void hitByEnemy() {
    addSignal(const EnemyScoreSignal(score: 5));
  }
}
