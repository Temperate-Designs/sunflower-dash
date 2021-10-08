import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

void main() {
  final game = SunflowerDash();
  runApp(GameWidget(game: game));
}

class Player extends SpriteComponent {
  // creates a component that renders the crate.png sprite, with size 16 x 16
  Player() : super(size: Vector2.all(32));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('ball.png');
    anchor = Anchor.center;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    // We don't need to set the position in the constructor, we can it directly here since it will
    // be called once before the first time it is rendered.
    super.onGameResize(gameSize);
    position = gameSize / 2;
  }
}

class SunflowerDash extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Player());
  }
}
