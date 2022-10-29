import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class BackgroundStarMovementBehavior extends Behavior with HasGameRef {
  final Vector2 velocity;
  BackgroundStarMovementBehavior({required this.velocity});

  @override
  void update(double dt) {
    final nextPos = parent.position + (velocity * dt);
    if (nextPos.x < 0 - parent.size.x) {
      nextPos.x = gameRef.size.x + parent.size.x;
    }
    parent.position = nextPos;
  }
}
