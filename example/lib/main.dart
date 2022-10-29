import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import './src/example_game.dart';

void main() {
  final game = ExampleGame();
  runApp(GameWidget(game: game));
}
