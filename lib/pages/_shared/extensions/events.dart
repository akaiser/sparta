import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';

extension EventsExt on Map<DateTime, Iterable<EventModel>> {
  bool shownEventsContainDate(DateTime refDate, DateTime date) =>
      toShownEvents(refDate).keys.contains(date);

  Map<DateTime, Iterable<EventModel>> toShownEvents(DateTime refDate) {
    final filtered = <DateTime, Iterable<EventModel>>{};
    for (var i = 0; i < 14; i++) {
      final day = refDate.startOfWeek.add(Duration(days: i));

      // TODO(albert): try with groupBy Ext
      final entry = entries.singleWhere(
        (it) => it.key.isSameDay(day),
        orElse: () => MapEntry(day, const []),
      );
      filtered[entry.key] = entry.value;
    }
    return filtered;
  }
}
