import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'plaform.dart';

class Player extends SpriteComponent with Hitbox, Collidable {
  var speed = Vector2.zero();
  final maxSpeed = 200;
  var acceleration = Vector2(0, 20);
  var platformCollision = false;
  final JoystickComponent joystick;

  Player(this.joystick) : super(size: Vector2.all(32)) {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('ball.png');
    anchor = Anchor.center;
    final hitbox = HitboxRectangle();
    addHitbox(hitbox);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize / 2;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Platform && !platformCollision) {
      platformCollision = true;
      speed = Vector2.zero();
      print('Hit platform!');
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    if (other is Platform && platformCollision) {
      platformCollision = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * 80 * dt);
    }
    if (!platformCollision) {
      speed += acceleration * dt;
      if (speed.length > maxSpeed) {
        speed *= maxSpeed / speed.length;
      }
      position += speed * dt;
    }
  }
}
