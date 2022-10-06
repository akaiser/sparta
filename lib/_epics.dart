import 'package:redux_epics/redux_epics.dart';
import 'package:sparta/_states.dart';
import 'package:sparta/pages/_shared/network/_http_client.dart';
import 'package:sparta/pages/_shared/network/calendars_http_client.dart';
import 'package:sparta/pages/_shared/network/categories_http_client.dart';
import 'package:sparta/pages/_shared/network/days_http_client.dart';
import 'package:sparta/states/_continuation_epic.dart';
import 'package:sparta/states/_logging_epic.dart';
import 'package:sparta/states/calendars_state.dart';
import 'package:sparta/states/categories_state.dart';
import 'package:sparta/states/day_events_state.dart';
import 'package:sparta/states/focussed_day_state.dart';
import 'package:sparta/states/workspace_epic.dart';

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
  const httpClient = HttpClient();
  return combineEpics<AppState>([
    // infra
    loggingEpic(),
    continuationEpic(),

    // init
    initWorkspaceEpic(),
    postFetchCalendarsEpic(),
    postFetchCategoriesEpic(),

    // main
    focusDayEpic(),
    fetchDaysEpic(const DaysHttpClient(httpClient)),
    fetchCalendarsEpic(const CalendarsHttpClient(httpClient)),
    fetchCategoriesEpic(const CategoriesHttpClient(httpClient)),
  ]);
}
