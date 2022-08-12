import 'package:flutter/material.dart';

const _fontFamily = 'OpenSans';

const _black = Color.fromRGBO(0, 0, 0, 1);
const _white = Color.fromRGBO(255, 255, 255, 1);

const lightBlue = Colors.lightBlue;

const gridBackgroundColor = Color.fromRGBO(0, 0, 0, 0.70);

const sectionsDividerThickness = 1.0;

const verticalDivider = Divider(height: 1, thickness: sectionsDividerThickness);

final currentDayBorder = Border.all(width: 2, color: lightBlue);
final hoverDayBorder = Border.all(width: 2, color: Colors.grey);

class Themes {
  static ThemeData get lightTheme {
    const primary = Color.fromRGBO(215, 215, 215, 1);
    return ThemeData(
      fontFamily: _fontFamily,
      brightness: Brightness.light,
      selectedRowColor: const Color.fromRGBO(213, 213, 213, 1),
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
      selectedRowColor: Colors.black26,
      dividerColor: primary,
      highlightColor: _black,
      primaryColorLight: const Color.fromRGBO(37, 37, 37, 1),
      primaryColorDark: const Color.fromRGBO(117, 117, 117, 1),
    );
  }
}

class AppTextTheme {
  const AppTextTheme(this._textTheme);

  final TextTheme _textTheme;

  TextStyle? get bodyLarge => _textTheme.bodyLarge?.copyWith(fontSize: 15);

  TextStyle? get bodyMedium => _textTheme.bodyMedium;

  TextStyle? get subtitle2 => _textTheme.subtitle2?.copyWith(fontSize: 13);

  TextStyle? get labelSmall => _textTheme.labelSmall;

  TextStyle? get labelMedium => _textTheme.labelMedium;
}

const sonstiges = Color.fromRGBO(128, 64, 0, 1);
const auslieferung = Color.fromRGBO(0, 0, 0, 1);
const mietwagen = Color.fromRGBO(255, 0, 0, 1);
const urlaub = Color.fromRGBO(139, 195, 74, 1);
const schulung = Color.fromRGBO(192, 192, 192, 1);
const feiertage = Color.fromRGBO(255, 128, 0, 1);
const werkstatt = Color.fromRGBO(151, 151, 255, 1);
const geburtstage = Color.fromRGBO(255, 255, 0, 1);
