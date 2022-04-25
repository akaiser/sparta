import 'package:flutter/material.dart';

const _fontFamily = 'OpenSans';

const _black = Color.fromRGBO(0, 0, 0, 1);
const _white = Color.fromRGBO(255, 255, 255, 1);

const accentColor = Colors.lightBlue;

const gridBackgroundColor = Color.fromRGBO(0, 0, 0, 0.70);

const sectionsDividerThickness = 1.0;

const verticalDivider = Divider(height: 1, thickness: sectionsDividerThickness);

const currentDayBorder = Border(
  bottom: BorderSide(width: 2, color: accentColor),
);

class Themes {
  static ThemeData get lightTheme {
    const primary = Color.fromRGBO(215, 215, 215, 1);
    return ThemeData(
      fontFamily: _fontFamily,
      brightness: Brightness.light,
      cardColor: _white,
      dividerColor: primary,
      highlightColor: _white,
      primaryColorLight: const Color.fromRGBO(238, 238, 238, 1),
      primaryColorDark: Colors.black26,
    );
  }

  static ThemeData get darkTheme {
    const primary = Color.fromRGBO(30, 30, 30, 1);
    return ThemeData(
      fontFamily: _fontFamily,
      brightness: Brightness.dark,
      cardColor: const Color.fromRGBO(47, 47, 47, 1),
      dividerColor: primary,
      highlightColor: _black,
      primaryColorLight: const Color.fromRGBO(37, 37, 37, 1),
      primaryColorDark: Colors.black26,
    );
  }
}

class AppTextTheme {
  const AppTextTheme(this._textTheme);

  final TextTheme _textTheme;

  TextStyle get bodyLarge => _textTheme.bodyLarge!.copyWith(fontSize: 15);

  TextStyle get bodyMedium => _textTheme.bodyMedium!;

  TextStyle get subtitle2 => _textTheme.subtitle2!.copyWith(fontSize: 13);

  TextStyle get labelSmall => _textTheme.labelSmall!;

  TextStyle get labelMedium => _textTheme.labelMedium!;
}
