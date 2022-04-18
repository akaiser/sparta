import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/states/events_state.dart';

extension EventsRefDateEx on DateTime {
  DateTime? toNewRefDate(EventsFetchType fetchType) {
    switch (fetchType) {
      case EventsFetchType.init:
        return null;
      case EventsFetchType.nextWeek:
        return addWeek;
      case EventsFetchType.previousWeek:
        return subtractWeek;
    }
  }

  DateTime toFetchStartDate(EventsFetchType fetchType) {
    switch (fetchType) {
      case EventsFetchType.init:
      case EventsFetchType.previousWeek:
        return startOfWeek;
      case EventsFetchType.nextWeek:
        return addWeek.startOfWeek;
    }
  }

  DateTime toFetchEndDate(EventsFetchType fetchType) {
    switch (fetchType) {
      case EventsFetchType.init:
        return startOfWeek.add(const Duration(days: 13));
      case EventsFetchType.nextWeek:
        return addWeek.endOfWeek;
      case EventsFetchType.previousWeek:
        return endOfWeek;
    }
  }
}
