import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../imports.dart';

class BackgroundStarEntity extends Entity with HasPaint {
  final double radius;
  final double xPos;
  final double speed;

  static const starColor = Colors.lightBlueAccent;

  BackgroundStarEntity(
      {required this.radius,
      required this.xPos,
      required this.speed,
      required double startY})
      : super(
          anchor: Anchor.center,
          size: Vector2.all(radius * 2),
          position: Vector2(xPos, startY),
          behaviors: [
            BackgroundStarMovementBehavior(velocity: Vector2(-speed, 0.0)),
          ],
        );

  @override
  void onMount() {
    paint.color = starColor;
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    final center = size / 2;
    canvas.drawCircle(center.toOffset(), radius, paint);
  }
}
