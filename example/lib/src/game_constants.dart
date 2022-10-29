import 'package:flutter/material.dart';

class GK {
  static const spriteFiles = {
    'player': 'player.png',
    'enemyGreen': 'enemyGreen.png',
    'enemyBlue': 'enemyBlue.png',
    'enemyRed': 'enemyRed.png',
    'explosionSheet': 'explosionSheet.png',
    'enemyLaserGreen': 'enemyLaserGreen.png',
    'enemyLaserRed': 'enemyLaserRed.png',
    'enemyLaserBlue': 'enemyLaserBlue.png',
    'laser': 'laserRed.png',
  };

  static const primaryFontName = 'GemunuLibre';

  static TextStyle primaryFont(double size, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFontName,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle primaryFontLight(double size, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w300,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle primaryFontBold(double size, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w700,
      fontSize: size,
      color: color,
    );
  }
}
