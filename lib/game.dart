import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/geometry.dart';

import 'player.dart';
import 'plaform.dart';

class SunflowerDash extends FlameGame
    with HasCollidables, HasDraggableComponents {
  SunflowerDash();
  @override
  Future<void> onLoad() async {
    super.onLoad();

    late final joystick;
    late final joystickPlayer;

    final knowPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();

    joystick = JoystickComponent(
      size: 2.0,
      knob: Circle(radius: 20).toComponent(paint: knowPaint),
      background: Circle(radius: 60).toComponent(paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 10, bottom: 10),
    );
    // joystickPlayer = JoystickPlayer(joystick);

    add(joystick);

    final player = Player(joystick);

    add(player);

    final platform = Platform();

    add(platform);
  }
}
