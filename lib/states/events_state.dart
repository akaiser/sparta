import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_json.dart';
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
}

class FetchEventsAction extends _EventsAction {
  const FetchEventsAction(
    this.actionType, {
    this.overriddenRefDate,
  });

  final EventsActionType actionType;
  final DateTime? overriddenRefDate;

  @override
  List<Object?> get props => [actionType, overriddenRefDate];
}

class ResultFetchEventsAction extends _EventsAction {
  const ResultFetchEventsAction(this.events);

  final Map<DateTime, Iterable<EventModel>> events;

  @override
  List<Object?> get props => [events];
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
  Map<DateTime, Iterable<EventModel>> events,
) {
  if (refDate != null) {
    final startDate = refDate.toFetchStartDate(actionType).midDay;
    final endDate = refDate.toFetchEndDate(actionType).midDay;
    if (events[startDate] != null && events[endDate] != null) {
      return false;
    }
  }
  return true;
}

EventsState eventsStateReducer(EventsState old, dynamic action) {
  if (action is _EventsAction) {
    if (action is FetchEventsAction) {
      final actionType = action.actionType;
      final newRefDate = action.overriddenRefDate ??
          old.refDate.toNewRefDate(actionType)?.midDay;

      return EventsState(
        refDate: newRefDate,
        events: old.events,
        isLoading: _shouldLoadAndFetch(newRefDate, actionType, old.events),
      );
    } else if (action is ResultFetchEventsAction) {
      return EventsState(
        refDate: old.refDate,
        events: {...old.events, ...action.events},
      );
    } else if (action is ErrorFetchEventsAction) {
      // TODO(albert): handle errors in views
      return EventsState(
        refDate: old.refDate,
        exception: action.exception,
      );
    }
  }
  return old;
}

TypedAppEpic<FetchEventsAction> fetchEventsEpic(EventsHttpClient http) =>
    TypedAppEpic<FetchEventsAction>(
      (actions, store) => actions
          .where((_) => store.state.eventsState.isLoading)
          .map((action) => action.actionType)
          .asyncMap<_EventsAction>(
            (actionType) => tryAndCatch(
              () async {
                final refDate = store.state.eventsState.refDate;
                final json = await http.fetchEvents(
                  from: refDate.toFetchStartDate(actionType),
                  to: refDate.toFetchEndDate(actionType),
                );

                final model = {
                  for (final EventsJson events in json)
                    events.day.midDay: events.items.map(EventModel.fromJson),
                };
                return ResultFetchEventsAction(model);
              },
              ErrorFetchEventsAction.new,
            ),
          ),
    );

class EventsState extends Equatable {
  const EventsState({
    DateTime? refDate,
    this.events = const {},
    this.exception,
    this.isLoading = false,
  }) : _refDate = refDate;

  final DateTime? _refDate;
  final Map<DateTime, Iterable<EventModel>> events;
  final Exception? exception;
  final bool isLoading;

  DateTime get refDate => (_refDate ?? DateTime.now()).midDay;

  @override
  List<Object?> get props => [
        refDate,
        events,
        exception,
        isLoading,
      ];
}
