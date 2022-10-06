import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';
import 'package:sparta/pages/_shared/models/calendar_model.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/colored_dot.dart';
import 'package:sparta/pages/_shared/ui/loading_spinner.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile_item.dart';
import 'package:sparta/states/calendars_state.dart';

class Calendars extends StatelessWidget {
  const Calendars({super.key});

  @override
  Widget build(BuildContext context) => ValueConnector<CalendarsState>(
        converter: (state) => state.calendarsState,
        builder: (_, calendarsState, __) => calendarsState.isLoading
            ? const _Loading()
            : _Loaded(calendarsState.calendars),
      );
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        child: ExpandableTile(
          Row(
            children: [
              Text(context.l10n.calendars),
              const Spacer(),
              const LoadingSpinner(),
            ],
          ),
        ),
      );
}

class _Loaded extends StatelessWidget {
  const _Loaded(this.calendars);

  final Iterable<CalendarModel> calendars;

  @override
  Widget build(BuildContext context) => ExpandableTile(
        Text(context.l10n.calendars),
        // TODO(albert): this will come from local prefs/settings
        initiallyExpanded: true,
        children: calendars
            .map(
              (calendar) => ExpandableTileItem(
                calendar.title,
                leading: ColoredDot(calendar.color),
              ),
            )
            .unmodifiable,
      );
}
