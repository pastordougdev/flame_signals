import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame_signals/flame_signals.dart';

import '../../imports.dart';

class PlayerScore extends TextComponent with FlameSignalListenable {
  int _score = 0;
  String _scoreText = 'Player: 0';

  late final TextPaint painter;
  late final TextStyle style;

  PlayerScore({super.size, super.position}) {
    style = GK.primaryFontBold(32.0, color: Colors.tealAccent);
    painter = TextPaint(style: style);
    textRenderer = painter;
    text = _scoreText;
  }

  @override
  void onMount() {
    super.onMount();

    onSignal<PlayerScoreSignal>((signal) {
      _score += signal.score;
      _scoreText = 'Player: $_score';
      text = _scoreText;
    });
  }

  @override
  void render(Canvas canvas) {
    //print('render text');
    super.render(canvas);
  }
}
