import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import '../../imports.dart';

class PlayerFireLaserBehavior extends Behavior<PlayerEntity>
    with HasGameRef<ExampleGame> {
  @override
  Future<void> onLoad() async {
    add(
      KeyboardListenerComponent(keyUp: {
        LogicalKeyboardKey.space: (keysPressed) {
          //parent.fireLaser();
          final laser = PlayerLaserEntity(position: parent.absoluteCenter);
          gameRef.add(laser);
          return false;
        }
      }),
    );
  }
}
