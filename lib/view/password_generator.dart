import 'dart:math';

String getRandomString(int length) {
  Random _rnd = Random.secure();

  Map characters = {
    0: 'abcdefghijklmnopqrstuvwxyz',
    1: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    2: '1234567890',
    3: '!@#\$%^&*_-',
  };
  return String.fromCharCodes(Iterable.generate(length, (_) {
    String s = characters[_rnd.nextInt(4)];

    return s.codeUnitAt(_rnd.nextInt(s.length));
  }));
}
