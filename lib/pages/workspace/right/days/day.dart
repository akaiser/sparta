import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/day_event_model.dart';
import 'package:sparta/pages/workspace/right/days/day_body.dart';
import 'package:sparta/states/focussed_day_state.dart';

class Day extends StatelessWidget {
  const Day({
    required this.date,
    required this.dayEvents,
    required this.dayHeader,
    super.key,
  });

  final DateTime date;
  final Iterable<DayEventModel> dayEvents;
  final Widget dayHeader;

  void _onNotFocussedDayTap(BuildContext context) {
    if (!date.isSameDay(context.store.state.focussedDayState.focusedDate)) {
      context.store.dispatch(FocusDayAction(date));
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _onNotFocussedDayTap(context),
        onSecondaryTap: () {
          _onNotFocussedDayTap(context);
          // TODO(albert): open right click menu(create event)
        },
        child: Column(
          children: [
            dayHeader,
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
                  dayEvents: dayEvents,
                  onNotFocussedDayTap: _onNotFocussedDayTap,
                ),
              ),
            ),
          ],
        ),
      );
}
