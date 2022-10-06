import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/models/day_event_model.dart';
import 'package:sparta/pages/workspace/right/days/day_event.dart';

class DayBody extends StatefulWidget {
  const DayBody(
    this.listId, {
    required this.dayEvents,
    required this.onNotFocussedDayTap,
    super.key,
  });

  final int listId;
  final Iterable<DayEventModel> dayEvents;
  final ValueSetter<BuildContext> onNotFocussedDayTap;

  @override
  State<DayBody> createState() => _DayBodyState();
}

class _DayBodyState extends State<DayBody> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
          key: PageStorageKey(widget.listId),
          controller: _scrollController,
          padding: const EdgeInsets.only(left: 2, top: 2, right: 3),
          itemCount: widget.dayEvents.length,
          itemBuilder: (context, index) {
            final dayEvent = widget.dayEvents.elementAt(index);
            return DayEvent(
              dayEvent,
              onNotFocussedDayTap: widget.onNotFocussedDayTap,
            );
          },
        ),
      );
}
