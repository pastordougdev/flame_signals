import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_signals.dart';

void main() {
  group('Flame Send Signals', () {
    testWithGame<NoSignalsGame>(
      'Throws assertion error if HasSignals mixin not present on game class',
      () => NoSignalsGame(),
      (NoSignalsGame game) async {
        await game.mounted;

        final component = PowerUpItem();
        expect(() async {
          await game.ensureAdd(component);
        }, throwsAssertionError);
      },
    );

    testWithGame<SignalsGame>(
        'No error when HasSignals mixin is present on game class',
        () => SignalsGame(), (SignalsGame game) async {
      await game.mounted;

      final component = PowerUpItem();
      expect(() => game.ensureAdd(component), returnsNormally);
    });

    testWithGame<SignalsGame>('Add Signal From Component', () => SignalsGame(),
        (SignalsGame game) async {
      await game.mounted;
      final component = PowerUpItem();
      await game.ensureAdd(component);
      await component.mounted;
      expect(() {
        component.collected();
      }, returnsNormally);
    });
  });
}
