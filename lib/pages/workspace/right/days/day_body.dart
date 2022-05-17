import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/workspace/right/days/event.dart';

class DayBody extends StatelessWidget {
  const DayBody(
    this.listId,
    this.events, {
    Key? key,
  }) : super(key: key);

  final String listId;
  final Iterable<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: PageStorageKey(listId),
      controller: ScrollController(),
      padding: const EdgeInsets.all(2),
      itemCount: events.length,
      itemBuilder: (_, index) => Event(events.elementAt(index)),
      separatorBuilder: (_, __) => const SizedBox(height: 2),
    );
  }
}
