import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/extensions/events.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/simple_grid.dart';
import 'package:sparta/pages/workspace/right/days/day.dart';
import 'package:sparta/states/events_state.dart';

class Days extends StatelessWidget {
  const Days({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return ValueConnector<_State>(
      ignoreChange: (state) => state.eventsState.isLoading,
      onInit: (_) => context.store.dispatch(
        const FetchEventsAction(EventsActionType.init),
      ),
      converter: (state) {
        final eventsState = state.eventsState;
        return _State(
          refDate: eventsState.refDate,
          isWorkWeek: state.settingsState.isWorkWeek,
          lastDayOfMonth: eventsState.refDate.startOfWeek.lastDayOfMonth.day,
          events: eventsState.events,
        );
      },
      builder: (context, state, _) {
        final shownEvents = state.events.toShownEvents(state.refDate);
        final dates = shownEvents.keys;
        final isWorkWeek = state.isWorkWeek;
        final lastDayOfMonth = state.lastDayOfMonth;

        return SimpleGrid(
          columnCount: isWorkWeek ? 5 : 7,
          rowCount: 2,
          cellBuilder: (context, xIndex, yIndex) {
            final cellIndex = xIndex + yIndex * 7;
            final date = dates.elementAt(cellIndex);
            final printWeekNumber = cellIndex == 0 || cellIndex == 7;
            final printMonth = date.day == 1 ||
                date.day == lastDayOfMonth ||
                cellIndex == 0 ||
                (isWorkWeek && cellIndex == 11) ||
                (!isWorkWeek && cellIndex == 13);

            return Day(
              now: now,
              date: date,
              printMonth: printMonth,
              printWeekNumber: printWeekNumber,
              events: shownEvents[date]!,
            );
          },
        );
      },
    );
  }
}

class _State extends Equatable {
  const _State({
    required this.refDate,
    required this.isWorkWeek,
    required this.lastDayOfMonth,
    required this.events,
  });

  final DateTime refDate;
  final bool isWorkWeek;
  final int lastDayOfMonth;
  final Map<DateTime, Iterable<EventModel>> events;

  @override
  List<Object?> get props => [
        refDate,
        isWorkWeek,
        lastDayOfMonth,
        events,
      ];
}
