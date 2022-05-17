import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';

extension EventsExt on Map<DateTime, Iterable<EventModel>> {
  Map<DateTime, Iterable<EventModel>> toShownEvents(DateTime refDate) {
    final filtered = <DateTime, Iterable<EventModel>>{};
    for (var i = 0; i < 14; i++) {
      final day = refDate.startOfWeek.add(Duration(days: i));
      final singleWhere = entries.singleWhere(
        (entry) => entry.key.isSameDay(day),
        orElse: () => MapEntry(day, const []),
      );
      filtered[singleWhere.key] = singleWhere.value;
    }
    return filtered;
  }
}
