import 'package:redux_epics/redux_epics.dart';
import 'package:sparta/_states.dart';
import 'package:sparta/pages/_shared/network/events_http_client.dart';
import 'package:sparta/states/events_state.dart';

class TypedAppEpic<Action> extends TypedEpic<AppState, Action> {
  TypedAppEpic(
    Stream<dynamic> Function(
      Stream<Action> actions,
      EpicStore<AppState> store,
    )
        epic,
  ) : super((actions, store) => epic(actions, store));
}

Epic<AppState> appEpics() {
  return combineEpics<AppState>([
    fetchEventsEpic(EventsHttpClient()),
  ]);
}
