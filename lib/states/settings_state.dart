import 'package:equatable/equatable.dart';
import 'package:sparta/_settings.dart';
import 'package:sparta/l10n/mappers/week_view.dart';

abstract class _SettingsAction extends Equatable {
  const _SettingsAction();

  @override
  List<Object?> get props => [];
}

class ToggleThemeAction extends _SettingsAction {
  const ToggleThemeAction();
}

class ToggleLeftViewVisibilityAction extends _SettingsAction {
  const ToggleLeftViewVisibilityAction();
}

class SetWeekViewAction extends _SettingsAction {
  const SetWeekViewAction(this.weekView);

  final WeekView weekView;

  @override
  List<Object?> get props => [weekView];
}

SettingsState settingsStateReducer(SettingsState old, dynamic action) {
  if (action is _SettingsAction) {
    if (action is ToggleThemeAction) {
      final newIsLightTheme = !old.isLightTheme;
      Settings.setIsLightTheme(newIsLightTheme);
      return old.copyWith(isLightTheme: newIsLightTheme);
    } else if (action is ToggleLeftViewVisibilityAction) {
      final newIsLeftViewVisible = !old.isLeftViewVisible;
      Settings.setIsLeftViewVisible(newIsLeftViewVisible);
      return old.copyWith(isLeftViewVisible: newIsLeftViewVisible);
    } else if (action is SetWeekViewAction) {
      final newWeekView = action.weekView;
      Settings.setWeekView(newWeekView.name);
      return old.copyWith(weekView: newWeekView);
    }
  }
  return old;
}

class SettingsState extends Equatable {
  const SettingsState({
    bool? isLightTheme,
    bool? isLeftViewVisible,
    WeekView? weekView,
  })  : _isLightTheme = isLightTheme,
        _isLeftViewVisible = isLeftViewVisible,
        _weekView = weekView;

  final bool? _isLightTheme;
  final bool? _isLeftViewVisible;
  final WeekView? _weekView;

  bool get isLightTheme => _isLightTheme ?? Settings.isLightTheme;

  bool get isLeftViewVisible =>
      _isLeftViewVisible ?? Settings.isLeftViewVisible;

  WeekView get weekView => _weekView ?? Settings.weekView.fromString;

  bool get isWorkWeek => weekView == WeekView.workWeek;

  SettingsState copyWith({
    bool? isLightTheme,
    bool? isLeftViewVisible,
    WeekView? weekView,
  }) =>
      SettingsState(
        isLightTheme: isLightTheme ?? this.isLightTheme,
        isLeftViewVisible: isLeftViewVisible ?? this.isLeftViewVisible,
        weekView: weekView ?? this.weekView,
      );

  @override
  List<Object?> get props => [
        isLightTheme,
        isLeftViewVisible,
        weekView,
      ];
}
