import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/day_event_model.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/simple_grid.dart';
import 'package:sparta/pages/workspace/right/days/day.dart';
import 'package:sparta/pages/workspace/right/days/day_header.dart';

class Days extends StatelessWidget {
  const Days({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return ValueConnector<_State>(
      ignoreChange: (state) => state.dayEventsState.isLoading,
      converter: (state) {
        final dayEventsState = state.dayEventsState;
        return _State(
          isWorkWeek: state.settingsState.isWorkWeek,
          lastDayOfMonth: dayEventsState.refDate.startOfWeek.lastDayOfMonth.day,
          shownDayEvents: dayEventsState.shownDayEvents,
        );
      },
      builder: (context, state, _) {
        final shownDayEvents = state.shownDayEvents;
        final dates = shownDayEvents.keys;
        final isWorkWeek = state.isWorkWeek;

        return SimpleGrid(
          columnCount: isWorkWeek ? 5 : 7,
          rowCount: 2,
          cellBuilder: (context, xIndex, yIndex) {
            final cellIndex = xIndex + yIndex * 7;
            final date = dates.elementAt(cellIndex);
            final printWeekNumber = cellIndex == 0 || cellIndex == 7;
            final printMonth = date.day == 1 ||
                date.day == state.lastDayOfMonth ||
                cellIndex == 0 ||
                (isWorkWeek && cellIndex == 11) ||
                (!isWorkWeek && cellIndex == 13);

            final dayEvents = shownDayEvents[date]!;
            return Day(
              date: date,
              dayEvents: dayEvents,
              dayHeader: SizedBox(
                height: dayEventHeight,
                child: DayHeader(
                  date,
                  isCurrentDay: date.isSameDay(now),
                  printWeekNumber: printWeekNumber,
                  printMonth: printMonth,
                  dayEvents: dayEvents,
                ),
              ),
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
    required this.shownDayEvents,
  });

  final bool isWorkWeek;
  final int lastDayOfMonth;
  final Map<DateTime, Iterable<DayEventModel>> shownDayEvents;

  @override
  List<Object?> get props => [
        isWorkWeek,
        lastDayOfMonth,
        shownDayEvents,
      ];
}
