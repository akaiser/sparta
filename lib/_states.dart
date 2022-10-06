import 'package:equatable/equatable.dart';
import 'package:sparta/states/calendars_state.dart';
import 'package:sparta/states/categories_state.dart';
import 'package:sparta/states/day_events_state.dart';
import 'package:sparta/states/focussed_day_event_state.dart';
import 'package:sparta/states/focussed_day_state.dart';
import 'package:sparta/states/settings_state.dart';

AppState appStateReducer(AppState state, dynamic action) => AppState(
      calendarsState: calendarsStateReducer(state.calendarsState, action),
      categoriesState: categoriesStateReducer(state.categoriesState, action),
      dayEventsState: dayEventsStateReducer(state.dayEventsState, action),
      focussedDayState: focussedDayStateReducer(
        state.focussedDayState,
        action,
      ),
      focussedDayEventState: focussedEventStateReducer(
        state.focussedDayEventState,
        action,
      ),
      settingsState: settingsStateReducer(state.settingsState, action),
    );

class AppState extends Equatable {
  const AppState({
    this.calendarsState = const CalendarsState(),
    this.categoriesState = const CategoriesState(),
    this.dayEventsState = const DayEventsState(),
    this.focussedDayState = const FocussedDayState(),
    this.focussedDayEventState = const FocussedDayEventState(),
    this.settingsState = const SettingsState(),
  });

  final CalendarsState calendarsState;
  final CategoriesState categoriesState;
  final DayEventsState dayEventsState;
  final FocussedDayState focussedDayState;
  final FocussedDayEventState focussedDayEventState;
  final SettingsState settingsState;

  @override
  List<Object?> get props => [
        calendarsState,
        categoriesState,
        dayEventsState,
        focussedDayState,
        focussedDayEventState,
        settingsState,
      ];
}
