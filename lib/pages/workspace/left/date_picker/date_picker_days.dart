import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/simple_grid_view.dart';
import 'package:sparta/states/events_state.dart';

const _columnCount = 7;
const _rowCount = 6;
const _availableSlots = _rowCount * _columnCount;

class DatePickerDays extends StatelessWidget {
  const DatePickerDays(this.pickerDate, {Key? key}) : super(key: key);

  final DateTime pickerDate;

  Iterable<DateTime> get _dateItems {
    final items = <DateTime>[];
    var printedSlots = 0;

    final firstDayOfMonth = pickerDate.firstDayOfMonth.midDay;
    for (var i = firstDayOfMonth.weekday - 1; i > 0; i--) {
      items.add(firstDayOfMonth.subtract(Duration(days: i)));
      printedSlots++;
    }

    final lastDayOfMonth = pickerDate.lastDayOfMonth.midDay;
    for (var i = 0; i < lastDayOfMonth.day; i++) {
      items.add(firstDayOfMonth.add(Duration(days: i)));
      printedSlots++;
    }

    final remainingSlots = _availableSlots - printedSlots;
    for (var i = 1; i <= remainingSlots; i++) {
      items.add(lastDayOfMonth.add(Duration(days: i)));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateItems = _dateItems;
    return ValueConnector<_State>(
      converter: (state) => _State(state.eventsState.shownEvents.keys),
      builder: (context, state) => SimpleGridView(
        columnCount: _columnCount,
        rowCount: _rowCount,
        expandRows: false,
        cellBuilder: (context, xIndex, yIndex) {
          final cellIndex = xIndex + yIndex * _columnCount;
          final date = dateItems.elementAt(cellIndex);
          return _DateItem(
            date,
            pickerDate,
            state.shownEventsDates,
            isCurrentDay: date.isSameDay(now),
          );
        },
      ),
    );
  }
}

class _DateItem extends StatelessWidget {
  const _DateItem(
    this.date,
    this.pickerDate,
    this.shownEventsDates, {
    required this.isCurrentDay,
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final DateTime pickerDate;
  final Iterable<DateTime> shownEventsDates;
  final bool isCurrentDay;

  @override
  Widget build(BuildContext context) {
    final fontWeight = isCurrentDay ? FontWeight.bold : FontWeight.normal;

    return ValueConnector2<bool>(
      converter: (state) => date.isSameDay(state.eventsState.focusedDate),
      builder: (context, isFocussedDay, child) {
        return GestureDetector(
          onTap: isFocussedDay
              ? null
              : () => context.dispatch(
                    FetchEventsAction(
                      EventsActionType.picker,
                      focusedDate: date,
                      shouldOverrideRefDate: !shownEventsDates.contains(date),
                    ),
                  ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isFocussedDay
                  ? context.td.focusColor
                  : date.isSameMonth(pickerDate)
                      ? null
                      : context.td.primaryColorLight,
              border: isCurrentDay ? currentDayBorder : null,
            ),
            child: child!,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: Text(
            '${date.day}',
            style: context.tt.labelSmall.copyWith(fontWeight: fontWeight),
          ),
        ),
      ),
    );
  }
}

class _State extends Equatable {
  const _State(this.shownEventsDates);

  final Iterable<DateTime> shownEventsDates;

  @override
  List<Object?> get props => [shownEventsDates];
}
