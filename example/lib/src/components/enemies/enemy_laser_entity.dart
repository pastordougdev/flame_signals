import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame/components.dart';

import '../../imports.dart';

class EnemyLaserEntity extends Entity with HasGameRef<ExampleGame> {
  static final velocity = Vector2(-500, 0);
  late final Sprite sprite;

  EnemyLaserEntity({
    required String laserSpriteName,
    super.position,
  }) : super(
          anchor: Anchor.center,
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
          ],
        ) {
    sprite = Sprite(Flame.images.fromCache(laserSpriteName));
  }

  @override
  Future<void> onLoad() async {
    size = sprite.originalSize;
  }

  @override
  void update(double dt) {
    position.add(velocity * dt);
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    sprite.render(canvas, size: size);
  }
}
