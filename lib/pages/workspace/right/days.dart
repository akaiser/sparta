import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/event_json.dart';
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

  @override
  Widget build(BuildContext context) {
    return ValueConnector<_State>(
      onInit: (state, dispatch) => dispatch(
        FetchEventsAction(state.eventsState.refDate),
      ),
      converter: (state) => _State(
        state.eventsState.refDate,
        state.eventsState.data,
      ),
      builder: (context, state) {
        final now = DateTime.now();
        final dateFormat = DateFormat.MMMd(context.lc);

        final refDate = state.refDate;
        final startDate = refDate.add(Duration(days: 1 - refDate.weekday));
        final lastDayOfMonth = startDate.lastDayOfMonth.day;
        final dates = List.generate(
          14,
          (it) => startDate.add(Duration(days: it)),
        );

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
                final date = dates[dateListIndex];
                final isCurrentDay = date.isSameDay(now);
                final printMonth = date.day == 1 ||
                    date.day == lastDayOfMonth ||
                    dateListIndex == 0 ||
                    (!isWorkWeek && dateListIndex == 13) ||
                    (isWorkWeek && dateListIndex == 11);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _DayDate(
                      '${printMonth ? dateFormat.format(date) : date.day}',
                      isCurrentDay: isCurrentDay,
                    ),
                    const SizedBox(height: 0.2),
                    Expanded(
                      child: _Day(
                        date,
                        state.events.isNotEmpty
                            ? state.events[dateListIndex].items
                            : [],
                        _focusedDateNotifier,
                        isCurrentDay: isCurrentDay,
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

class _DayDate extends StatelessWidget {
  const _DayDate(
    this.text, {
    required this.isCurrentDay,
    Key? key,
  }) : super(key: key);

  final String text;
  final bool isCurrentDay;

  @override
  Widget build(BuildContext context) {
    final fWeight = isCurrentDay ? FontWeight.bold : FontWeight.normal;
    return ColoredBox(
      color: context.td.highlightColor,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          text,
          textAlign: TextAlign.end,
          style: context.tt.labelSmall.copyWith(fontWeight: fWeight),
        ),
      ),
    );
  }
}

class _Day extends StatelessWidget {
  const _Day(
    this.date,
    this.events,
    this.focusedDateNotifier, {
    required this.isCurrentDay,
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final List<EventJson> events;
  final ValueNotifier<DateTime?> focusedDateNotifier;

  final bool isCurrentDay;

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
                : isCurrentDay
                    ? context.td.primaryColor
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

  final EventJson event;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text('${event.id}')],
    );
  }
}

class _State extends Equatable {
  const _State(this.refDate, this.events);

  final DateTime refDate;
  final List<EventsJson> events;

  @override
  List<Object?> get props => [refDate, events];
}
