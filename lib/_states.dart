import 'package:equatable/equatable.dart';
import 'package:sparta/states/events_state.dart';
import 'package:sparta/states/settings_state.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    eventsState: eventsStateReducer(state.eventsState, action),
    settingsState: settingsStateReducer(state.settingsState, action),
  );
}

class AppState extends Equatable {
  const AppState({
    this.eventsState = const EventsState(),
    this.settingsState = const SettingsState(),
  });

  final EventsState eventsState;
  final SettingsState settingsState;

  @override
  List<Object?> get props => [
        eventsState,
        settingsState,
      ];
}
