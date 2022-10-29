import 'package:meta/meta.dart';
import 'package:flame/components.dart';

import 'flame_signal.dart';
import 'has_signals.dart';

/// Use this mixin on [Component]s that only need to send signal but do not need
/// to react to signals.
mixin FlameSendSignals on Component {
  @mustCallSuper
  @override
  void onMount() {
    super.onMount();
    final game = findGame()!;
    assert(game is HasSignals,
        'HasSignals must be added to FlameGame to add game signals');
  }

  /// Provides the ability to add signals to the signal stream from a component.
  /// Call this from anywhere in your component to add a signal to the stream.
  void addSignal<T extends FlameSignal>(T newSignal) {
    final game = (findGame()! as HasSignals);
    game.addSignal(newSignal);
  }
}
