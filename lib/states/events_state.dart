import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/_shared/network/events_http_client.dart';
import 'package:sparta/pages/_shared/util/try_and_catch.dart';
import 'package:sparta/states/events_ref_date_ex.dart';

enum EventsFetchType {
  init,
  nextWeek,
  previousWeek,
}

abstract class _EventsAction extends Equatable {
  const _EventsAction();

  @override
  bool? get stringify => true;
}

class FetchEventsAction extends _EventsAction {
  const FetchEventsAction(this.fetchType);

  final EventsFetchType fetchType;

  @override
  List<Object?> get props => [fetchType];
}

class ResultFetchEventsAction extends _EventsAction {
  const ResultFetchEventsAction(this.data);

  final Map<DateTime, List<EventModel>> data;

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
  EventsFetchType fetchType,
  Map<DateTime, List<EventModel>> data,
) {
  if (refDate != null) {
    final fetchStartDate = refDate.toFetchStartDate(fetchType).midDay;
    final fetchEndDate = refDate.toFetchEndDate(fetchType).midDay;
    if (data[fetchStartDate] != null && data[fetchEndDate] != null) {
      return false;
    }
  }
  return true;
}

EventsState eventsStateReducer(EventsState old, dynamic action) {
  if (action is _EventsAction) {
    if (action is FetchEventsAction) {
      final newRefDate = old.refDate.toNewRefDate(action.fetchType)?.midDay;
      return EventsState(
        refDate: newRefDate,
        data: old.data,
        isLoading: _shouldLoadAndFetch(newRefDate, action.fetchType, old.data),
      );
    } else if (action is ResultFetchEventsAction) {
      return EventsState(
        refDate: old.refDate,
        data: {...old.data, ...action.data},
      );
    } else if (action is ErrorFetchEventsAction) {
      // TODO handle errors in views
      return EventsState(refDate: old.refDate, exception: action.exception);
    }
  }
  return old;
}

TypedAppEpic<FetchEventsAction> fetchEventsEpic(EventsHttpClient http) {
  return TypedAppEpic<FetchEventsAction>(
    (actions, store) => actions
        .where((_) => store.state.eventsState.isLoading)
        .map((action) => action.fetchType)
        .asyncMap(
          (fetchType) => tryAndCatch(
            () async {
              final refDate = store.state.eventsState.refDate;
              final eventsJson = await http.fetchEvents(
                from: refDate.toFetchStartDate(fetchType),
                to: refDate.toFetchEndDate(fetchType),
              );
              final eventsModel = {
                for (final events in eventsJson)
                  events.day.midDay: events.items
                      .map((event) => EventModel.fromJson(event))
                      .toList(growable: false),
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
    this.data = const {},
    this.exception,
    this.isLoading = false,
  }) : _refDate = refDate;

  final DateTime? _refDate;
  final Map<DateTime, List<EventModel>> data;
  final Exception? exception;
  final bool isLoading;

  DateTime get refDate => (_refDate ?? DateTime.now()).midDay;

  @override
  List<Object?> get props => [
        refDate,
        data,
        exception,
        isLoading,
      ];
}
