import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame/components.dart';

import '../../imports.dart';

class PlayerLaserEntity extends Entity with HasGameRef<ExampleGame> {
  final velocity = Vector2(500, 0);
  static final sprite = Sprite(Flame.images.fromCache('laser'));

  bool canHit = true;

  PlayerLaserEntity({super.position})
      : super(
          anchor: Anchor.center,
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
          ],
        );

  @override
  Future<void> onLoad() async {
    size = sprite.originalSize;
  }

  @override
  void update(double dt) {
    position.add(velocity * dt);
    if (position.x > gameRef.size.x + size.x) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    sprite.render(canvas, size: size);
  }
}
