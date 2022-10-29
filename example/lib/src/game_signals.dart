import 'package:flame_signals/flame_signals.dart';

class PlayerScoreSignal extends FlameSignal {
  final int score;
  const PlayerScoreSignal({this.score = 1});
}

class EnemyScoreSignal extends FlameSignal {
  final int score;
  const EnemyScoreSignal({this.score = 1});
}
