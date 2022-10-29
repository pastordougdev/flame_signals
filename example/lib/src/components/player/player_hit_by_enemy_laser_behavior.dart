import 'package:flame_behaviors/flame_behaviors.dart';

import '../../imports.dart';

class PlayerHitByEnemyLaserBehavior
    extends CollisionBehavior<EnemyLaserEntity, PlayerEntity> {
  @override
  void onCollisionStart(intersectionPoints, other) {
    parent.hitByLaser();
    other.removeFromParent();
  }
}
