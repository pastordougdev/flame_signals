import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame/components.dart';

import '../../imports.dart';

class EnemyMovementBehavior extends Behavior<EnemyEntity> with HasGameRef {
  final velocity = Vector2(-200.0, 0.0);

  @override
  void update(double dt) {
    if (!parent.canMove || !parent.canBeHit) return;

    parent.position.add(velocity * dt);

    if (parent.x < -parent.size.x) {
      parent.x = gameRef.size.x + parent.size.x;
    }
  }
}
