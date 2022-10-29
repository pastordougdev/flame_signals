import 'dart:math';

import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import '../../imports.dart';

class PlayerMovementBehavior extends Behavior<PlayerEntity>
    with HasGameRef<ExampleGame>, KeyboardHandler {
  Vector2 velocity = Vector2.zero();
  double _minY = 0.0;
  double _maxY = 0.0;
  double _thrustDirection = 0.0;

  static const speed = 350.0;

  PlayerMovementBehavior();

  @override
  Future<void> onLoad() async {
    add(_keyboardListenerComponent());
    _minY = 100.0 + (parent.size.y / 2.0);
    _maxY = gameRef.size.y - (parent.size.y / 2.0);
  }

  @override
  void update(double dt) {
    final deltaY = speed * _thrustDirection * dt;
    if (_thrustDirection < 0.0) {
      parent.position.y = max(parent.position.y + deltaY, _minY);
    } else if (_thrustDirection > 0.0) {
      parent.position.y = min(parent.position.y + deltaY, _maxY);
    }
  }

  KeyboardListenerComponent _keyboardListenerComponent() {
    return KeyboardListenerComponent(keyDown: {
      LogicalKeyboardKey.arrowUp: (keysPressed) {
        _thrustDirection = -1.0;
        return false;
      },
      LogicalKeyboardKey.arrowDown: (keysPressed) {
        _thrustDirection = 1.0;
        return false;
      },
    }, keyUp: {
      LogicalKeyboardKey.arrowUp: (keysPressed) {
        _thrustDirection = 0.0;
        return false;
      },
      LogicalKeyboardKey.arrowDown: (keysPressed) {
        _thrustDirection = 0.0;
        return false;
      },
    });
  }
}
