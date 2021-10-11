import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
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

class Player extends SpriteComponent with Hitbox, Collidable {
  Player() : super(size: Vector2.all(32));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('ball.png');
    anchor = Anchor.center;
    final hitbox = HitboxCircle(definition: 32);
    addHitbox(hitbox);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize / 2;
  }
}

class Platform extends SpriteComponent with Hitbox, Collidable {
  Platform() : super(size: Vector2(128, 32));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('platform.png');
    anchor = Anchor.center;
    final hitbox = HitboxRectangle(relation: Vector2(128, 32));
    addHitbox(hitbox);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = Vector2(gameSize[0] / 2, gameSize[1] - 100);
  }
}

class SunflowerDash extends FlameGame with HasCollidables {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Player());
    add(Platform());
  }
}
