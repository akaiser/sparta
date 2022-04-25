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

class DatePicker extends StatelessWidget {
  const DatePicker(this.pickerDate, {Key? key}) : super(key: key);

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
    // TODO check usage of this
    return ValueConnector<DateTime?>(
      converter: (state) => state.eventsState.focusedDate,
      builder: (context, focusedDate) => SimpleGridView(
        columnCount: _columnCount,
        rowCount: _rowCount,
        expandRows: false,
        cellBuilder: (context, xIndex, yIndex) {
          final cellIndex = xIndex + yIndex * _columnCount;
          final date = dateItems.elementAt(cellIndex);
          return _DateItem(
            date,
            isCurrentDay: date.isSameDay(now),
            isFocussedDay: date.isSameDay(focusedDate),
            isSamePickedDateMonth: date.month == pickerDate.month,
          );
        },
      ),
    );
  }
}

class _DateItem extends StatelessWidget {
  const _DateItem(
    this.date, {
    required this.isCurrentDay,
    required this.isFocussedDay,
    required this.isSamePickedDateMonth,
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final bool isCurrentDay;
  final bool isFocussedDay;
  final bool isSamePickedDateMonth;

  @override
  Widget build(BuildContext context) {
    final fontWeight = isCurrentDay ? FontWeight.bold : FontWeight.normal;

    return GestureDetector(
      onTap: isFocussedDay
          ? null
          : () => context.dispatch(
                FetchEventsAction(
                  EventsActionType.picker,
                  focusedDate: date,
                ),
              ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isFocussedDay
              ? context.td.focusColor
              : isSamePickedDateMonth
                  ? null
                  : context.td.primaryColorLight,
          border: isCurrentDay ? currentDayBorder : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Center(
            child: Text(
              '${date.day}',
              style: context.tt.labelSmall.copyWith(fontWeight: fontWeight),
            ),
          ),
        ),
      ),
    );
  }
}
