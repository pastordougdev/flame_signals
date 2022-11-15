import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flame/components.dart';

import 'flame_signal.dart';
import 'has_signals.dart';

///This mixin provides ability for a [Component] to react to a game signal.  The
///addSignal method is also provided to add signals to the signal stream.
///
/// The [HasSignals] mixin must be added to the top level game instance.
///
/// Register signal handlers in the onMount lifecycle method using the onSignal
/// method.
mixin FlameSignalListenable on Component {
  late List<_SHandler> _signalHandlers;
  late List<StreamSubscription<dynamic>> _subscriptions;

  @mustCallSuper
  @override
  void onMount() {
    super.onMount();
    final game = findGame()!;
    assert(
      game is HasSignals,
      'HasSignals must be added to a FlameGame to listen to signals',
    );
    _subscriptions = <StreamSubscription<dynamic>>[];
    _signalHandlers = <_SHandler>[];
  }

  @mustCallSuper
  @override
  void onRemove() {
    super.onRemove();
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions = <StreamSubscription<dynamic>>[];
  }

  ///Register signal handler for a signal of type `T`.
  ///There should only every be one signal handler per signal type `T`
  ///on each [Component].
  ///
  /// *** Call this method in the onMount lifecycle method ***
  ///
  /// ```dart
  /// @override
  /// void onMount() {
  ///   super.onMount();
  ///   onSignal<MeteorDestroyedSignal>((signal) => isDestroyed = true);
  /// }
  /// ```
  ///
  /// A [StateError] will be thrown if there are multiple signal handlers
  /// registered for the same type `T`.
  void onSignal<T extends FlameSignal>(FlameSignalHandler<T> handler) {
    assert(() {
      final signalHandlerExists = _signalHandlers.any((sh) => sh.type == T);
      if (signalHandlerExists) {
        throw StateError('on<$T> was called multiple times.'
            'There should only be a single member per signal type');
      }
      return true;
    }());

    _signalHandlers.add(_SHandler(type: T, isType: (dynamic st) => st is T));

    final game = findGame()!;
    final newSubscription = (game as HasSignals)
        .signalStream
        .where((event) => event is T)
        .cast<T>()
        .listen((signal) => handler(signal));

    _subscriptions.add(newSubscription);
  }

  /// Provides the ability to add signals to the signal stream from a component.
  /// Call this from anywhere in your component to add a signal to the stream.
  void addSignal<T extends FlameSignal>(T newSignal) {
    final game = (findGame()! as HasSignals);
    game.addSignal(newSignal);
  }
}

class _SHandler {
  final Type type;
  final bool Function(dynamic value) isType;

  _SHandler({
    required this.type,
    required this.isType,
  });
}
