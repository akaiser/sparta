import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/base_icon_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/bar_items_separator.dart';
import 'package:sparta/pages/workspace/right/top_bar/toggle_left_view_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/toggle_theme_mode_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/user_menu.dart';
import 'package:sparta/pages/workspace/right/top_bar/week_view_dropdown.dart';
import 'package:sparta/states/events_state.dart';

const _baseFetchDuration = Duration(days: 7);

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return ValueConnector<DateTime>(
      converter: (state) => state.eventsState.refDate,
      builder: (context, refDate) {
        void fetch(date) => context.dispatch(FetchEventsAction(date));
        return Row(
          children: [
            const ToggleLeftViewButton(),
            const BarItemsSeparator(),
            BaseIconButton(
              Icons.keyboard_arrow_up,
              onPressed: () => fetch(refDate.subtract(_baseFetchDuration)),
            ),
            const SizedBox(width: 4),
            BaseIconButton(
              Icons.fiber_manual_record_outlined,
              onPressed: refDate.isSameDay(now) ? null : () => fetch(now),
            ),
            const SizedBox(width: 4),
            BaseIconButton(
              Icons.keyboard_arrow_down,
              onPressed: () => fetch(refDate.add(_baseFetchDuration)),
            ),
            const Spacer(),
            const WeekViewDropdown(),
            const BarItemsSeparator(),
            const ToggleThemeModeButton(),
            const SizedBox(width: 8),
            const UserMenu(),
          ],
        );
      },
    );
  }
}
