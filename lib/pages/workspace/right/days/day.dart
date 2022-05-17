import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparta/_states.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/workspace/right/days/day_body.dart';
import 'package:sparta/pages/workspace/right/days/day_header.dart';
import 'package:sparta/states/events_state.dart';

class Day extends StatelessWidget {
  const Day({
    required this.now,
    required this.date,
    required this.printMonth,
    required this.printWeekNumber,
    required this.events,
    Key? key,
  }) : super(key: key);

  final DateTime now;
  final DateTime date;
  final bool printMonth;
  final bool printWeekNumber;
  final Iterable<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final store = StoreProvider.of<AppState>(
          context,
          listen: false,
        );
        if (!date.isSameDay(store.state.eventsState.focusedDate)) {
          store.dispatch(
            FetchEventsAction(
              EventsActionType.picker,
              focusedDate: date,
              shouldOverrideRefDate: false,
            ),
          );
        }
      },
      child: Column(
        children: [
          DayHeader(
            date,
            printMonth: printMonth,
            printWeekNumber: printWeekNumber,
            isCurrentDay: date.isSameDay(now),
          ),
          verticalDivider,
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: context.td.dividerColor),
                ),
              ),
              child: DayBody(date.truncate.toString(), events),
            ),
          ),
        ],
      ),
    );
  }
}
