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
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final bool printMonth;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentDay = date.isSameDay(now);
    final dateFormat = DateFormat.MMMd(context.lc);
    final fontWeight = isCurrentDay ? FontWeight.bold : FontWeight.normal;

    return ValueConnector2<bool>(
      converter: (state) => date.isSameDay(state.eventsState.focusedDate),
      builder: (context, isFocusedDate, child) => DecoratedBox(
        decoration: BoxDecoration(
          color: isFocusedDate
              ? context.td.secondaryHeaderColor
              : context.td.highlightColor,
          border: isCurrentDay ? currentDayBorder : null,
        ),
        child: child!,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          '${printMonth ? dateFormat.format(date) : date.day}',
          textAlign: TextAlign.end,
          style: context.tt.labelSmall.copyWith(fontWeight: fontWeight),
        ),
      ),
    );
  }
}
