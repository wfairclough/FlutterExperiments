import 'dart:math';

main() {
  var randRed = Random().nextInt(0xFF);
  var randGreen = Random().nextInt(0xFF);
  var randBlue = Random().nextInt(0xFF);

  var value = 0xFF << 8 | randRed;
  value = value << 8 | randGreen;
  value = value << 8 | randBlue;

  print('value ${value.toRadixString(16)}');
}
