// ignore_for_file: avoid_positional_boolean_parameters
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparta/l10n/mappers/week_view.dart';

const _keyPrefix = 'de.kaiserv.sparta';
const _isLightThemeKey = '$_keyPrefix.is_light_theme';
const _isLeftViewVisibleKey = '$_keyPrefix.is_left_view_visible';
const _weekViewKey = '$_keyPrefix.week_view';

class Settings {
  Settings._();

  static final _instance = SharedPreferences.getInstance();

  static late bool isLightTheme;
  static late bool isLeftViewVisible;
  static late String weekView;

  static Future<void> init() async {
    isLightTheme = await _getOrSetBool(_isLightThemeKey, true);
    isLeftViewVisible = await _getOrSetBool(_isLeftViewVisibleKey, true);
    weekView = await _getOrSetString(_weekViewKey, WeekView.week.name);
  }

  static Future<void> setIsLightTheme(bool isLightTheme) =>
      _setBool(_isLightThemeKey, isLightTheme)
          .then((_) => Settings.isLightTheme = isLightTheme);

  static Future<void> setIsLeftViewVisible(bool isLeftViewVisible) =>
      _setBool(_isLeftViewVisibleKey, isLeftViewVisible)
          .then((_) => Settings.isLeftViewVisible = isLeftViewVisible);

  static Future<void> setWeekView(String weekView) =>
      _setString(_weekViewKey, weekView)
          .then((_) => Settings.weekView = weekView);

  // getOrSet //

  static Future<bool> _getOrSetBool(String key, bool initValue) =>
      _instance.then(
        (prefs) async =>
            prefs.getBool(key) ??
            await prefs.setBool(key, initValue).then((_) => initValue),
      );

  static Future<String> _getOrSetString(String key, String initValue) =>
      _instance.then(
        (prefs) async =>
            prefs.getString(key) ??
            await prefs.setString(key, initValue).then((_) => initValue),
      );

  // set //

  static Future<void> _setBool(String key, bool value) =>
      _instance.then((prefs) => prefs.setBool(key, value));

  static Future<void> _setString(String key, String value) =>
      _instance.then((prefs) => prefs.setString(key, value));
}
