import 'package:flame_signals/flame_signals.dart';
import 'package:flutter/material.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame/components.dart';

import '../../imports.dart';

class ScoreboardEntity extends Entity
    with FlameSignalListenable, ParentIsA<ExampleGame>, HasPaint {

  late PlayerScore playerScore;
  late EnemyScore enemyScore;
  late RRect borderRect;
  static const borderWidth = 10.0;

  ScoreboardEntity({super.size, super.position});

  @override
  Future<void> onLoad() async {
    final rect = Rect.fromLTWH(0.0, 0.0 + borderWidth / 2.0, size.x, size.y);
    borderRect = RRect.fromRectAndRadius(rect, const Radius.circular(12.0));
    paint.color = Colors.teal;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = borderWidth;

    playerScore = PlayerScore(
      size: Vector2(200, 50),
      position: Vector2(100, 25),
    );

    enemyScore = EnemyScore(
      size: Vector2(200, 50),
      position: Vector2(600, 25),
    );

    add(playerScore);
    add(enemyScore);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(borderRect, paint);
  }
}
