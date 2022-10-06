import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/states/calendars_state.dart';
import 'package:sparta/states/categories_state.dart';
import 'package:sparta/states/day_events_state.dart';

class InitWorkspaceAction extends Equatable {
  const InitWorkspaceAction();

  @override
  List<Object?> get props => [];
}

TypedAppEpic<InitWorkspaceAction> initWorkspaceEpic() =>
    TypedAppEpic<InitWorkspaceAction>(
      (actions, _) => actions.map((_) => const FetchCalendarsAction()),
    );

TypedAppEpic<ResultFetchCalendarsAction> postFetchCalendarsEpic() =>
    TypedAppEpic<ResultFetchCalendarsAction>(
      (actions, _) => actions.map((_) => const FetchCategoriesAction()),
    );

TypedAppEpic<ResultFetchCategoriesAction> postFetchCategoriesEpic() =>
    TypedAppEpic<ResultFetchCategoriesAction>(
      (actions, _) => actions
          .map((_) => const FetchDayEventsAction(DayEventsActionType.init)),
    );
