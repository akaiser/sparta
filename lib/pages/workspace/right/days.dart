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

class Days extends StatefulWidget {
  const Days({Key? key}) : super(key: key);

  @override
  State<Days> createState() => _DaysState();
}

class _DaysState extends State<Days> {
  late ValueNotifier<DateTime?> _focusedDateNotifier;

  @override
  void initState() {
    super.initState();
    _focusedDateNotifier = ValueNotifier(null);
  }

  @override
  void dispose() {
    _focusedDateNotifier.dispose();
    super.dispose();
  }

  Iterable<MapEntry<DateTime, List<EventModel>>> _filterEvents(
    DateTime startOfWeek,
    Map<DateTime, List<EventModel>> events,
  ) sync* {
    for (var i = 0; i < 14; i++) {
      final day = startOfWeek.add(Duration(days: i));
      yield events.entries.singleWhere(
        (entry) => entry.key.isSameDay(day),
        orElse: () => MapEntry(day, const []),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueConnector<_State>(
      onInit: (_) => context.dispatch(
        const FetchEventsAction(EventsFetchType.init),
      ),
      converter: (state) {
        final startOfWeek = state.eventsState.refDate.startOfWeek;
        final filtered = _filterEvents(startOfWeek, state.eventsState.data);
        return _State(startOfWeek, Map.fromEntries(filtered));
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
                final dateListIndex = xIndex + yIndex * 7;
                final date = dates.elementAt(dateListIndex);
                final printMonth = date.day == 1 ||
                    date.day == lastDayOfMonth ||
                    dateListIndex == 0 ||
                    (!isWorkWeek && dateListIndex == 13) ||
                    (isWorkWeek && dateListIndex == 11);

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
                        _focusedDateNotifier,
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
        border: isCurrentDay
            ? const Border(bottom: BorderSide(width: 2, color: accentColor))
            : null,
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
    this.events,
    this.focusedDateNotifier, {
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final List<EventModel> events;
  final ValueNotifier<DateTime?> focusedDateNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime?>(
      valueListenable: focusedDateNotifier,
      builder: (context, focusedDate, child) {
        return GestureDetector(
          onTap: () {
            if (focusedDateNotifier.value != date) {
              focusedDateNotifier.value = date;
            }
          },
          child: ColoredBox(
            color: focusedDate == date
                ? context.td.primaryColorLight
                : context.td.cardColor,
            child: child,
          ),
        );
      },
      child: ListView.builder(
        controller: ScrollController(),
        itemCount: events.length,
        itemBuilder: (context, index) => _Event(events[index]),
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
    this.events,
  );

  final DateTime startOfWeek;
  final Map<DateTime, List<EventModel>> events;

  @override
  List<Object?> get props => [startOfWeek, events];
}
