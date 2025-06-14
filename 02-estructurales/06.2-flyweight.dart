/**
 * ! Patrón Flyweight
 * Es un patrón de diseño estructural que nos permite usar objetos compartidos
 * para soportar eficientemente grandes cantidades de objetos.
 *
 * * Es útil cuando necesitamos una gran cantidad de objetos y queremos reducir
 * * la cantidad de memoria que utilizan.
 */

enum BulletTypes { gun, shotgun, rifle }

final class BulletType {
  BulletType({required this.type, required this.damage, required this.color});

  final BulletTypes type;
  final int damage;
  final String color;
}

final class BulletTypeFactory {
  // Save bullets by enum type
  final Map<String, BulletType> _bulletTypes = {};

  BulletType getBulletType({
    required BulletTypes type,
    required int damage,
    required String color,
  }) {
    final key = '${type.name}_${damage}_$color';

    if (_bulletTypes.containsKey(key)) {
      return _bulletTypes[key]!;
    }

    // Create a new bullet, save it and returned it
    final newBullet = BulletType(type: type, damage: damage, color: color);
    print('New bullet created [${newBullet.type.name}]');
    _bulletTypes[key] = newBullet;
    return newBullet;
  }
}

final class Bullet {
  Bullet({
    required int x,
    required int y,
    required int direction,
    required BulletType bulletType,
  }) : _x = x,
       _y = y,
       _direction = direction,
       _bulletType = bulletType;

  final int _x;
  final int _y;
  final int _direction;
  final BulletType _bulletType;

  void display() {
    final text = '''
      Bullet type: ${_bulletType.type.name}
      Coords: (${_x}, ${_y})
      Direction ${_direction}
      Damage: ${_bulletType.damage}
      Color: ${_bulletType.color}
    ''';
    print(text);
  }
}

final class ShootingSystem {
  ShootingSystem({required BulletTypeFactory factory}) : _factory = factory;

  final List<Bullet> _bullets = [];
  final BulletTypeFactory _factory;

  void shoot(
    int x,
    int y,
    int direction,
    BulletTypes type,
    int damage,
    String color,
  ) {
    final bulletType = _factory.getBulletType(
      type: type,
      damage: damage,
      color: color,
    );
    final bullet = Bullet(
      x: x,
      y: y,
      direction: direction,
      bulletType: bulletType,
    );
    _bullets.add(bullet);
    bullet.display();
  }

  int getBulletCount() => this._bullets.length;
}

void main(List<String> args) {
  final factory = BulletTypeFactory();
  final gun = ShootingSystem(factory: factory);

  gun.shoot(10, 20, 0, BulletTypes.gun, 10, 'Gray');
  gun.shoot(10, 20, 0, BulletTypes.gun, 10, 'Gray');
  gun.shoot(10, 20, 0, BulletTypes.gun, 10, 'Gray');
  gun.shoot(15, 25, 90, BulletTypes.shotgun, 20, 'Red');
  gun.shoot(20, 30, 180, BulletTypes.rifle, 15, 'Green');
  gun.shoot(10, 20, 45, BulletTypes.gun, 10, 'Gray');
  gun.shoot(25, 35, 270, BulletTypes.shotgun, 20, 'Red');
  gun.shoot(25, 35, 270, BulletTypes.shotgun, 20, 'Red');
  gun.shoot(25, 35, 270, BulletTypes.shotgun, 20, 'Red');
  gun.shoot(25, 35, 270, BulletTypes.shotgun, 20, 'Red');

  print('Total bullets fired: ${gun.getBulletCount()}');
}
