import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/hover_region.dart';
import 'package:sparta/pages/_shared/ui/simple_grid.dart';
import 'package:sparta/states/focussed_date_state.dart';

const _columnCount = 7;
const _rowCount = 6;
const _availableSlots = _rowCount * _columnCount;

class DatePickerBody extends StatelessWidget {
  const DatePickerBody(
    this.pickerDate, {
    Key? key,
  }) : super(key: key);

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
    return SimpleGrid(
      columnCount: _columnCount,
      rowCount: _rowCount,
      expandRows: false,
      cellBuilder: (context, xIndex, yIndex) {
        final cellIndex = xIndex + yIndex * _columnCount;
        final date = dateItems.elementAt(cellIndex);
        return _DateItem(
          date,
          isSameMonth: date.isSameMonth(pickerDate),
          isCurrentDay: date.isSameDay(now),
        );
      },
      leadingOffsetColumnBuilder: (context, yIndex) {
        final textColor = context.td.disabledColor;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '${dateItems.elementAt(yIndex * _columnCount).weekNumber}',
            style: context.tt.labelSmall?.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

class _DateItem extends StatelessWidget {
  const _DateItem(
    this.date, {
    required this.isSameMonth,
    required this.isCurrentDay,
    Key? key,
  })  : _fontWeight = isCurrentDay ? FontWeight.bold : null,
        super(key: key);

  final DateTime date;
  final bool isSameMonth;
  final bool isCurrentDay;

  final FontWeight? _fontWeight;

  @override
  Widget build(BuildContext context) {
    return ValueConnector<bool>(
      converter: (state) => date.isSameDay(state.focussedDateState.focusedDate),
      builder: (context, isFocussedDay, child) {
        return GestureDetector(
          onTap: isFocussedDay
              ? null
              : () => context.store.dispatch(
                    FocusDateAction(
                      date,
                      checkShownEvents: true,
                    ),
                  ),
          child: HoverRegion(
            onHoverCursor: isFocussedDay ? SystemMouseCursors.basic : null,
            builder: (context, isHovering, child) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: isFocussedDay
                      ? context.td.primaryColorDark
                      : !isSameMonth
                          ? context.td.selectedRowColor
                          : null,
                  border: isHovering && !isFocussedDay
                      ? hoverDayBorder
                      : isCurrentDay
                          ? currentDayBorder
                          : null,
                ),
                child: child,
              );
            },
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          '${date.day}',
          textAlign: TextAlign.center,
          style: context.tt.labelSmall?.copyWith(fontWeight: _fontWeight),
        ),
      ),
    );
  }
}
