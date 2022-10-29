import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_signals/flame_signals.dart';

import 'imports.dart';

class ExampleGame extends FlameGame
    with HasSignals, HasCollisionDetection, HasKeyboardHandlerComponents {
  late final BackGroundEntity backGround;
  late final ScoreboardEntity scoreboard;
  late final PlayerEntity player;
  late final EnemyManager enemyManager;

  @override
  Future<void> onLoad() async {
    final spritesToLoad = <Future<Image>>[];
    GK.spriteFiles.forEach((key, fileName) =>
        spritesToLoad.add(Flame.images.load(fileName, key: key)));
    await Future.wait(spritesToLoad);

    backGround = BackGroundEntity();

    final sbSize = Vector2(size.x - 200.0, 100.0);
    final sbPos = Vector2(100.0, 0.0);
    scoreboard = ScoreboardEntity(size: sbSize, position: sbPos);

    player = PlayerEntity(position: Vector2(100.0, size.y / 2.0));

    enemyManager = EnemyManager();

    add(backGround);
    add(scoreboard);
    add(player);
    add(enemyManager);
  }
}
