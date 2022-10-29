import 'package:flame_behaviors/flame_behaviors.dart';

import '../../imports.dart';

class PlayerHitEnemyBehavior
    extends CollisionBehavior<EnemyEntity, PlayerEntity> {
  @override
  void onCollisionStart(intersectionPoints, other) {
    parent.hitByEnemy();
    other.explode();
  }
}
