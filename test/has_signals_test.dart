import 'package:flutter_test/flutter_test.dart';
import 'test_signals.dart';

void main() {
  group('Has Signals', () {
    test('Game Starts with Has Signals Mixin', () async {
      Future<void> setupGame() async {
        final game = SignalsGame();
        await game.ready();
      }

      expect(() async {
        await setupGame();
      }, returnsNormally);
    });

    test('Signal Stream is available', () async {
      final game = SignalsGame();
      await game.ready();
      final signalStream = game.signalStream;

      expect(signalStream.isBroadcast, true);
      expect(game.signalController.isClosed, false);
    });

    test('Add Signal From Game Class', () async {
      final game = SignalsGame();
      await game.ready();

      expect(() async {
        game.addSignal(TestSignal());
      }, returnsNormally);
    });
  });
}
