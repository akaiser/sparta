import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/states/events_state.dart';

extension EventsRefDateEx on DateTime {
  DateTime? toNewRefDate(EventsActionType actionType) {
    switch (actionType) {
      case EventsActionType.init:
        return null;
      case EventsActionType.picker:
        return this;
      case EventsActionType.nextWeek:
        return addWeek;
      case EventsActionType.previousWeek:
        return subtractWeek;
    }
  }

  DateTime toFetchStartDate(EventsActionType actionType) {
    switch (actionType) {
      case EventsActionType.init:
      case EventsActionType.picker:
      case EventsActionType.previousWeek:
        return startOfWeek;
      case EventsActionType.nextWeek:
        return addWeek.startOfWeek;
    }
  }

  DateTime toFetchEndDate(EventsActionType actionType) {
    switch (actionType) {
      case EventsActionType.init:
      case EventsActionType.picker:
        return startOfWeek.add(const Duration(days: 13));
      case EventsActionType.nextWeek:
        return addWeek.endOfWeek;
      case EventsActionType.previousWeek:
        return endOfWeek;
    }
  }
}
