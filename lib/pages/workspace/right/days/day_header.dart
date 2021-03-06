import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';

class DayHeader extends StatelessWidget {
  const DayHeader(
    this.date, {
    required this.printMonth,
    required this.printWeekNumber,
    required this.isCurrentDay,
    super.key,
  }) : _fontWeight = isCurrentDay ? FontWeight.bold : null;

  final DateTime date;
  final bool printMonth;
  final bool printWeekNumber;
  final bool isCurrentDay;

  final FontWeight? _fontWeight;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.MMMd(context.lc);
    return ValueConnector<bool>(
      converter: (state) => date.isSameDay(state.focussedDateState.focusedDate),
      builder: (context, isFocusedDate, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: isFocusedDate
                ? context.td.primaryColorDark
                : context.td.highlightColor,
            border: isCurrentDay
                ? currentDayBorder
                : Border(
                    right: BorderSide(color: context.td.dividerColor),
                    top: BorderSide(color: context.td.dividerColor),
                  ),
          ),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            if (printWeekNumber)
              _Text(
                '${date.weekNumber}',
                fontColor: context.td.disabledColor,
              ),
            Expanded(
              child: _Text(
                '${printMonth ? dateFormat.format(date) : date.day}',
                textAlign: TextAlign.right,
                overflow: TextOverflow.fade,
                softWrap: false,
                fontWeight: _fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(
    this.text, {
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.fontColor,
    this.fontWeight,
  });

  final String text;

  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softWrap;
  final Color? fontColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      style: context.tt.labelSmall?.copyWith(
        color: fontColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
