import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/pages/_shared/models/event_json.dart';
import 'package:sparta/pages/_shared/network/events_http_client.dart';
import 'package:sparta/pages/_shared/util/try_and_catch.dart';

abstract class _EventsAction extends Equatable {
  const _EventsAction();

  @override
  bool? get stringify => true;
}

class FetchEventsAction extends _EventsAction {
  const FetchEventsAction(this.refDate);

  final DateTime refDate;

  @override
  List<Object?> get props => [refDate];
}

class ResultFetchEventsAction extends _EventsAction {
  const ResultFetchEventsAction(this.data);

  final List<EventsJson> data;

  @override
  List<Object?> get props => [data];
}

class ErrorFetchEventsAction extends _EventsAction {
  const ErrorFetchEventsAction(this.exception);

  final Exception exception;

  @override
  List<Object?> get props => [exception];
}

EventsState eventsStateReducer(EventsState old, dynamic action) {
  if (action is _EventsAction) {
    if (action is FetchEventsAction) {
      return EventsState(isLoading: true, refDate: action.refDate);
    } else if (action is ResultFetchEventsAction) {
      return EventsState(refDate: old.refDate, data: action.data);
    } else if (action is ErrorFetchEventsAction) {
      return EventsState(refDate: old.refDate, exception: action.exception);
    }
  }
  return old;
}

TypedAppEpic<FetchEventsAction> fetchEventsEpic(EventsHttpClient http) {
  return TypedAppEpic<FetchEventsAction>(
    (actions, _) => actions.asyncMap(
      (action) => tryAndCatch(
        () => http.fetchEvents().then((data) => ResultFetchEventsAction(data)),
        (exception) => ErrorFetchEventsAction(exception),
      ),
    ),
  );
}

class EventsState extends Equatable {
  const EventsState({
    DateTime? refDate,
    this.data = const [],
    this.exception,
    this.isLoading = false,
  }) : _refDate = refDate;

  final DateTime? _refDate;
  final List<EventsJson> data;
  final Exception? exception;
  final bool isLoading;

  DateTime get refDate => _refDate ?? DateTime.now();

  @override
  List<Object?> get props => [
        refDate,
        data,
        exception,
        isLoading,
      ];
}
