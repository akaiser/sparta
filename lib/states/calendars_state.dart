import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/pages/_shared/models/calendar_model.dart';
import 'package:sparta/pages/_shared/network/calendars_http_client.dart';
import 'package:sparta/pages/_shared/util/try_and_catch.dart';

abstract class _CalendarsAction extends Equatable {
  const _CalendarsAction();

  @override
  List<Object?> get props => [];
}

class FetchCalendarsAction extends _CalendarsAction {
  const FetchCalendarsAction();
}

class ResultFetchCalendarsAction extends _CalendarsAction {
  const ResultFetchCalendarsAction(this.calendars);

  final Iterable<CalendarModel> calendars;

  @override
  List<Object?> get props => [calendars];
}

class ErrorFetchCalendarsAction extends _CalendarsAction {
  const ErrorFetchCalendarsAction(this.exception);

  final Exception exception;

  @override
  List<Object?> get props => [exception];
}

TypedAppEpic<FetchCalendarsAction> fetchCalendarsEpic(
  CalendarsHttpClient http,
) =>
    TypedAppEpic<FetchCalendarsAction>(
      (actions, _) => actions
          //.where((_) => store.states.calendarsState.isLoading)
          .asyncMap<_CalendarsAction>(
        (_) => tryAndCatch(
          () => http
              .fetchCalendars()
              .then((json) => json.map(CalendarModel.fromJson))
              .then(ResultFetchCalendarsAction.new),
          ErrorFetchCalendarsAction.new,
        ),
      ),
    );

CalendarsState calendarsStateReducer(
  CalendarsState old,
  dynamic action,
) {
  if (action is _CalendarsAction) {
    if (action is FetchCalendarsAction) {
      return const CalendarsState(isLoading: true);
    } else if (action is ResultFetchCalendarsAction) {
      return CalendarsState(calendars: action.calendars);
    } else if (action is ErrorFetchCalendarsAction) {
      // TODO(albert): handle errors in views
      return CalendarsState(exception: action.exception);
    }
  }
  return old;
}

class CalendarsState extends Equatable {
  const CalendarsState({
    this.calendars = const [],
    this.exception,
    this.isLoading = false,
  });

  final Iterable<CalendarModel> calendars;
  final Exception? exception;
  final bool isLoading;

  @override
  List<Object?> get props => [
        calendars,
        exception,
        isLoading,
      ];
}
