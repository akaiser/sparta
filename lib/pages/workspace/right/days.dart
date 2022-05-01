import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/grid.dart';
import 'package:sparta/pages/workspace/right/days/day.dart';
import 'package:sparta/states/events_state.dart';

class Days extends StatelessWidget {
  const Days({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return ValueConnector<_State>(
      ignoreChange: (state) => state.eventsState.isLoading,
      onInit: (_) => context.dispatch(
        const FetchEventsAction(EventsActionType.init),
      ),
      converter: (state) {
        final eventsState = state.eventsState;
        return _State(
          isWorkWeek: state.settingsState.isWorkWeek,
          lastDayOfMonth: eventsState.refDate.startOfWeek.lastDayOfMonth.day,
          shownEvents: eventsState.shownEvents,
        );
      },
      builder: (context, state) {
        final dates = state.shownEvents.keys;
        final isWorkWeek = state.isWorkWeek;
        final lastDayOfMonth = state.lastDayOfMonth;

        return Grid(
          columnCount: isWorkWeek ? 5 : 7,
          rowCount: 2,
          cellPadding: 0.1,
          gridBackgroundColor: gridBackgroundColor,
          cellBuilder: (context, xIndex, yIndex) {
            final cellIndex = xIndex + yIndex * 7;
            final date = dates.elementAt(cellIndex);
            final printMonth = date.day == 1 ||
                date.day == lastDayOfMonth ||
                cellIndex == 0 ||
                (!isWorkWeek && cellIndex == 13) ||
                (isWorkWeek && cellIndex == 11);

            return Day(
              now: now,
              date: date,
              printMonth: printMonth,
              events: state.shownEvents[date]!,
            );
          },
        );
      },
    );
  }
}

class _State extends Equatable {
  const _State({
    required this.isWorkWeek,
    required this.lastDayOfMonth,
    required this.shownEvents,
  });

  final bool isWorkWeek;
  final int lastDayOfMonth;
  final Map<DateTime, Iterable<EventModel>> shownEvents;

  @override
  List<Object?> get props => [
        isWorkWeek,
        lastDayOfMonth,
        shownEvents,
      ];
}
