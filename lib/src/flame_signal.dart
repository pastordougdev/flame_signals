///[FlameSignal] is the base class for signals.  Extend this class to define your
///in game signals.  This allows you to define any payload that needs to be send
///on a particular game signal
///
///  Example
///  ```dart
///  class MeteorDestroyedSignal extends FlameSignal {
///    final Vector2 position;
///    final double laserAngle;
///
///    const MeteorDestroyedSignal({
///      required this.position,
///      required this.laserAngle,
///    });
///  }
///  ```
abstract class FlameSignal {
  const FlameSignal();
}

/// A signal handler is responsible for reacting to an incoming [FlameSignal]
typedef FlameSignalHandler<S> = void Function(S signal);
