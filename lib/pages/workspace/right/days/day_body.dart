import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/workspace/right/days/event.dart';

class DayBody extends StatelessWidget {
  const DayBody(
    this.listId, {
    required this.events,
    required this.onNotFocussedDateTap,
    Key? key,
  }) : super(key: key);

  final int listId;
  final Iterable<EventModel> events;
  final ValueSetter<BuildContext> onNotFocussedDateTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey(listId),
      controller: ScrollController(),
      padding: const EdgeInsets.fromLTRB(1, 1, 2, 0),
      itemCount: events.length,
      itemBuilder: (_, index) => Event(
        events.elementAt(index),
        onNotFocussedDateTap: onNotFocussedDateTap,
      ),
    );
  }
}
