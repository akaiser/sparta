import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/bar_items_separator.dart';
import 'package:sparta/pages/workspace/right/top_bar/shown_range_text.dart';
import 'package:sparta/pages/workspace/right/top_bar/toggle_left_view_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/toggle_theme_mode_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/user_menu.dart';
import 'package:sparta/pages/workspace/right/top_bar/week_view_dropdown.dart';
import 'package:sparta/states/events_state.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Row(
      children: [
        const ToggleLeftViewButton(),
        const BarItemsSeparator(),
        HoverIconButton(
          Icons.keyboard_arrow_up,
          onPressed: () => context
              .dispatch(const FetchEventsAction(EventsActionType.previousWeek)),
        ),
        const SizedBox(width: 4),
        ValueConnector<DateTime>(
          converter: (state) => state.eventsState.refDate,
          builder: (context, refDate) {
            return HoverIconButton(
              Icons.fiber_manual_record_outlined,
              onPressed: refDate.isSameDay(now)
                  ? null
                  : () => context
                      .dispatch(const FetchEventsAction(EventsActionType.init)),
            );
          },
        ),
        const SizedBox(width: 4),
        HoverIconButton(
          Icons.keyboard_arrow_down,
          onPressed: () => context
              .dispatch(const FetchEventsAction(EventsActionType.nextWeek)),
        ),
        const BarItemsSeparator(),
        const Expanded(child: ShownRangeText()),
        const WeekViewDropdown(),
        const BarItemsSeparator(),
        const ToggleThemeModeButton(),
        const SizedBox(width: 8),
        const UserMenu(),
      ],
    );
  }
}
