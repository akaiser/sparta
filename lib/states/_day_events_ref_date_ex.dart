import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/states/day_events_state.dart';

extension DayEventsRefDateEx on DateTime {
  DateTime? toNewRefDate(DayEventsActionType actionType) {
    switch (actionType) {
      case DayEventsActionType.init:
        return null;
      case DayEventsActionType.picker:
        return this;
      case DayEventsActionType.nextWeek:
        return addWeek;
      case DayEventsActionType.previousWeek:
        return subtractWeek;
    }
  }

  DateTime toFetchStartDate(DayEventsActionType actionType) {
    switch (actionType) {
      case DayEventsActionType.init:
      case DayEventsActionType.picker:
      case DayEventsActionType.previousWeek:
        return startOfWeek;
      case DayEventsActionType.nextWeek:
        return addWeek.startOfWeek;
    }
  }

  DateTime toFetchEndDate(DayEventsActionType actionType) {
    switch (actionType) {
      case DayEventsActionType.init:
      case DayEventsActionType.picker:
        return startOfWeek.add(const Duration(days: 13));
      case DayEventsActionType.nextWeek:
        return addWeek.endOfWeek;
      case DayEventsActionType.previousWeek:
        return endOfWeek;
    }
  }
}
