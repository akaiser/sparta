import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/bar_items_separator.dart';
import 'package:sparta/pages/workspace/right/top_bar/circle_action_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/shown_range_text.dart';
import 'package:sparta/pages/workspace/right/top_bar/toggle_left_view_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/toggle_theme_mode_button.dart';
import 'package:sparta/pages/workspace/right/top_bar/user_menu.dart';
import 'package:sparta/pages/workspace/right/top_bar/week_view_dropdown.dart';
import 'package:sparta/states/events_state.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        ToggleLeftViewButton(),
        BarItemsSeparator(),
        _ArrowActionButton(
          Icons.keyboard_arrow_up,
          EventsActionType.previousWeek,
        ),
        SizedBox(width: 4),
        CircleActionButton(),
        SizedBox(width: 4),
        _ArrowActionButton(
          Icons.keyboard_arrow_down,
          EventsActionType.nextWeek,
        ),
        BarItemsSeparator(),
        Expanded(child: ShownRangeText()),
        WeekViewDropdown(),
        BarItemsSeparator(),
        ToggleThemeModeButton(),
        SizedBox(width: 8),
        UserMenu(),
      ],
    );
  }
}

class _ArrowActionButton extends StatelessWidget {
  const _ArrowActionButton(this.icon, this.actionType);

  final IconData icon;
  final EventsActionType actionType;

  @override
  Widget build(BuildContext context) {
    return HoverIconButton(
      icon,
      onPressed: () => context.store.dispatch(FetchEventsAction(actionType)),
    );
  }
}
