

import 'package:flutter/cupertino.dart';

class ColorExtends extends Color {
  ColorExtends(int value) : super(value);

  static Color fromHex(String hexStr) {
    final buffer = StringBuffer();
    if (hexStr.length == 6 || hexStr.length == 7) buffer.write('ff');
    buffer.write(hexStr.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
