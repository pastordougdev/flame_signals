import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:meta/meta.dart';
import 'flame_signal.dart';
import 'flame_signal_listenable.dart';
import 'flame_send_signals.dart';

/// [HasSignals] mixin provides a [Stream] for sending signals between Flame
/// [Component]s.  This mixin must be added to the top-level game instance.

mixin HasSignals on FlameGame {
  final _signalController = StreamController<FlameSignal>.broadcast();
  @visibleForTesting
  StreamController get signalController => _signalController;

  /// Provides the signal stream to components in the tree.  This property is
  /// accessible in the component, but isn't meant to be accessed directly,
  /// but rather will be accessed in the [FlameSignalListenable] mixin to receive
  /// the signals from the stream or the [FlameSendSignals] mixin to add signals
  /// to the stream.
  Stream<FlameSignal> get signalStream => _signalController.stream;

  /// Provides the ability to add signals to the signal stream from the base
  /// game instance.  This is the same method available in the [FlameSignalListenable]
  /// and [FlameSendSignals] mixin.
  addSignal(FlameSignal newSignal) => _signalController.add(newSignal);
}
