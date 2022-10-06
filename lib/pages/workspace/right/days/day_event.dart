import 'package:flutter/material.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/color.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';
import 'package:sparta/pages/_shared/models/day_event_model.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/bordered.dart';
import 'package:sparta/pages/_shared/ui/clickable_region.dart';
import 'package:sparta/pages/workspace/right/days/category_badge.dart';
import 'package:sparta/states/focussed_day_event_state.dart';

const _itemsSpacer = SizedBox(width: 2);

class DayEvent extends StatelessWidget {
  const DayEvent(
    this.dayEvent, {
    required this.onNotFocussedDayTap,
    super.key,
  });

  final DayEventModel dayEvent;
  final ValueSetter<BuildContext> onNotFocussedDayTap;

  void _onDayEventTap(BuildContext context) {
    onNotFocussedDayTap(context);
    context.store.dispatch(FocusDayEventAction(dayEvent.id));
  }

  @override
  Widget build(BuildContext context) {
    final eventColor = dayEvent.calendar.color;
    final eventTextStyle = context.tt.labelSmall?.copyWith(
      color: eventColor.visibleTextColor,
    );
    return Tooltip(
      message: 'Hello \nWorld!\n\nbla',
      waitDuration: const Duration(milliseconds: 700),
      child: ClickableRegion(
        child: ValueConnector<bool>(
          converter: (state) =>
              state.focussedDayEventState.dayEventId == dayEvent.id,
          builder: (context, isFocussed, child) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: isFocussed ? null : () => _onDayEventTap(context),
            onSecondaryTap: () {
              _onDayEventTap(context);
              // TODO(albert): open right click menu(edit, delete, copy)
            },
            child: child != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Bordered(
                      isFocussed ? eventColor.withOpacity(0.6) : eventColor,
                      child: child,
                    ),
                  )
                : null,
          ),
          child: SizedBox(
            height: dayEventHeight,
            child: Row(
              children: [
                _itemsSpacer,
                Expanded(
                  child: Text(
                    dayEvent.id,
                    style: eventTextStyle,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
                _itemsSpacer,
                if (dayEvent.categories.isNotEmpty) ...[
                  ...dayEvent.categories
                      .map<Widget>((category) => CategoryBadge(category.color))
                      .separate(_itemsSpacer),
                  const SizedBox(width: 4),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
