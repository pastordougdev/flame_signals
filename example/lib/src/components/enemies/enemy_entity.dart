import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_signals/flame_signals.dart';

import '../../imports.dart';

class EnemyEntity extends Entity
    with HasGameRef<ExampleGame>, FlameSendSignals {
  final String spriteName;
  final String laserSpriteName;
  final double delay;

  late final Sprite sprite;
  SpriteAnimation? explosionAnimation;

  static final explosionSheet = SpriteSheet(
      image: Flame.images.fromCache('explosionSheet'),
      srcSize: Vector2.all(64.0));

  bool _canBeHit = true;
  bool _canMove = false;
  double _elapsed = 0.0;

  bool get canBeHit => _canBeHit;
  bool get canMove => _canMove;

  EnemyEntity({
    required this.spriteName,
    required this.laserSpriteName,
    this.delay = 0.0,
    super.position,
  }) : super(
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            EnemyMovementBehavior(),
            EnemyFireBehavior(),
            EnemyHitByPlayerLaserBehavior(),
          ],
        );

  @override
  Future<void> onLoad() async {
    sprite = Sprite(Flame.images.fromCache(spriteName));
    size = sprite.originalSize;
  }

  @override
  void update(double dt) {
    if (_elapsed < delay) {
      _elapsed += dt;
      return;
    } else {
      if (!_canMove) _canMove = true;
    }

    if (explosionAnimation != null) {
      explosionAnimation!.update(dt);
    }
  }

  @override
  void render(Canvas canvas) {
    if (explosionAnimation == null) {
      if (_canBeHit) {
        sprite.render(canvas);
      }
    } else {
      explosionAnimation!.getSprite().render(canvas);
    }
  }

  void explode() {
    _canBeHit = false;

    explosionAnimation = explosionSheet.createAnimation(
      row: 0,
      stepTime: 0.2,
      loop: false,
    )..onComplete = () {
        removeFromParent();
      };

    addSignal(const PlayerScoreSignal(score: 2));
  }

  void fireLaser() {
    final laser = EnemyLaserEntity(
      laserSpriteName: laserSpriteName,
      position: absoluteCenter,
    );
    gameRef.add(laser);
  }
}
