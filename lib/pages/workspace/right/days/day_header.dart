import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/color.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';
import 'package:sparta/pages/_shared/models/category_model.dart';
import 'package:sparta/pages/_shared/models/day_event_model.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/workspace/right/days/category_badge.dart';

class DayHeader extends StatelessWidget {
  const DayHeader(
    this.date, {
    required this.isCurrentDay,
    required this.printWeekNumber,
    required this.printMonth,
    required this.dayEvents,
    super.key,
  }) : _fontWeight = isCurrentDay ? FontWeight.bold : null;

  final DateTime date;
  final bool isCurrentDay;
  final bool printWeekNumber;
  final bool printMonth;
  final Iterable<DayEventModel> dayEvents;

  final FontWeight? _fontWeight;

  List<MapEntry<CategoryModel, Iterable<CategoryModel>>>
      get _groupedCategories => dayEvents
          .fold(
            <CategoryModel>[],
            (previous, current) => previous..addAll(current.categories),
          )
          .groupBy((categoryModel) => categoryModel)
          .entries
          .toList()
        ..sort((a, b) => a.value.length.compareTo(b.value.length));

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.MMMd(context.lc);
    final groupedCategories = _groupedCategories;
    return ValueConnector<bool>(
      converter: (state) => date.isSameDay(state.focussedDayState.focusedDate),
      builder: (context, isFocusedDate, child) => DecoratedBox(
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
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 2, top: 1, right: 2),
        child: Row(
          children: [
            if (printWeekNumber)
              _Text(
                '${date.weekNumber}',
                fontColor: context.td.disabledColor,
              ),
            if (groupedCategories.isNotEmpty) ...[
              if (printWeekNumber) const SizedBox(width: 2),
              ...groupedCategories
                  .map<Widget>(
                    (entry) => CategoryBadge(
                      entry.key.color,
                      child: _Text(
                        '${entry.value.length}',
                        fontColor: entry.key.color.visibleTextColor,
                      ),
                    ),
                  )
                  .separate(const SizedBox(width: 2)),
            ],
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
  Widget build(BuildContext context) => Text(
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
