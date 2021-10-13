import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Flame.device.fullScreen();
  // Flame.device.setOrientation(DeviceOrientation.landscapeLeft);
  final game = SunflowerDash();
  runApp(GameWidget(game: game));
}
