import 'package:equatable/equatable.dart';
import 'package:sparta/states/events_state.dart';
import 'package:sparta/states/focussed_date_state.dart';
import 'package:sparta/states/focussed_event_state.dart';
import 'package:sparta/states/settings_state.dart';

AppState appStateReducer(AppState state, dynamic action) => AppState(
      eventsState: eventsStateReducer(state.eventsState, action),
      focussedDateState: focussedDateStateReducer(
        state.focussedDateState,
        action,
      ),
      focussedEventState: focussedEventStateReducer(
        state.focussedEventState,
        action,
      ),
      settingsState: settingsStateReducer(state.settingsState, action),
    );

class AppState extends Equatable {
  const AppState({
    this.eventsState = const EventsState(),
    this.focussedDateState = const FocussedDateState(),
    this.focussedEventState = const FocussedEventState(),
    this.settingsState = const SettingsState(),
  });

  final EventsState eventsState;
  final FocussedDateState focussedDateState;
  final FocussedEventState focussedEventState;
  final SettingsState settingsState;

  @override
  List<Object?> get props => [
        eventsState,
        focussedDateState,
        focussedEventState,
        settingsState,
      ];
}
