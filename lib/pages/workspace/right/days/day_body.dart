import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/workspace/right/days/event.dart';

class DayBody extends StatelessWidget {
  const DayBody(
    this.listId, {
    required this.events,
    required this.onNotFocussedDateTap,
    super.key,
  });

  final int listId;
  final Iterable<EventModel> events;
  final ValueSetter<BuildContext> onNotFocussedDateTap;

  @override
  Widget build(BuildContext context) => ListView.builder(
        key: PageStorageKey(listId),
        controller: ScrollController(),
        padding: const EdgeInsets.only(left: 1, top: 1, right: 2),
        itemCount: events.length,
        itemBuilder: (_, index) => Event(
          events.elementAt(index),
          onNotFocussedDateTap: onNotFocussedDateTap,
        ),
      );
}
