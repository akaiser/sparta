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
    return ValueConnector<_State>(
      onInit: (_) => context.dispatch(
        const FetchEventsAction(EventsActionType.init),
      ),
      converter: (state) {
        final startOfWeek = state.eventsState.refDate.startOfWeek;
        final filtered = _filteredEvents(startOfWeek, state.eventsState.data);
        return _State(
          startOfWeek,
          state.eventsState.focusedDate,
          Map.fromEntries(filtered),
        );
      },
      builder: (context, state) {
        final now = DateTime.now();
        final dateFormat = DateFormat.MMMd(context.lc);

        final dates = state.events.keys;
        final lastDayOfMonth = state.startOfWeek.lastDayOfMonth.day;

        return ValueConnector<bool>(
          converter: (state) => state.settingsState.isWorkWeek,
          builder: (context, isWorkWeek) {
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
                        state.events[date]!,
                        isFocussedDay: date.isSameDay(state.focusedDate),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Iterable<MapEntry<DateTime, Iterable<EventModel>>> _filteredEvents(
    DateTime startOfWeek,
    Map<DateTime, Iterable<EventModel>> events,
  ) sync* {
    for (var i = 0; i < 14; i++) {
      final day = startOfWeek.add(Duration(days: i));
      yield events.entries.singleWhere(
        (entry) => entry.key.isSameDay(day),
        orElse: () => MapEntry(day, const []),
      );
    }
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
    required this.isFocussedDay,
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final bool isFocussedDay;
  final Iterable<EventModel> events;

  @override
  Widget build(BuildContext context) {
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
        color:
            isFocussedDay ? context.td.primaryColorLight : context.td.cardColor,
        child: ListView.builder(
          key: PageStorageKey(date.truncate),
          controller: ScrollController(),
          itemCount: events.length,
          itemBuilder: (_, index) => _Event(events.elementAt(index)),
        ),
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
  const _State(
    this.startOfWeek,
    this.focusedDate,
    this.events,
  );

  final DateTime startOfWeek;
  final DateTime? focusedDate;
  final Map<DateTime, Iterable<EventModel>> events;

  @override
  List<Object?> get props => [startOfWeek, focusedDate, events];
}
