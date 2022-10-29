import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_signals/flame_signals.dart';

class SignalsGame extends FlameGame with HasSignals {}

class NoSignalsGame extends FlameGame {}

class TestSignal extends FlameSignal {}

class IncreaseHealthSignal extends FlameSignal {
  final int health;
  const IncreaseHealthSignal(this.health);
}

class DecreaseHealthSignal extends FlameSignal {
  final int health;
  const DecreaseHealthSignal(this.health);
}

class PowerUpItem extends Component with FlameSendSignals {
  void collected() {
    addSignal(const IncreaseHealthSignal(5));
  }
}

class Laser extends Component with FlameSendSignals {
  void hitPlayer() {
    addSignal(const DecreaseHealthSignal(3));
  }
}

class HealthBar extends Component with FlameSignalListenable {
  final int maxHealth;
  int health = 0;

  HealthBar({required this.maxHealth}) {
    health = maxHealth;
  }

  @override
  void onMount() {
    super.onMount();
    onSignal<IncreaseHealthSignal>((signal) {
      health = min(health + signal.health, maxHealth);
    });
    onSignal<DecreaseHealthSignal>((signal) {
      health = max(health - signal.health, 0);
    });
  }
}

class BadHealthBar extends Component with FlameSignalListenable {
  final int maxHealth;
  int health = 0;

  BadHealthBar({required this.maxHealth}) {
    health = maxHealth;
  }

  @override
  void onMount() {
    super.onMount();
    onSignal<IncreaseHealthSignal>((signal) {
      health = min(health + signal.health, maxHealth);
    });
    onSignal<IncreaseHealthSignal>((signal) {
      health = max(health - signal.health, 0);
    });
  }
}

class SignalsGame2 extends FlameGame with HasSignals {
  late PowerUpItem powerUpItem;
  late HealthBar healthBar;
  late Laser laser;

  @override
  Future<void> onLoad() async {
    powerUpItem = PowerUpItem();
    healthBar = HealthBar(maxHealth: 20);
    laser = Laser();

    add(powerUpItem);
    add(healthBar);
    add(laser);
  }
}

class DuplicateGame extends FlameGame with HasSignals {}
