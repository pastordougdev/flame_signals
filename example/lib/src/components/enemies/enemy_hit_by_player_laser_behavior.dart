import 'package:flame_behaviors/flame_behaviors.dart';

import '../../imports.dart';

class EnemyHitByPlayerLaserBehavior
    extends CollisionBehavior<PlayerLaserEntity, EnemyEntity> {
  @override
  void onCollisionStart(intersectionPoints, other) {
    if (!parent.canBeHit) return;
    parent.explode();
    other.removeFromParent();
  }
}
