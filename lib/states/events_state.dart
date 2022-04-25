import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/_shared/network/events_http_client.dart';
import 'package:sparta/pages/_shared/util/try_and_catch.dart';
import 'package:sparta/states/events_ref_date_ex.dart';

enum EventsActionType {
  init,
  picker,
  nextWeek,
  previousWeek,
}

abstract class _EventsAction extends Equatable {
  const _EventsAction();

  @override
  bool? get stringify => true;
}

class FetchEventsAction extends _EventsAction {
  const FetchEventsAction(
    this.actionType, {
    this.focusedDate,
    this.shouldOverrideRefDate = true,
  });

  final EventsActionType actionType;
  final DateTime? focusedDate;
  final bool shouldOverrideRefDate;

  @override
  List<Object?> get props => [actionType, focusedDate, shouldOverrideRefDate];
}

class ResultFetchEventsAction extends _EventsAction {
  const ResultFetchEventsAction(this.data);

  final Map<DateTime, Iterable<EventModel>> data;

  @override
  List<Object?> get props => [data];
}

class ErrorFetchEventsAction extends _EventsAction {
  const ErrorFetchEventsAction(this.exception);

  final Exception exception;

  @override
  List<Object?> get props => [exception];
}

bool _shouldLoadAndFetch(
  DateTime? refDate,
  EventsActionType actionType,
  Map<DateTime, Iterable<EventModel>> data,
) {
  if (refDate != null) {
    final fetchStartDate = refDate.toFetchStartDate(actionType).midDay;
    final fetchEndDate = refDate.toFetchEndDate(actionType).midDay;
    if (data[fetchStartDate] != null && data[fetchEndDate] != null) {
      return false;
    }
  }
  return true;
}

EventsState eventsStateReducer(EventsState old, dynamic action) {
  if (action is _EventsAction) {
    if (action is FetchEventsAction) {
      final newRefDate =
          (action.shouldOverrideRefDate ? action.focusedDate : null) ??
              old.refDate.toNewRefDate(action.actionType)?.midDay;

      final focusedDate = action.actionType != EventsActionType.init
          ? action.focusedDate ?? old.focusedDate
          : null;

      return EventsState(
        refDate: newRefDate,
        focusedDate: focusedDate,
        data: old.data,
        isLoading: _shouldLoadAndFetch(newRefDate, action.actionType, old.data),
      );
    } else if (action is ResultFetchEventsAction) {
      return EventsState(
        refDate: old.refDate,
        focusedDate: old.focusedDate,
        data: {...old.data, ...action.data},
      );
    } else if (action is ErrorFetchEventsAction) {
      // TODO handle errors in views
      return EventsState(
        refDate: old.refDate,
        focusedDate: old.focusedDate,
        exception: action.exception,
      );
    }
  }
  return old;
}

TypedAppEpic<FetchEventsAction> fetchEventsEpic(EventsHttpClient http) {
  return TypedAppEpic<FetchEventsAction>(
    (actions, store) => actions
        .where((_) => store.state.eventsState.isLoading)
        .map((action) => action.actionType)
        .asyncMap(
          (actionType) => tryAndCatch(
            () async {
              final refDate = store.state.eventsState.refDate;
              final eventsJson = await http.fetchEvents(
                from: refDate.toFetchStartDate(actionType),
                to: refDate.toFetchEndDate(actionType),
              );

              final eventsModel = {
                for (final events in eventsJson)
                  events.day.midDay: events.items.map(EventModel.fromJson),
              };
              return ResultFetchEventsAction(eventsModel);
            },
            (exception) => ErrorFetchEventsAction(exception),
          ),
        ),
  );
}

class EventsState extends Equatable {
  const EventsState({
    DateTime? refDate,
    this.focusedDate,
    this.data = const {},
    this.exception,
    this.isLoading = false,
  }) : _refDate = refDate;

  final DateTime? _refDate;
  final DateTime? focusedDate;
  final Map<DateTime, Iterable<EventModel>> data;
  final Exception? exception;
  final bool isLoading;

  DateTime get refDate => (_refDate ?? DateTime.now()).midDay;

  @override
  List<Object?> get props => [
        refDate,
        focusedDate,
        data,
        exception,
        isLoading,
      ];
}
