import 'package:flutter/material.dart';

extension StringEx on String {
  Color get fromHex => Color(int.parse('0xff$this'));
}

extension ColorEx on Color {
  String get toHex => value.toRadixString(16).substring(2);

  Color get visibleTextColor =>
      ThemeData.estimateBrightnessForColor(this) == Brightness.light
          ? Colors.black
          : Colors.white;
}
