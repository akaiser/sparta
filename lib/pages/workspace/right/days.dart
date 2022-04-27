import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/simple_grid_view.dart';
import 'package:sparta/states/events_state.dart';

class Days extends StatelessWidget {
  const Days({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat.MMMd(context.lc);

    return ValueConnector<_State>(
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

        return SimpleGridView(
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DayHeader(
                  '${printMonth ? dateFormat.format(date) : date.day}',
                  isCurrentDay: date.isSameDay(now),
                ),
                const SizedBox(height: 0.2),
                Expanded(
                  child: _DayBody(
                    date,
                    state.shownEvents[date]!,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader(
    this.text, {
    required this.isCurrentDay,
    Key? key,
  }) : super(key: key);

  final String text;
  final bool isCurrentDay;

  @override
  Widget build(BuildContext context) {
    final fontWeight = isCurrentDay ? FontWeight.bold : FontWeight.normal;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.td.highlightColor,
        border: isCurrentDay ? currentDayBorder : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          text,
          textAlign: TextAlign.end,
          style: context.tt.labelSmall.copyWith(fontWeight: fontWeight),
        ),
      ),
    );
  }
}

class _DayBody extends StatelessWidget {
  const _DayBody(
    this.date,
    this.events, {
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final Iterable<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return ValueConnector2<bool>(
      converter: (state) => date.isSameDay(state.eventsState.focusedDate),
      builder: (context, isFocussedDay, child) {
        return GestureDetector(
          onTap: isFocussedDay
              ? null
              : () {
                  context.dispatch(
                    FetchEventsAction(
                      EventsActionType.picker,
                      focusedDate: date,
                      shouldOverrideRefDate: false,
                    ),
                  );
                },
          child: ColoredBox(
            color: isFocussedDay
                ? context.td.primaryColorLight
                : context.td.cardColor,
            child: child!,
          ),
        );
      },
      child: ListView.builder(
        key: PageStorageKey(date.truncate),
        controller: ScrollController(),
        itemCount: events.length,
        itemBuilder: (_, index) => _Event(events.elementAt(index)),
      ),
    );
  }
}

class _Event extends StatelessWidget {
  const _Event(
    this.event, {
    Key? key,
  }) : super(key: key);

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${event.id}',
          style: context.tt.labelSmall,
        ),
      ],
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
