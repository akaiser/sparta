import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/workspace/right/days/day_body.dart';
import 'package:sparta/pages/workspace/right/days/day_header.dart';
import 'package:sparta/states/focussed_date_state.dart';

class Day extends StatelessWidget {
  const Day({
    required this.now,
    required this.date,
    required this.printMonth,
    required this.printWeekNumber,
    required this.events,
    super.key,
  });

  final DateTime now;
  final DateTime date;
  final bool printMonth;
  final bool printWeekNumber;
  final Iterable<EventModel> events;

  void _onNotFocussedDateTap(BuildContext context) {
    if (!date.isSameDay(context.store.state.focussedDateState.focusedDate)) {
      context.store.dispatch(FocusDateAction(date));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onNotFocussedDateTap(context),
      onSecondaryTap: () {
        _onNotFocussedDateTap(context);
        // TODO(albert): open right click menu(create event)
      },
      child: Column(
        children: [
          GestureDetector(
            child: DayHeader(
              date,
              printMonth: printMonth,
              printWeekNumber: printWeekNumber,
              isCurrentDay: date.isSameDay(now),
            ),
          ),
          verticalDivider,
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: context.td.dividerColor),
                ),
              ),
              child: DayBody(
                date.truncate.millisecondsSinceEpoch,
                events: events,
                onNotFocussedDateTap: _onNotFocussedDateTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
