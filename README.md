#Flame Signals

`flame_signals` offers a simple, type-safe mechanism to provide signals with or without data payloads
between components in a `FlameGame`.

Follow this link for a simple [example](https://pastordougdev.github.io/flame_signals). This is the example in the github repo.

## How To Use

### Add To Game

To use `flame_signals`, start by adding the `HasSignals` mixin to your game class:

```dart
class SpaceGame extends FlameGame with HasSignals {
  //...
}
```

The mixin defines a `Stream` of type `FlameSignal` to adding and broadcasting the signals.

### Define a signal class

Extend the base class `FlameSignal` to define one or more signal objects.

```dart
class MeteorDestroyedSignal extends FlameSignal {
  final Vector2 position;
  final double laserAngle;
  
  const MeteorDestroyedSignal({required this.position, required this.laserAngle});
}

class DecreaseMeteorCountSignal extends FlameSignal {}
```

### Send a signal

Any component in the tree will be able to send a `FlameSignal`.  Both the `SendSignals` and
`FlameSignalListenable` mixins provide an `addSignal` method to send out a signal.

```dart
class Meteor extends Component with SendSignals {
  //...
  //...
  void onHitByLaser() {
    addSignal(MeteorDestroyedSignal(
      position: position,
      laserAngle: laser.angle,
    ));
  }
}
```

### React to a signal received.

Components that need to react to game signal use the `FlameSignalListenable` mixin.
A signal handler must be registered in the components `onMount` life cycle method.

This creates a subscription to the signal stream.  When the component is removed from
the component tree, the onRemove life cycle method cancels the subscription.

```dart
class MeteorManager extends Component with FlameSignalListenable {
  @override
  void onMount() {
    super.onMount();
    onSignal<MeteorDestroyedSignal>((signal) {
      _generateNewMeteor();
      _updateMeteorCount();
    });
  }
}
```

A component using the FlameSignalListenable mixin can also add signals.

```dart
class MeteorManager extends Component with FlameSignalListenable {
  @override
  void onMount() {
    super.onMount();
    onSignal<MeteorDestroyedSignal>((signal) {
      _generateNewMeteor();
      _updateMeteorCount();
    });
  }
  //...
  //...
  void _updateMeteorCount() {
    addSignal(DecreaseMeteorCountSignal());
  }
}
```

## For more information

[GitHub Repo](https://github.com/pastordougdev/flame_signals)


[Example App (found in repo)](https://pastordougdev.github.io/flame_signals)
