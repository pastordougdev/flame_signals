import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'test_signals.dart';

void main() {
  group('Flame Signal Listenable', () {
    testWithGame<NoSignalsGame>(
      'Throws assertion error if HasSignals mixin not present on game class',
      () => NoSignalsGame(),
      (NoSignalsGame game) async {
        await game.mounted;

        final component = HealthBar(maxHealth: 20);
        expect(() async {
          await game.ensureAdd(component);
        }, throwsAssertionError);
      },
    );

    test('abc', () async {
      final game = DuplicateGame();
      game.onGameResize(Vector2(800, 600));
      await game.onLoad();
      game.onMount();
      game.update(0);
      await game.ready();
      await game.mounted;

      final healthBar = BadHealthBar(maxHealth: 20);

      expect(() async {
        await game.ensureAdd(healthBar);
      }, throwsStateError);
    });

    testWithGame<SignalsGame>(
        'No error when HasSignals mixin is present on game class',
        () => SignalsGame(), (SignalsGame game) async {
      await game.mounted;

      final component = HealthBar(maxHealth: 20);
      expect(() => game.ensureAdd(component), returnsNormally);
    });

    testWithGame<SignalsGame2>(
      'Receive signal from another component',
      () => SignalsGame2(),
      (SignalsGame2 game) async {
        await game.mounted;
        await game.powerUpItem.mounted;
        await game.healthBar.mounted;
        await game.laser.mounted;

        game.laser.hitPlayer();
        await Future.microtask(() {});
        expect(game.healthBar.health, equals(17));

        game.laser.hitPlayer();
        await Future.microtask(() {});

        game.powerUpItem.collected();
        await Future.microtask(() => {});
        expect(game.healthBar.health, equals(19));
      },
    );
  });
}
